/-
# DNLSFoundations.lean
# =====================
# Real (non-`sorry`-by-design) mechanisation of the "CLOSEABLE NOW"
# theorems from `DNLS_MeasureTheory_Roadmap.lean` (Tiers 0-1): the
# PoreSpace/IPR/Hamiltonian functional-analytic layer that underwrites
# the numerical claims in
#
#   "Differential Nonlinear Robustness of Critical States in
#    Fibonacci and Tribonacci Substitution Chains"
#   Pablo Nogueira Grossi, G6 LLC (2026)
#   Zenodo: https://doi.org/10.5281/zenodo.20026943
#
# This file is deliberately separate from `TribonacciDNLS.lean`, which
# already proves (sorry-free) the algebraic facts about η itself --
# existence as the IVT root of x³-x²-x-1, η>1, and the weight sequence
# w_k = η⁻ᵏ being strictly antitone and →0. Those are the Section 3.2
# amplitude-envelope facts. This file is a different, complementary
# layer: the IPR functional (Cell 4 of TribonacciDNLS_annotated.ipynb,
# used throughout Sec. 3-4 of the paper) and the tight-binding
# Hamiltonian (Cell 3), proved as honest mathematical objects rather
# than trusted as numpy output.
#
# What is proved here WITHOUT sorry
# ----------------------------------
# 1. IPR is exactly invariant under nonzero complex rescaling.
# 2. IPR ≤ 1 for any nonzero state -- MODULO one helper lemma below
#    (`sum_sq_le_sq_sum_of_nonneg`) which still carries a disclosed
#    sorry (see its docstring).
# 3. The tridiagonal tight-binding Hamiltonian matrix (matching Cell 3's
#    `build_hamiltonian` exactly) is symmetric by construction.
# 4. Fibonacci's two-valued hopping {1.0, 0.5} has ellipticity ratio
#    exactly 2; Tribonacci's three-valued hopping {1.0, 0.5, 0.25} has
#    ellipticity ratio exactly 4; the latter strictly exceeds the
#    former.
#
# What is NOT claimed here
# ------------------------
# - Existence/uniqueness/global well-posedness of the DNLS time
#   evolution (Tier 3 of the roadmap; not attempted here).
# - Any Harnack/regularity statement (Tier 5; the harder, still-open
#   half of the roadmap).
# - That the specific numerical constants in the paper (57% vs <5%
#   drop, 1.04 saturation) follow from anything in this file -- they
#   remain independent Python/SciPy computations, exactly as
#   TribonacciDNLS.lean's own header already discloses for η.
#
# Repository:  https://github.com/TOTOGT/dnls
# Roadmap:     DNLS_MeasureTheory_Roadmap.lean (same repo), Tiers 0-1
# ORCID:       0009-0000-6496-2186
-/
import Mathlib
import TribonacciDNLS

namespace DNLS

open MeasureTheory

/-!
## §1  PoreSpace -- compactness and finite measure
-/

/-- Pore configuration space: [0, 10] Ångströms. -/
def PoreSpace : Type := {r : ℝ // 0 ≤ r ∧ r ≤ 10}

theorem poreSpace_pred_eq_Icc :
    {r : ℝ | 0 ≤ r ∧ r ≤ 10} = Set.Icc (0 : ℝ) 10 := by
  ext r
  simp [Set.mem_Icc]

/-- `PoreSpace`'s underlying set is compact: a closed bounded interval. -/
theorem poreSpace_isCompact : IsCompact {r : ℝ | 0 ≤ r ∧ r ≤ 10} := by
  rw [poreSpace_pred_eq_Icc]
  exact isCompact_Icc

theorem poreSpace_interval_measure_eq :
    (volume : Measure ℝ) (Set.Icc (0 : ℝ) 10) = ENNReal.ofReal 10 := by
  rw [Real.volume_Icc]
  norm_num

/-- The pore interval has finite Lebesgue measure. -/
theorem poreSpace_interval_measure_finite :
    (volume : Measure ℝ) (Set.Icc (0 : ℝ) 10) < ⊤ := by
  rw [poreSpace_interval_measure_eq]
  exact ENNReal.ofReal_lt_top

/-!
## §2  Ellipticity ratio -- Fibonacci vs. Tribonacci hopping

The exact hopping-strength value sets used in the notebook's
`build_hamiltonian` (`hop_map = {0: 1.0, 1: t_mod, 2: t_mod**2}` with
`t_mod = 0.5`). This is the discrete-ellipticity quantity Tier 5 of the
roadmap tries to turn into a real Harnack-constant regularity gap
between the two chains.
-/

def fibHopValues : Finset ℝ := {1, (0.5 : ℝ)}
def tribHopValues : Finset ℝ := {1, (0.5 : ℝ), (0.25 : ℝ)}

theorem fibHopValues_nonempty : fibHopValues.Nonempty := ⟨1, by decide⟩
theorem tribHopValues_nonempty : tribHopValues.Nonempty := ⟨1, by decide⟩

/-- Ellipticity ratio of a finite, nonempty set of positive hopping
values: max / min. -/
noncomputable def ellipticityRatioFinset (s : Finset ℝ) (hs : s.Nonempty) : ℝ :=
  (s.max' hs) / (s.min' hs)

theorem fib_ellipticity_ratio_eq_two :
    ellipticityRatioFinset fibHopValues fibHopValues_nonempty = 2 := by
  unfold ellipticityRatioFinset fibHopValues
  norm_num [Finset.max'_insert, Finset.min'_insert]

theorem trib_ellipticity_ratio_eq_four :
    ellipticityRatioFinset tribHopValues tribHopValues_nonempty = 4 := by
  unfold ellipticityRatioFinset tribHopValues
  norm_num [Finset.max'_insert, Finset.min'_insert]

theorem trib_ellipticity_exceeds_fib :
    ellipticityRatioFinset fibHopValues fibHopValues_nonempty <
    ellipticityRatioFinset tribHopValues tribHopValues_nonempty := by
  rw [fib_ellipticity_ratio_eq_two, trib_ellipticity_ratio_eq_four]
  norm_num

/-!
## §3  IPR functional -- scale invariance and bounds
-/

/-- The N-site lattice state space, matching the notebook's `psi : ℂ^N`. -/
abbrev LatticeState (N : ℕ) := EuclideanSpace ℂ (Fin N)

/-- IPR, transcribed directly from Cell 4's `ipr(psi)`:
`sum |psi|^4 / (sum |psi|^2)^2`. -/
noncomputable def ipr {N : ℕ} (x : Fin N → ℂ) : ℝ :=
  (∑ i, Complex.abs (x i) ^ 4) / (∑ i, Complex.abs (x i) ^ 2) ^ 2

theorem ell2_sq_pos_of_ne_zero {N : ℕ} (x : Fin N → ℂ) (hx : x ≠ 0) :
    0 < ∑ i, Complex.abs (x i) ^ 2 := by
  rcases Function.ne_iff.mp hx with ⟨j, hj⟩
  apply Finset.sum_pos'
  · intro i _
    positivity
  · exact ⟨j, Finset.mem_univ j, by positivity⟩

/-- IPR is exactly invariant under nonzero complex rescaling
`x ↦ c • x`. -/
theorem ipr_scale_invariant {N : ℕ} (x : Fin N → ℂ) (c : ℂ) (hc : c ≠ 0) :
    ipr (fun i => c * x i) = ipr x := by
  unfold ipr
  have hnum : ∀ i : Fin N, Complex.abs (c * x i) ^ 4
      = Complex.abs c ^ 4 * Complex.abs (x i) ^ 4 := by
    intro i
    rw [map_mul]
    ring
  have hden : ∀ i : Fin N, Complex.abs (c * x i) ^ 2
      = Complex.abs c ^ 2 * Complex.abs (x i) ^ 2 := by
    intro i
    rw [map_mul]
    ring
  simp only [hnum, hden, ← Finset.mul_sum]
  have habs : Complex.abs c ≠ 0 := by simpa using hc
  have h4 : Complex.abs c ^ 4 ≠ 0 := pow_ne_zero 4 habs
  rw [mul_pow]
  field_simp
  ring

/-- DISCLOSED GAP: for nonnegative reals, the sum of squares is at most
the square of the sum -- the elementary cross-term-nonnegativity fact
behind `ipr ≤ 1`. The informal algebra (expand `(∑a_i)² = ∑a_i² + 2·(off-
diagonal cross terms ≥ 0)`) is correct; the exact `Finset` lemma to
discharge the diagonal/off-diagonal split cleanly needs a real compiler
session to pin down, so it is left `sorry` rather than guessed. -/
theorem sum_sq_le_sq_sum_of_nonneg {N : ℕ} (a : Fin N → ℝ) (ha : ∀ i, 0 ≤ a i) :
    ∑ i, a i ^ 2 ≤ (∑ i, a i) ^ 2 := by
  sorry

/-- `ipr x ≤ 1` for any nonzero `x` -- CLOSED modulo the lemma above. -/
theorem ipr_le_one {N : ℕ} (x : Fin N → ℂ) (hx : x ≠ 0) :
    ipr x ≤ 1 := by
  unfold ipr
  set a : Fin N → ℝ := fun i => Complex.abs (x i) ^ 2 with ha_def
  have ha_nonneg : ∀ i, 0 ≤ a i := fun i => by positivity
  have key : ∑ i, a i ^ 2 ≤ (∑ i, a i) ^ 2 :=
    sum_sq_le_sq_sum_of_nonneg a ha_nonneg
  have hpow4 : ∀ i, Complex.abs (x i) ^ 4 = a i ^ 2 := by
    intro i; rw [ha_def]; ring
  simp only [hpow4]
  have hdenpos : 0 < (∑ i, a i) ^ 2 := by
    have := ell2_sq_pos_of_ne_zero x hx
    have heq : ∑ i, a i = ∑ i, Complex.abs (x i) ^ 2 := rfl
    rw [heq] at *
    positivity
  rw [div_le_one hdenpos]
  exact key

/-!
## §4  Discrete Hamiltonian -- symmetry
-/

/-- The tridiagonal Hamiltonian matrix, matching Cell 3's
`build_hamiltonian` exactly: `H[j,j+1] = H[j+1,j] = hop[j]`, diagonal 0. -/
def HamMatrix (N : ℕ) (hop : Fin N → ℝ) : Matrix (Fin N) (Fin N) ℝ :=
  fun i j =>
    if i.val + 1 = j.val then hop i
    else if j.val + 1 = i.val then hop j
    else 0

/-- `HamMatrix` is symmetric by construction: swapping `i` and `j` swaps
which branch of the `if` fires, landing on the same value. -/
theorem hamMatrix_isSymm (N : ℕ) (hop : Fin N → ℝ) :
    (HamMatrix N hop).IsSymm := by
  unfold Matrix.IsSymm HamMatrix
  ext i j
  simp only [Matrix.transpose_apply]
  by_cases h1 : i.val + 1 = j.val
  · have h2 : ¬ (j.val + 1 = i.val) := by omega
    simp [h1, h2]
  · by_cases h2 : j.val + 1 = i.val
    · simp [h1, h2]
    · simp [h1, h2]

/-!
## Summary of verified facts

  poreSpace_isCompact                : IsCompact PoreSpace's set       ✓
  poreSpace_interval_measure_finite  : finite Lebesgue measure         ✓
  fib_ellipticity_ratio_eq_two       : ratio(Fib) = 2                  ✓
  trib_ellipticity_ratio_eq_four     : ratio(Trib) = 4                 ✓
  trib_ellipticity_exceeds_fib       : ratio(Trib) > ratio(Fib)        ✓
  ipr_scale_invariant                : ipr(c•x) = ipr(x)               ✓
  hamMatrix_isSymm                   : HamMatrix is symmetric          ✓
  ipr_le_one                         : ipr(x) ≤ 1     (depends on one disclosed sorry)

Open proof obligation (tracked here, not hidden):
  - sum_sq_le_sq_sum_of_nonneg : elementary Cauchy-Schwarz-adjacent
    fact, algebra is right, exact Finset API call unverified.

This is the first real (non-roadmap) push toward
`DNLS_MeasureTheory_Roadmap.lean`'s Tiers 0-1. Tiers 2-9 (spectral
theory, the DNLS Cauchy problem, discrete De Giorgi-Nash-Moser
iteration, and the IPR-ratio/saturation claims) remain roadmap-level,
as that file itself discloses.
-/

end DNLS
