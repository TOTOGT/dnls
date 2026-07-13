# Zenodo description — paste-ready
**Record:** `10.5281/zenodo.20077205`
**Title:** Criticality Thresholds in One-Dimensional Multiplying Media with n-Bonacci Aperiodic Modulation — Spectral Gap Control of $k_{\rm eff}$ in Substitution-Sequence Diffusion Operators
**Author:** Pablo Nogueira Grossi · G6 LLC, Newark NJ · ORCID 0009-0000-6496-2186
**License (recommended):** CC-BY-4.0 (single deposit-wide license so code is reusable)

---

## Description (paste into the *Description* field)

> <p>We study the one-group neutron diffusion equation on a uniform one-dimensional slab whose material coefficients — diffusion constant, removal cross-section, and fission production rate — vary site-by-site according to the n-bonacci substitution sequence for n = 2, 3, 4, 5. The criticality condition k<sub>eff</sub> = 1 defines a critical fission strength &lambda;<sub>c</sub>(n), which we compute by solving the associated generalized eigenvalue problem L &phi; = (1/k) F &phi; via finite differences.</p>
>
> <p><strong>Headline result.</strong> &lambda;<sub>c</sub>(n) is governed not by the n-bonacci constant &rho;<sub>n</sub> alone, but by the <em>spectral gap</em> of the substitution transfer matrix, &Delta;<sub>n</sub> = &rho;<sub>n</sub> &minus; |&rho;<sub>n</sub><sup>(2)</sup>|, where &rho;<sub>n</sub><sup>(2)</sup> is the subdominant root of the characteristic polynomial x<sup>n</sup> = x<sup>n&minus;1</sup> + &middot;&middot;&middot; + 1. Numerically, &lambda;<sub>c</sub>(n) &asymp; 0.958&middot;&Delta;<sub>n</sub> + 0.107 with correlation r = 0.989 across n = 2,&hellip;,5. For n &ge; 4, &lambda;<sub>c</sub>(n) converges to 7/6 exactly; the Tribonacci case n = 3 saturates at the distinct value &lambda;<sub>c</sub>(3) &asymp; 37/32, while &lambda;<sub>c</sub>(2) &asymp; 1.064 for Fibonacci.</p>
>
> <p><strong>What's in this deposit (12 files, ~2 MB total).</strong> Every figure and every numerical claim in the paper traces back to a producing script in this bundle:</p>
>
> <ul>
>   <li><code>nbonacci_diffusion_draft_v1.pdf</code> — the 14-page V1 paper, including Section 3 (Transfer-Matrix Spectral Theory) that derives the spectral-gap mechanism behind the empirical fit.</li>
>   <li><code>nbonacci_diffusion_draft.tex</code> — LaTeX source. Recompiles to the deposited PDF.</li>
>   <li><code>README.md</code> — top-level reader's guide with the figure → script map, license, citation block.</li>
>   <li><code>nbonacci_criticality.py</code> — <strong>core solver.</strong> Builds the loss matrix L and fission matrix F via finite differences on the substitution-modulated slab; computes k<sub>eff</sub> as the dominant eigenvalue of L<sup>&minus;1</sup>F. Includes Fibonacci/Tribonacci word generators and per-generation k<sub>eff</sub>(&lambda;) sweeps.</li>
>   <li><code>nbonacci_critical_lambda.py</code> — <strong>headline result generator.</strong> Bisects on k<sub>eff</sub>(&lambda;) = 1 across n = 2&hellip;5 to extract &lambda;<sub>c</sub>(n), then tests whether the empirical fit follows the n-bonacci constant or the spectral gap. Produces the 0.958&middot;&Delta;<sub>n</sub>+0.107 correlation and the 7/6 saturation observation.</li>
>   <li><code>generate_all_figures.py</code> — <strong>figure pipeline.</strong> Renders the five figures the paper references (chain structure, k<sub>eff</sub> vs &lambda;, &lambda;<sub>c</sub> vs &Delta;<sub>n</sub>, generation-convergence of k<sub>eff</sub>, fundamental flux modes). Self-contained: data tables embedded in the script.</li>
>   <li><code>AutophagyDm3.lean</code> — <strong>formal companion (sorry-free).</strong> Lean 4 / Mathlib4 verification of the two analytic lemmas the dm³ contact-geometry framework underpinning Section 3 leans on: (i) non-degeneracy of the contact form &alpha; = dz &minus; &rho;<sup>2</sup>d&theta; for &rho; &gt; 0, (ii) the Whitney A<sub>1</sub> fold condition for V(q) = q<sup>3</sup> &minus; 3q. Builds against Mathlib4 with no <code>sorry</code>, <code>axiom</code>, or <code>admit</code>.</li>
>   <li><code>fig1_chain_structure.png</code> — substitution-word visualization for Fibonacci and Tribonacci chains.</li>
>   <li><code>fig2_keff_vs_lambda.png</code> — k<sub>eff</sub> as a function of fission strength &lambda; at Fibonacci generations 4, 6, 8.</li>
>   <li><code>fig3_lambda_c_gap.png</code> — &lambda;<sub>c</sub>(n) plotted against the spectral gap &Delta;<sub>n</sub> with the linear fit 0.958&middot;&Delta;<sub>n</sub> + 0.107 (r = 0.989).</li>
>   <li><code>fig4_convergence.png</code> — convergence of k<sub>eff</sub> with substitution generation for Fibonacci and Tribonacci.</li>
>   <li><code>fig5_flux_profiles.png</code> — fundamental flux modes &phi;(x) for Fibonacci generations 5 and 8.</li>
> </ul>
>
> <p><strong>Reproducing every claim from scratch.</strong> Install Python 3.10+ with NumPy, SciPy, Matplotlib. From the deposit root: <code>python3 generate_all_figures.py</code> regenerates all five figures from embedded data; <code>python3 nbonacci_critical_lambda.py</code> reproduces the &lambda;<sub>c</sub>(n) sweep and the spectral-gap correlation; <code>python3 nbonacci_criticality.py</code> exposes the per-generation k<sub>eff</sub> sweep. For the Lean companion: <code>lake build</code> against Mathlib4 verifies <code>AutophagyDm3.lean</code> compiles with zero <code>sorry</code>.</p>
>
> <p><strong>Companion deposit.</strong> This paper is the criticality-side counterpart to the nonlinear (DNLS) dynamics study on Fibonacci and Tribonacci chains: P. Nogueira Grossi, "Differential Nonlinear Robustness of Critical States in Fibonacci and Tribonacci Substitution Chains" (Zenodo concept DOI <a href="https://doi.org/10.5281/zenodo.20026942">10.5281/zenodo.20026942</a>; latest version V4 at <a href="https://doi.org/10.5281/zenodo.20075822">10.5281/zenodo.20075822</a>). Both papers identify the spectral gap &Delta;<sub>n</sub> as the load-bearing control parameter — for the DNLS study, the gap raises the self-trapping threshold; for the present study, the gap sets &lambda;<sub>c</sub>(n). The convergence of two independent physical models (nonlinear quantum dynamics and classical neutron transport) on the same spectral-gap lever constitutes the primary cross-paper finding.</p>
>
> <p><strong>License.</strong> CC-BY-4.0 for the entire deposit, allowing reuse, modification, and redistribution with attribution. Code files (<code>*.py</code>, <code>*.lean</code>) and prose (<code>*.pdf</code>, <code>*.tex</code>, <code>*.md</code>) under the same permissive license — code reproducibility is non-negotiable for this work.</p>

---

## Suggested metadata fields (Zenodo *Edit* form sidebar)

| Field | Value |
|---|---|
| Resource type | Publication → Preprint |
| Title | *Criticality Thresholds in One-Dimensional Multiplying Media with n-Bonacci Aperiodic Modulation: Spectral Gap Control of k_eff in Substitution-Sequence Diffusion Operators* |
| Authors | Nogueira Grossi, Pablo · G6 LLC · ORCID 0009-0000-6496-2186 |
| Publication date | (today's date) |
| License | CC-BY-4.0 |
| Keywords | n-bonacci, substitution sequence, neutron diffusion, criticality, k-effective, spectral gap, transfer matrix, Fibonacci, Tribonacci, Tetrabonacci, Pentanacci, finite differences, Lean 4 verification, dm³ framework |
| Related identifiers | `isRelatedTo` → 10.5281/zenodo.20026942 (DNLS concept DOI, companion paper); `isRelatedTo` → 10.5281/zenodo.20075822 (DNLS V4 pin); `isSupplementedBy` → github.com/TOTOGT/AXLE; `isDerivedFrom` → 10.5281/zenodo.19199474 (Wavenumber 6) |
| References | Add bibliography entries for the DNLS papers cited in the .tex |
| Communities | Add to any *Principia Orthogona* community you maintain |

---

## Citation block (paste into the *Citation* field)

```
Nogueira Grossi, P. (2026). Criticality Thresholds in One-Dimensional Multiplying
Media with n-Bonacci Aperiodic Modulation: Spectral Gap Control of k_eff in
Substitution-Sequence Diffusion Operators. G6 LLC.
Zenodo. https://doi.org/10.5281/zenodo.20077205
```

---

## Pre-publish sanity check

- [ ] Title matches the .tex (with subtitle)
- [ ] Description = the Variant text above
- [ ] License = CC-BY-4.0
- [ ] All 12 files uploaded (paper + tex + README + 3 .py + 1 .lean + 5 fig PNGs); older 685 KB pre-spectral PDF NOT in deposit
- [ ] Related identifiers added (DNLS concept + V4 + GitHub + Wavenumber 6)
- [ ] Keywords populated
- [ ] DOI on title page of the PDF reads `10.5281/zenodo.20077205` (already correct per audit)
- [ ] *Publish* button clicked → DOI goes live publicly (currently the public API still returns 404)
