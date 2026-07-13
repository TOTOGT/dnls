# Cover Letter — Physical Review B Submission

**To:** Editor, Physical Review B
**From:** Pablo Nogueira Grossi · G6 LLC · Newark, NJ · pgrossi888@outlook.com · ORCID 0009-0000-6496-2186
**Re:** Submission of *Differential Nonlinear Robustness of Critical States in Fibonacci and Tribonacci Substitution Chains*
**Date:** [fill in submission date]

---

Dear Editor,

I am submitting the enclosed manuscript, *Differential Nonlinear Robustness of Critical States in Fibonacci and Tribonacci Substitution Chains*, for consideration as a **Regular Article** in *Physical Review B*. The manuscript reports, to our knowledge, the first numerical study of the discrete nonlinear Schrödinger (DNLS) equation on a tribonacci substitution chain, and identifies a qualitative difference in nonlinear response between the n=2 (Fibonacci) and n=3 (Rauzy–tribonacci) substitution-generated quasicrystal models.

## Summary of the result

Starting from mid-gap eigenstates of the linear tight-binding Hamiltonian on each chain, we integrate the DNLS time evolution over nonlinearity strengths λ ∈ [0, 10]. In the linear limit, the tribonacci chain's mid-gap inverse participation ratio (IPR) is approximately four times that of the Fibonacci chain — consistent with the stronger multifractality of Rauzy fractal eigenstates. Under nonlinear perturbation, the asymmetry sharpens: the Fibonacci mid-gap state delocalizes rapidly, losing approximately 57% of its IPR at λ=1.5, while the tribonacci state remains nearly pinned, with under 5% IPR loss at the same coupling. We term this phenomenon *differential nonlinear robustness* and argue that the tribonacci chain's stronger multifractal spectrum provides greater effective resistance to nonlinear delocalization.

## Why this is appropriate for *Physical Review B*

The manuscript bridges three currently active threads in PRB's coverage:
1. **Multifractal localization in quasiperiodic systems** — Macé, Jagannathan & Piéchon (PRB 2016, 93:205134), Krebbekx, Moustaj, Dajani & Morais Smith (PRB 2023, 108:104204).
2. **Nonlinear and DNLS dynamics on aperiodic lattices** — Lahini et al. (PRL 2009, 103:013901), Flach, Ivanchenko & Kanakov (PRE 2010, 82:036219).
3. **Topological/photonic quasicrystal experiments** — Kraus et al. (PRL 2012, 109:106402), Verbin et al. (PRB 2015, 91:064201), Jürgensen et al. (Nature 2021, 596:63).

The result speaks directly to the nonlinear-robustness side of these threads, and the n=2 vs n=3 contrast invites experimental tests in photonic-lattice platforms that have already implemented the Fibonacci case.

## Companion artifacts

A complete reproducibility bundle is openly archived: Python simulation code, the long-time DOP853 evolver, figure-generating scripts, output data, and a Lean 4/Mathlib4 verification of the algebraic spine (η > 1 and strict antitonicity of η⁻ᵏ — both `sorry`-free) are deposited at:

> Zenodo: [10.5281/zenodo.20026942](https://doi.org/10.5281/zenodo.20026942) (concept DOI; latest version V4)

The Lean file `TribonacciDNLS.lean` builds against Mathlib4 without `sorry`, `axiom`, or `admit`. Source is mirrored at the GitHub repositories `TOTOGT/AXLE` and `grossi-ops/Atratores`, both linked from the deposit. We invite the editorial board to verify reproducibility independently if useful.

## Suggested referees

Per PRB's referee suggestion form, we offer the following names as natural choices given the technical proximity of their published work:
1. N. Macé (Université Toulouse III) — multifractality on Fibonacci chains.
2. A. Jagannathan (Université Paris-Saclay) — quasiperiodic tight-binding.
3. N. Krebbekx (Utrecht) — direct predecessor on tribonacci multifractality.
4. D. Damanik (Rice) — spectral theory of Fibonacci Hamiltonians.
5. S. Flach (IBS Daejeon) — DNLS spreading in aperiodic potentials.

## Statements

* The manuscript has not been submitted elsewhere and is not under consideration by any other journal.
* All authors (sole author: P. Nogueira Grossi) have read and approved the submission.
* No competing interests are declared.
* The work was carried out independently at G6 LLC; no external funding to disclose.
* The associated software is released under MIT (code) and CC-BY-NC-ND-4.0 (prose); both licenses are explicit in the Zenodo deposit.

We thank the editorial office in advance for considering the work, and look forward to hearing from your reviewers.

Sincerely,
Pablo Nogueira Grossi
G6 LLC, Newark NJ
[pgrossi888@outlook.com](mailto:pgrossi888@outlook.com)

---

*Edit before submission:* tweak the section "Why this is appropriate for PRB" if you want a different framing (e.g., rapid communication vs regular article, Fibonacci–tribonacci comparison vs n-bonacci ladder writ large). Also confirm the suggested referees feel right.
