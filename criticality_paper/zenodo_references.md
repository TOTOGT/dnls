# Reference strings — criticality paper deposit `10.5281/zenodo.20077205`

Two sets:
1. **Citations FOR this paper** (paste into other documents, citation managers, social posts).
2. **References FROM this paper** (paste into Zenodo's *References* sidebar field, one per line).

---

## Part 1 — How others should cite this paper

### BibTeX

```bibtex
@misc{NogueiraGrossi2026Criticality,
  author       = {Nogueira Grossi, Pablo},
  title        = {{Criticality Thresholds in One-Dimensional
                   Multiplying Media with $n$-Bonacci Aperiodic
                   Modulation: Spectral Gap Control of $k_{\mathrm{eff}}$
                   in Substitution-Sequence Diffusion Operators}},
  year         = {2026},
  publisher    = {Zenodo},
  doi          = {10.5281/zenodo.20077205},
  url          = {https://doi.org/10.5281/zenodo.20077205},
  note         = {G6 LLC, Newark, NJ, USA. ORCID 0009-0000-6496-2186.}
}
```

### Plain text (AMS / journal-ready)

> P.~Nogueira Grossi, *Criticality Thresholds in One-Dimensional Multiplying Media with $n$-Bonacci Aperiodic Modulation: Spectral Gap Control of $k_{\mathrm{eff}}$ in Substitution-Sequence Diffusion Operators*, G6 LLC (2026). Zenodo: doi:10.5281/zenodo.20077205.

### APA-style

> Nogueira Grossi, P. (2026). *Criticality thresholds in one-dimensional multiplying media with n-bonacci aperiodic modulation: Spectral gap control of k_eff in substitution-sequence diffusion operators*. G6 LLC. Zenodo. https://doi.org/10.5281/zenodo.20077205

### Markdown link (for blog posts, X, GitHub READMEs)

```
[Nogueira Grossi (2026), *Criticality Thresholds … with n-Bonacci Aperiodic Modulation*, Zenodo, doi:10.5281/zenodo.20077205](https://doi.org/10.5281/zenodo.20077205)
```

### Short tag (for footnotes / inline citations)

> Nogueira Grossi 2026 (Zenodo, [10.5281/zenodo.20077205](https://doi.org/10.5281/zenodo.20077205))

---

## Part 2 — References FROM this paper (for Zenodo's *References* sidebar)

Paste one per line into the *References* field. The paper's `.tex` bibliography has 19 entries; below they are reformatted as plain text in the order they appear in the .tex.

```
Bellissard, J., Iochum, B., Scoppola, E., and Testard, D. (1989). Spectral properties of one-dimensional quasi-crystals. Commun. Math. Phys. 125, 527–543.

Brent, R. P. (1973). Algorithms for Minimization without Derivatives. Prentice-Hall, Englewood Cliffs, NJ.

Damanik, D. (2017). Schrödinger operators with dynamically defined potentials. Ergodic Theory Dynam. Systems 37, 1681–1764.

Duderstadt, J. J., and Hamilton, L. J. (1976). Nuclear Reactor Analysis. Wiley, New York.

Nogueira Grossi, P. (2026). Differential Nonlinear Robustness of Critical States in Fibonacci and Tribonacci Substitution Chains. G6 LLC. Zenodo (concept DOI, auto-resolves to latest version). https://doi.org/10.5281/zenodo.20026942

Kohmoto, M., Kadanoff, L. P., and Tang, C. (1983). Localization problem in one dimension: Mapping and escape. Phys. Rev. Lett. 50, 1870–1872.

Ostlund, S., Pandit, R., Rand, D., Schellnhuber, H. J., and Siggia, E. D. (1983). One-dimensional Schrödinger equation with an almost periodic potential. Phys. Rev. Lett. 50, 1873–1876.

Luck, J. M. (1989). Cantor spectra and scaling of gap widths in deterministic aperiodic systems. Phys. Rev. B 39, 5834–5849.

Macé, N., Jagannathan, A., and Piéchon, F. (2016). Fractal dimensions of wave functions and local spectral measures on the Fibonacci chain. Phys. Rev. B 93, 205134.

Damanik, D., and Gorodetski, A. (2009). Hyperbolicity of the trace map for the weakly coupled Fibonacci Hamiltonian. Nonlinearity 22, 123–143.

Rauzy, G. (1982). Nombres algébriques et substitutions. Bull. Soc. Math. France 110, 147–178.

Flach, S., Ivanchenko, M. V., and Kanakov, O. I. (2010). Spreading of wave packets in one-dimensional disordered lattices. Phys. Rev. E 82, 036219.

Nogueira Grossi, P. (2026). Atratores: numerical code repository. GitHub. https://github.com/grossi-ops/Atratores/tree/main/DNLS

Krebbekx, J. P. J., Moustaj, A., Dajani, K., and de Morais Smith, C. (2023). Multifractal properties of tribonacci chains. Phys. Rev. B 108, 104204. https://doi.org/10.1103/PhysRevB.108.104204

Allaire, G., and Bal, G. (1999). Homogenization of the criticality spectral equation in neutron transport. ESAIM: Math. Model. Numer. Anal. 33, 721–746.

Varma, V. K., de Tomasi, C., and Müller, M. (2019). Diffusion in quasiperiodic Fibonacci chains. Phys. Rev. B 100, 085105.

Shechtman, D., Blech, I., Gratias, D., and Cahn, J. W. (1984). Metallic phase with long-range orientational order and no translational symmetry. Phys. Rev. Lett. 53, 1951–1953.

Squires, G. L. (1978). Introduction to the Theory of Thermal Neutron Scattering. Cambridge University Press, Cambridge.

Stacey, W. M. (2007). Nuclear Reactor Physics, 2nd ed. Wiley-VCH, Weinheim.
```

---

## One pre-publish bibliography fix worth catching

The `.tex` source's `\bibitem{Grossi2026DNLS}` currently cites the DNLS paper at **`10.5281/zenodo.20032853`** (that's V2, deposited 5 May). The current authoritative pointer is the **concept DOI `10.5281/zenodo.20026942`** (auto-resolves to V4, `20075822`). Same staleness pattern we caught and patched in the `criticality_paper/README.md` earlier. To fix it in the .tex before the final deposit recompile, the surgical edit is:

```latex
% find:
Version~2, G6 LLC (2026), Zenodo.
\href{https://doi.org/10.5281/zenodo.20032853}{doi:10.5281/zenodo.20032853}.

% replace with:
G6 LLC (2026), Zenodo (concept DOI, auto-resolves to latest version).
\href{https://doi.org/10.5281/zenodo.20026942}{doi:10.5281/zenodo.20026942}.
[V4 pin: \href{https://doi.org/10.5281/zenodo.20075822}{doi:10.5281/zenodo.20075822}.]
```

That's a one-line `sed`/Edit on `nbonacci_diffusion_draft.tex`, recompile, replace the PDF in the Zenodo draft. I've already used the corrected concept-DOI form in the *References from this paper* block above, so the Zenodo sidebar will be self-consistent even if the .tex isn't recompiled before publish — but the in-paper bibliography should match.

---

## Related-identifier strings for the Zenodo sidebar

The *Related identifiers* metadata field on the Zenodo *Edit* form takes pairs of (relation, identifier). The four to add:

| Relation | Identifier | Type |
|---|---|---|
| `isRelatedTo` | `10.5281/zenodo.20026942` | DOI · DNLS concept (companion paper, auto-resolves to latest) |
| `isRelatedTo` | `10.5281/zenodo.20075822` | DOI · DNLS V4 (latest pin of the companion) |
| `isDerivedFrom` | `10.5281/zenodo.19199474` | DOI · Wavenumber 6 (parent framework deposit) |
| `isSupplementedBy` | `https://github.com/TOTOGT/AXLE` | URL · code/proof mirror |

In Zenodo's UI, click *+ Add related identifier* four times, paste each row.
