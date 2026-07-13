# VS Code / Copilot prompts — V4 morning push

Paste each section below verbatim into a new GitHub Copilot agent task on the indicated repo. Each prompt is self-contained — the agent does not have access to this conversation. Run them in the order given; later prompts depend on earlier ones landing.

The two existing briefs (`copilot_t1e5_run_brief.md`, `copilot_followup_brief.md`) cover Lane A.1 and a previous defaults alignment. The prompts below cover the rest of Lane A plus the paper revision.

---

## Prompt 1 — Repo: `grossi-ops/Atratores`
### Title: "DNLS: emit deposit-facing fig{6,7,8,9}_*.pdf filenames directly"

You are working on `grossi-ops/Atratores`. The goal of this task is to eliminate a manual relabeling step that is currently required between two scripts and the V4 Zenodo deposit.

### Context

The V3 Zenodo deposit advertises four figures with these filenames:
- `fig6_d2_natural.pdf`
- `fig7_fss_T1e4.pdf`
- `fig8_ratio_collapse.pdf`
- `fig9_T1e6_saturation.pdf`

The producing scripts on `main` write to different canonical filenames:
- `paper_figures.py` produces `fig_A_d2_scaling.png`, `fig_B_nstability.png`, `fig_C_inversion.png`, `fig_D_homogenization.png`.
- `analyze_long_time.py` produces `fig_long_ipr_vs_t.png` (and a few other diagnostic PNGs).

The relabeling has previously been done by hand and is documented in `DNLS/V4_DESCRIPTION.md`. We want to remove the hand step.

### Branch
`copilot/v4-fig-naming`

### Tasks

1. In `paper_figures.py`, change each `plt.savefig(out_path)` call so it writes BOTH a PNG (existing canonical name) and a PDF (deposit-facing name). The mapping is:
   - `fig_A_d2_scaling.png` → also write `fig6_d2_natural.pdf`
   - `fig_B_nstability.png` → also write `fig7_fss_T1e4.pdf`
   - `fig_D_homogenization.png` → also write `fig8_ratio_collapse.pdf`
   - `fig_C_inversion.png` is NOT a deposit figure but should still emit `fig_C_inversion.pdf` for completeness.

2. In `analyze_long_time.py`, after the existing `fig_long_ipr_vs_t.png` is written, also save the same figure as `fig9_T1e6_saturation.pdf`. Add a comment at that line: `# fig9 is the deposit-facing name; provenance: see DNLS/V4_DESCRIPTION.md`.

3. Update `DNLS/V4_DESCRIPTION.md` to reflect that the relabeling is no longer manual — it is now intrinsic to the scripts.

4. Run both scripts at least once after the change, confirm the PDFs land on disk, commit the rendered PDFs to `DNLS/figures/`.

### Do NOT

- Do not change the contents of any figure (axis ranges, colors, titles, data tables embedded in the script). Only the output paths.
- Do not delete the existing PNG outputs. They are kept for backwards compatibility with the working notebooks.
- Do not change `dnls_long_time.py` or `dnls_nbonacci.py`.
- Do not introduce new dependencies.

### Deliverable

Open a single PR titled exactly *"DNLS: emit deposit-facing fig{6,7,8,9}_*.pdf filenames directly"*. The PR description should include:
- the diff summary (line count per file),
- a screenshot or `ls DNLS/figures/` showing the new PDFs,
- a one-line confirmation that the manual relabel step is no longer required.

---

## Prompt 2 — Repo: `grossi-ops/Atratores`
### Title: "DNLS: split licensing — MIT for code, CC-BY-NC-ND-4.0 for prose"

You are working on `grossi-ops/Atratores`. The goal is to fix a licensing inconsistency that currently prevents anyone from legally running or modifying the deposited Python and Lean code.

### Context

The Zenodo deposits at `10.5281/zenodo.20026942` (concept) currently apply CC-BY-NC-ND-4.0 to all included files. The "ND" (no-derivatives) clause makes it illegal to fork, modify, or rerun the `.py` and `.lean` code. We want a split: MIT for code, CC-BY-NC-ND-4.0 for prose.

### Branch
`copilot/v4-license-split`

### Tasks

1. Add `DNLS/LICENSE-CODE` containing the standard MIT license text, with copyright line:
   ```
   Copyright (c) 2026 Pablo Nogueira Grossi, G6 LLC
   ```

2. Add `DNLS/LICENSE-PROSE` containing the standard CC-BY-NC-ND-4.0 license text, attributed to the same.

3. To the docstring (top of file) of every `.py` file in `DNLS/` — `dnls_nbonacci.py`, `dnls_long_time.py`, `analyze_long_time.py`, `paper_figures.py`, `generate_figures.py` if present — append a single line:
   ```
   License: MIT (see DNLS/LICENSE-CODE)
   ```
   Replace any existing `License:` line. Do not modify any other content of the docstring.

4. To the top header comment of every `.lean` file in `DNLS/` (or any directory in this repo containing `.lean` files for this paper), append a similar line:
   ```
   -- License: MIT (see DNLS/LICENSE-CODE)
   ```

5. Update `DNLS/V4_DESCRIPTION.md` (and the top-level `DNLS/README.md` if one exists) with a "Licenses" section explaining the split.

### Do NOT

- Do not change any code. Only docstring/comment header lines and new LICENSE files.
- Do not apply MIT to `.tex`, `.pdf`, or `.md` files.
- Do not apply CC-BY-NC-ND to `.py`, `.lean`, `.ipynb`.

### Deliverable

PR titled *"DNLS: split licensing — MIT for code, CC-BY-NC-ND-4.0 for prose"* with the diff summary and a screenshot of the rendered LICENSE files in GitHub's preview.

---

## Prompt 3 — Repo: `TOTOGT/AXLE`
### Title: "Add TribonacciDNLS.lean and FoldEvents.lean under lean/"

You are working on `TOTOGT/AXLE`, the Lean 4 formal-verification engine. Two `.lean` files supporting the tribonacci DNLS paper need to be canonical here so that the paper's "formally verified in Lean 4 / Mathlib4 without sorry" claim is supported by an actual GitHub-resolvable path.

### Branch
`copilot/v4-add-tribonacci-dnls`

### Tasks

1. Create the directory `lean/` if it does not exist.

2. Add the file `lean/TribonacciDNLS.lean` with the contents of the same-named file in `grossi-ops/Atratores/DNLS/lean/TribonacciDNLS.lean` (or wherever it lives in Atratores). If the file is not present in Atratores, fail loudly — do NOT fabricate content.

3. Add the file `lean/FoldEvents.lean` similarly.

4. Add `lean/README.md` with one short table per file:
   - File name, what it proves (in plain English), and explicit `sorry`/`axiom`/`admit` count (run `grep -cE '\b(sorry|axiom|admit)\b'` on each file's *code*, excluding comment blocks).
   - A line: *"All files build against Mathlib4 with `lake build`."*

5. Verify: `lake build` from the repo root succeeds and reports zero errors. If it fails, do not merge — open the PR in DRAFT state and document the failure in the PR description.

6. Tag a release `v0.1-tribonacci-dnls` after merge so the V4 Zenodo deposit can pin to a stable commit hash.

### Do NOT

- Do not edit the contents of `TribonacciDNLS.lean` or `FoldEvents.lean`. Copy them verbatim.
- Do not add other Lean files in this PR.
- Do not delete or restructure existing AXLE content.

### Deliverable

PR titled *"Add TribonacciDNLS.lean and FoldEvents.lean under lean/"* with the diff and a screenshot of `lake build` succeeding. After merge, tag the release.

---

## Prompt 4 — Repo: `grossi-ops/Atratores`
### Title: "DNLS: integrate Section 8 prose from skeleton"

You are working on `grossi-ops/Atratores`. The goal is to convert a markdown skeleton into a final LaTeX section that can be inserted into the paper's master `.tex` file.

### Context

The file `DNLS/section8_skeleton.md` contains a paragraph-level draft of Section 8 ("Long-time dynamics and finite-size scaling") in markdown. We need it as proper LaTeX, with figure callouts using the deposit-facing fig6–fig9 filenames, and inserted into the paper's master `.tex`.

### Branch
`copilot/v4-section-8`

### Tasks

1. Read `DNLS/section8_skeleton.md`.

2. Convert each subsection (8.1 Methodology, 8.2 Linear-limit multifractal dimensions, 8.3, 8.4, etc. as present in the skeleton) into LaTeX:
   - `## 8.1 …` becomes `\subsection{…}`
   - Bullets become a `\begin{itemize}` block with `\item`s.
   - `**Headline.**` paragraphs stay as bold opening sentences.
   - Math expressions (e.g. `D₂_fib = 0.62 ± δ_fib`) translate to inline math (`$D_2^{\text{fib}} = 0.62 \pm \delta_{\text{fib}}$`).
   - **TODO:** markers in the skeleton are converted to `\todo{...}` if the master .tex uses the `todonotes` package, otherwise to `% TODO: …` comments.

3. Replace any figure callout in the skeleton with a proper `\includegraphics{fig6_d2_natural}` etc., using the deposit-facing names.

4. Insert the new `\section{…} … \subsection{…} …` block into the appropriate place in `DNLS/paper/nbonacci_dnls_paper_v3.tex` (or whatever the master file is called for paper_v3). It should sit AFTER the original Section 7 (Open Questions) but BEFORE the Conclusion. Renumber the Conclusion to Section 9 if needed.

5. Recompile the paper and verify the resulting PDF includes the new Section 8 with figures rendered. Commit both the updated `.tex` and the recompiled `.pdf`.

### Do NOT

- Do not modify content of Sections 1–7. The new section is purely additive.
- Do not delete or rewrite the skeleton file. Leave it in place as historical reference.
- Do not change the paper's macro definitions, fonts, or bibliography style.

### Deliverable

PR titled *"DNLS: integrate Section 8 prose from skeleton"* with: (i) the new `.tex` block, (ii) the recompiled `.pdf`, (iii) a one-line summary of the page count change.

---

## Prompt 5 — Repo: `grossi-ops/Atratores`
### Title: "DNLS: canonical folder layout and top-level README"

You are working on `grossi-ops/Atratores`. The goal is to restructure the `DNLS/` subfolder so it matches the V4 deposit layout exactly. After this PR, the deposit upload should be a `git archive` away.

### Branch
`copilot/v4-folder-layout`

### Tasks

1. Move files in `DNLS/` to the following structure (using `git mv` to preserve history):
   ```
   DNLS/
   ├── README.md                        ← see step 2
   ├── MANIFEST.md                      ← see step 3
   ├── LICENSE-CODE                     ← from prompt 2
   ├── LICENSE-PROSE                    ← from prompt 2
   ├── V4_DESCRIPTION.md                ← keep at root, it's the deposit description
   ├── code/
   │   ├── dnls_nbonacci.py
   │   ├── dnls_long_time.py
   │   ├── generate_figures.py
   │   ├── paper_figures.py
   │   └── analyze_long_time.py
   ├── data/
   │   ├── ipr_vs_time.csv              (from copilot_t1e5_run_brief.md execution)
   │   └── spreading_exponents.csv      (from same)
   ├── figures/
   │   ├── fig1_chain_structure.pdf … fig9_T1e6_saturation.pdf
   │   └── fig_A_*.png … fig_D_*.png    (canonical PNGs preserved)
   ├── lean/
   │   ├── TribonacciDNLS.lean          (canonical home is TOTOGT/AXLE; this is a mirror)
   │   └── FoldEvents.lean
   └── paper/
       ├── nbonacci_dnls_paper_v3.tex
       ├── refs.bib
       └── nbonacci_dnls_paper_v3.pdf
   ```

2. Author `DNLS/README.md` using the content of `~/Desktop/dnls/V4_README.md` from the user's local working folder (the user will paste this into the PR comment for you, or you can read it from the linked Cowork session). It should be the top-level reader's guide with the figure-to-script mapping, license note, citation, and reproduction instructions.

3. Author `DNLS/MANIFEST.md` similarly using `~/Desktop/dnls/V4_MANIFEST.md`. It should contain the file-by-file provenance and checksums.

4. Update internal references in any script that points at a moved path (most should already use relative `./figures/` per the patched `generate_figures.py`).

5. Run all four scripts (`dnls_nbonacci.py`, `generate_figures.py`, `paper_figures.py`, `analyze_long_time.py`) after the move and confirm they still produce identical figure outputs. Commit nothing if outputs differ — file an issue.

### Do NOT

- Do not delete files outside `DNLS/`. Other parts of the Atratores repo (Vol. IV / cajueiro material) are out of scope.
- Do not commit large data files (>10 MB) to the repo. If `ipr_vs_time.csv` is larger, use Git LFS or attach to the Zenodo deposit only.
- Do not change file contents during the move beyond fixing path references.

### Deliverable

PR titled *"DNLS: canonical folder layout and top-level README"*. PR description includes: tree of the new layout, line count of `README.md` and `MANIFEST.md`, list of any broken references that were fixed.

---

## Prompt 6 (optional) — Repo: any of TOTOGT or grossi-ops
### Title: "Add CLAUDE.md house rules"

You are adding a standing brief for AI agents working on this repo.

### Branch
`copilot/add-claude-md`

### Tasks

1. Create a top-level `CLAUDE.md` with the contents of the user's local `~/Desktop/dnls/CLAUDE.md` (the user will paste it into the PR comment).

2. Verify it renders correctly in GitHub's markdown preview.

3. Commit only `CLAUDE.md`. No other changes.

### Do NOT

- Do not modify the file's content. The author maintains it.
- Do not add it as `.github/CLAUDE.md` or any other path. Top-level only.

### Deliverable

PR titled *"Add CLAUDE.md house rules"*, one file added.

---

## Sequencing

```
Prompt 1 (fig naming, ~5 min)
Prompt 2 (license split, ~5 min)
Prompt 3 (Lean to AXLE, ~10 min, different repo)
Prompt 4 (Section 8 prose, ~15 min, depends on Prompt 1 fig names landing)
Prompt 5 (folder layout, ~10 min, depends on Prompts 1, 2, 4)
Prompt 6 (CLAUDE.md, optional, can run any time)
```

Total Copilot wall time: ~45 min, but most of it is the agent's time, not yours. You wait, you review the PRs as they open, you click merge.

After all PRs land, the V4 deposit upload is mechanical — drag-drop the files from a fresh clone of `grossi-ops/Atratores/DNLS/` into Zenodo's *New version* form. ~10 min.
