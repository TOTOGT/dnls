# Chapter η — The Tribonacci Holds
## Outline for the Gumroad PDF companion (Principia Orthogona house style)

**Length target:** ~20 pages, navy/gold/cream Principia Orthogona aesthetic, Georgia/Times serif body, JetBrains Mono for code and labels, gold left-border accents on theorem blocks.
**Voice:** Reader's-guide, not reprint. Annotated. Show the thinking, not just the answer.
**Reading time:** ~45 minutes.
**Reader:** technically literate but not necessarily an expert in quasiperiodic localization or Lean 4.

---

## Front matter (~2 pages)

**Cover** — navy field, gold η sigil centered, headline "Chapter η — The Tribonacci Holds." Subhead: "A Principia Orthogona companion to *Differential Nonlinear Robustness of Critical States in Fibonacci and Tribonacci Substitution Chains*." Author line, DOI footer.

**Series page** — where Chapter η sits in the n-bonacci ladder. Visual: a vertical chain of Greek letters from the recurrence ladder; η highlighted. One paragraph explaining how the chapters relate: each is a rung, n=2 is the Fibonacci ground floor, n=3 is η, n=4 is the tetrabonacci preview, etc.

**Two epigraphs** —
> *"Two quasicrystals. Same physics. Completely different fate under nonlinear perturbation."*
> — adapted from the Instagram caption
>
> *"The structure of the spectrum buys you resistance you didn't pay for."*
> — author's note

---

## §1 — The picture before the math (~2 pages)

A non-technical opener. Two visual analogies:

**Analogy 1: woven fabric.** Fibonacci is a 2-thread weave (A–B–A–A–B–…). Tribonacci is a 3-thread weave (A–B–A–C–A–B–…). Both look quasiperiodic. They behave differently under stress.

**Analogy 2: pluck a string.** A critical state on each chain is like a string plucked at one specific overtone. Add a nonlinear coupling — a self-interaction proportional to local intensity squared. The Fibonacci string slips off the overtone fast. The tribonacci string holds.

Quote one sentence from the abstract. State the two numbers (57% / <5% at λ=1.5). Done.

---

## §2 — The substitution rules and the chains (~2 pages)

Now the reader needs the actual definitions. Compact:

**Substitution rules:**
- Fibonacci (n=2): `A → AB`, `B → A`. Iterate from `A` → `AB` → `ABA` → `ABAAB` → ...
- Tribonacci / Rauzy (n=3): `A → AB`, `B → AC`, `C → A`. Iterate from `A` → `AB` → `ABAC` → `ABACABAC...` (visual)

**Hopping pattern.** The chain is a 1D tight-binding model where each letter labels a bond strength: t_A = 1.0, t_B = 0.5, t_C = 0.25 (the geometric ladder t_k = (t_mod)^k with t_mod = 0.5).

**Visual:** the substitution-tree figure (fig5) on a full-width page, with annotations explaining how each generation produces the next.

---

## §3 — Mid-gap critical eigenstates (~3 pages)

What's a "mid-gap critical state" and why does it matter?

**The eigenvalue problem.** Build the tridiagonal Hamiltonian on a finite chain (N=500). Diagonalize. Find the eigenstate closest to E=0 — the *mid-gap* state. Plot |ψ_j|² vs site j.

**Visual:** the eigenstate panel (fig2), Fibonacci on top, tribonacci below. Caption: notice how the tribonacci state has fewer, sharper peaks. That's multifractality with a higher effective spectral dimension.

**Why "critical".** Neither localized (exponential decay) nor extended (constant amplitude). The amplitude profile has fractal scaling — IPR ~ N^{-D₂} with 0 < D₂ < 1. For Fibonacci, D₂ ≈ 0.5–0.8 depending on the gap. For tribonacci, D₂ is smaller (more localized in the multifractal sense), and the IPR is correspondingly larger.

**Concrete numbers.** At N=500: IPR_fib ≈ 0.021, IPR_trib ≈ 0.082. Ratio ≈ 4. This is the linear-limit baseline.

---

## §4 — Add a nonlinearity (~3 pages)

Now turn on the DNLS interaction:
$$
i \frac{d\psi_j}{dt} = -\sum_{j'} H_{jj'} \psi_{j'} + \lambda |\psi_j|^2 \psi_j
$$

The nonlinear term λ|ψ_j|² ψ_j is the focusing coupling: it tries to bunch amplitude where amplitude already lives. Two competing forces — the linear hopping tries to spread, the nonlinearity tries to concentrate.

**The integration.** Take the linear mid-gap state as the initial condition. Evolve to T = 50 (RK45 in the original paper; T = 10⁵ in the long-time extension). Track IPR(t) and average over a late window.

**Visual:** fig3 (IPR vs λ at T=50). Annotate the λ=1.5 vertical line. Show ΔIPR for each chain.

**The differential robustness.** Fibonacci IPR drops from 0.021 → 0.009 (≈57% loss). Tribonacci IPR holds 0.082 → 0.078 (<5% loss). Same coupling, same time window, same numerical method. The structural difference is doing the work.

**Why?** The simplest read: stronger multifractality means more spectrally isolated peaks, fewer resonant channels for the nonlinearity to scatter the amplitude *into*. The tribonacci spectrum is harder to mix nonlinearly because it has more gaps in the right places. (This is a heuristic; the formal mechanism is still open — see §6.)

---

## §5 — The Lean 4 proof, in plain English (~3 pages)

The algebraic spine of the result is a single number: η ≈ 1.839287, the Perron–Frobenius eigenvalue of the tribonacci companion matrix. Three claims about η are formally verified in Lean 4:

**Claim 1: η > 1.** The tribonacci recurrence x_{n+3} = x_{n+2} + x_{n+1} + x_n grows. The sequence never shrinks below an exponential. Formalized as `eta_gt_one`.

**Claim 2: η is the unique real root > 1 of x³ − x² − x − 1 = 0.** The companion matrix has one real eigenvalue > 1 and two complex-conjugate eigenvalues inside the unit disk. Formalized as part of the spectral content of `TribonacciDNLS.lean`.

**Claim 3: η^{-k} is strictly decreasing in k.** The geometric ladder of bond strengths t_A, t_B, t_C is well-defined and ordered. This is the falsifiability hook for any phenomenon claimed to scale with η^{-k}. Formalized as `eta_pow_neg_strict_anti`.

**What `sorry`-free means.** Lean refuses to compile the file if any step is hand-waved. Every claim is checked against Mathlib4's library of definitions and theorems. No appeal to authority, no "left as an exercise."

**Visual:** an annotated extract of the Lean code with side comments translating each line to plain English.

**What's still open.** Two hooks added to the AXLE sorry roadmap by this paper:
1. The IPR inequality `IPR_trib(0) > IPR_fib(0)` from the spectral-dimension inequality (Krebbekx et al. 2023).
2. A Lean-4 statement of the differential nonlinear robustness threshold itself.

These are open verification problems, not open mathematical conjectures — they're known true; they just need formalization.

---

## §6 — Open questions (~2 pages)

The result above is a numerical first step. Five questions are tracked for the paper, summarized here for the reader who wants to push:

1. **Longer time evolution.** The original paper integrated to T=50. The companion deposit's V4 includes T=10⁵ data. Subdiffusive spreading typically becomes visible at T ~ 10³–10⁵ (Flach 2010). Whether the differential robustness persists at much longer times — or eventually erodes — is the most urgent open question.
2. **Finite-size scaling.** Does the IPR ratio ≈ 4 hold at N = 200, 500, 1000, 2000? V4's `fig7_fss_T1e4` is a partial answer.
3. **Spreading exponent α.** Compute ⟨r²⟩(t) ~ t^α for both chains. Compare to Lahini et al. (2009) for Fibonacci. Test whether the tribonacci α is genuinely smaller. V4's `fit_alpha.py` is the producing script.
4. **Self-trapping threshold λ_c(n).** A systematic amplitude scan to map the boundary between subdiffusive spreading and self-trapping for each n.
5. **n = 4 (tetrabonacci) and beyond.** Does the differential robustness compound? Is there an η_4 ≈ 1.927 analog with even better resistance? This is the natural next rung.

---

## §7 — How to reproduce everything (~1 page)

A lean reference card.

```bash
git clone https://github.com/grossi-ops/Atratores
cd Atratores/dnls
pip install numpy scipy matplotlib
python code/generate_figures.py        # figs 1–5
python code/dnls_long_time.py          # ipr_vs_time.csv (~13 min)
python code/generate_figures_v3.py     # figs 6–9
python code/fit_alpha.py               # alpha exponent
cd lean && lake build                   # Lean 4 verification
```

---

## §8 — Where this sits (~1 page)

Closing reflection. The η rung is one observation in a longer ladder. The *Principia Orthogona* program asks what each rung tells you about the structure underneath. The tribonacci result says: structural complexity buys nonlinear stability. There's a generalization here — a metric on substitution complexity that predicts robustness — but it's open. The book series will work it out.

If you read this far, you might want:
- The [main paper on Zenodo](https://doi.org/10.5281/zenodo.20026942)
- The [Principia Orthogona series](https://g6llc.gumroad.com)
- Volume IV (Atratores Helicoidais), the bridge to the wider geometric setting

End with the Instagram-card slogan as a reprise:
> *Not all quasicrystals age the same.*
> *Tribonacci holds. Fibonacci folds.*

---

## Production notes

- **Cover, table of contents, copyright page.** Standard Principia Orthogona front matter. Use the existing template from Volume I.
- **Figures.** All come from the V4 deposit. Reuse, don't redraw. Add side-margin annotations in the chapter PDF (the deposit's figures are clean for the paper; the chapter version gets extra commentary).
- **Theorem boxes.** Gold left-border, cream fill, navy text. Use for: the IPR ratio claim, the η > 1 statement, the differential robustness statement.
- **Falsifiability boxes.** Same shape, navy left-border. Use for the open questions (each one stated as a *what would falsify it* prompt).
- **Code blocks.** JetBrains Mono, dark navy background, gold syntax accents.
- **Bibliography.** Mirror the paper's bib file. No new references needed in the chapter.

## Files this outline produces

When the chapter is written:
- `chapter_eta.tex` (or .md → .pdf via pandoc + house template)
- `chapter_eta.pdf` (~2–4 MB with embedded figures)
- `chapter_eta.ipynb` (Jupyter narrative companion — same structure as §§ 2–5 above, runnable)
- `TribonacciDNLS_annotated.lean` (the deposit `.lean` file with extra inline comments for non-Lean readers)
