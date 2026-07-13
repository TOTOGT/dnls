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
# 2. IPR ≤ 1 for any nonzero state. (The helper lemma
#    `sum_sq_le_sq_sum_of_nonneg` that earlier drafts left as a
#    disclosed sorry is now discharged by Mathlib's
#    `Finset.sum_sq_le_sq_sum_of_nonneg`.)
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

-- `noncomputable` because `Finset ℝ` literals go through `insert`,
-- which needs `Real.decidableEq` (classical, not executable).
noncomputable def fibHopValues : Finset ℝ := {1, (0.5 : ℝ)}
noncomputable def tribHopValues : Finset ℝ := {1, (0.5 : ℝ), (0.25 : ℝ)}

-- (`decide` cannot evaluate membership in a `Finset ℝ`; `simp` proves
-- nonemptiness of an `insert` structurally.)
theorem fibHopValues_nonempty : fibHopValues.Nonempty := by
  simp [fibHopValues]
theorem tribHopValues_nonempty : tribHopValues.Nonempty := by
  simp [tribHopValues]

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
  (∑ i, ‖x i‖ ^ 4) / (∑ i, ‖x i‖ ^ 2) ^ 2

theorem ell2_sq_pos_of_ne_zero {N : ℕ} (x : Fin N → ℂ) (hx : x ≠ 0) :
    0 < ∑ i, ‖x i‖ ^ 2 := by
  rcases Function.ne_iff.mp hx with ⟨j, hj⟩
  refine Finset.sum_pos' (fun i _ => by positivity) ?_
  exact ⟨j, Finset.mem_univ j, pow_pos (norm_pos_iff.mpr hj) 2⟩

/-- IPR is exactly invariant under nonzero complex rescaling
`x ↦ c • x`. -/
theorem ipr_scale_invariant {N : ℕ} (x : Fin N → ℂ) (c : ℂ) (hc : c ≠ 0) :
    ipr (fun i => c * x i) = ipr x := by
  unfold ipr
  have hnum : ∀ i : Fin N, ‖c * x i‖ ^ 4 = ‖c‖ ^ 4 * ‖x i‖ ^ 4 := by
    intro i
    rw [norm_mul]
    ring
  have hden : ∀ i : Fin N, ‖c * x i‖ ^ 2 = ‖c‖ ^ 2 * ‖x i‖ ^ 2 := by
    intro i
    rw [norm_mul]
    ring
  have h4 : (‖c‖ : ℝ) ^ 4 ≠ 0 := pow_ne_zero 4 (norm_pos_iff.mpr hc).ne'
  simp only [hnum, hden, ← Finset.mul_sum]
  -- `mul_div_mul_left` cancels `‖c‖⁴` even when the remaining
  -- denominator is zero (the `x = 0` case), which `field_simp` cannot.
  rw [mul_pow, show ((‖c‖ : ℝ) ^ 2) ^ 2 = ‖c‖ ^ 4 by ring,
    mul_div_mul_left _ _ h4]

/-- For nonnegative reals, the sum of squares is at most the square of
the sum. Earlier drafts disclosed this as a `sorry` because the exact
`Finset` API call was unverified without a compiler; it turns out
Mathlib has it verbatim as `Finset.sum_sq_le_sq_sum_of_nonneg`. -/
theorem sum_sq_le_sq_sum_of_nonneg {N : ℕ} (a : Fin N → ℝ) (ha : ∀ i, 0 ≤ a i) :
    ∑ i, a i ^ 2 ≤ (∑ i, a i) ^ 2 :=
  Finset.sum_sq_le_sq_sum_of_nonneg fun i _ => ha i

/-- `ipr x ≤ 1` for any nonzero `x` -- now fully CLOSED (no sorry). -/
theorem ipr_le_one {N : ℕ} (x : Fin N → ℂ) (hx : x ≠ 0) :
    ipr x ≤ 1 := by
  unfold ipr
  have key : ∑ i, ‖x i‖ ^ 4 ≤ (∑ i, ‖x i‖ ^ 2) ^ 2 := by
    calc ∑ i, ‖x i‖ ^ 4 = ∑ i, (‖x i‖ ^ 2) ^ 2 :=
          Finset.sum_congr rfl fun i _ => by ring
      _ ≤ (∑ i, ‖x i‖ ^ 2) ^ 2 :=
          sum_sq_le_sq_sum_of_nonneg (fun i => ‖x i‖ ^ 2) (fun i => by positivity)
  have hdenpos : 0 < (∑ i, ‖x i‖ ^ 2) ^ 2 :=
    pow_pos (ell2_sq_pos_of_ne_zero x hx) 2
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
  ipr_le_one                         : ipr(x) ≤ 1                      ✓

No open proof obligations remain in this file: the former disclosed
sorry (`sum_sq_le_sq_sum_of_nonneg`) is discharged by Mathlib's
`Finset.sum_sq_le_sq_sum_of_nonneg`.

This is the first real (non-roadmap) push toward
`DNLS_MeasureTheory_Roadmap.lean`'s Tiers 0-1. Tiers 2-9 (spectral
theory, the DNLS Cauchy problem, discrete De Giorgi-Nash-Moser
iteration, and the IPR-ratio/saturation claims) remain roadmap-level,
as that file itself discloses.
-/

end DNLS
