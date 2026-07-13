# CURATION-MANIFEST.md — file reorganization, 2026-07-12

Companion to `CLAUDE.md` §0b (`REPO-MAP.md`) and `V4_MANIFEST.md` (the Zenodo
deposit manifest — do not confuse the two: this file documents the *git repo*
layout; `V4_MANIFEST.md` documents what ships in the *Zenodo deposit*).

This pass follows the house rule in `CLAUDE.md`: **never delete — move stale
files to `_archive/` and write a manifest noting what moved and why.**
Nothing described below was deleted. Everything that moved is still on disk.

---

## New structure

| Folder | Contents |
|---|---|
| `code/` | Active Python: simulation drivers, figure generators, analysis scripts |
| `data/` | CSVs: IPR time series, finite-size-scaling data |
| `figures/` | The 9 numbered figures (`fig1`–`fig9`, `.pdf`+`.png`) matching the paper |
| `figures/working/` | Pre-relabel intermediate figures (`fig_A`–`fig_D`, `fig_fss_*`, `fig_long_*`) — kept, not archived, because `V4_MANIFEST.md`'s own provenance table cites these by name as the source of the relabeled fig6–fig9 |
| `paper/` | All paper generations: `nbonacci_dnls_paper*`, `paper_v3*`, `paper_v4*`, `section_4_7.tex` |
| `notes/` | Copilot briefs, `notes_for_claude.md`, `vscode_prompts.md`, outline/skeleton fragments, `gumroad_listing.md`, `prb_cover_letter.md` — process artifacts, not deliverables |
| `_archive/` | Confirmed duplicates / superseded files (see below) — preserved, not deleted |
| `criticality_paper/` | Untouched (already had its own structure + README); the two root-level `DM3*Criticality_Grossi2026_v2.pdf` files were moved in here to co-locate with the sub-paper they belong to |
| `TribonacciDNLS.lean`, `FoldEvents.lean`, `DNLSFoundations.lean`, `DNLS_MeasureTheory_Roadmap.lean`, `lakefile.lean`, `lean-toolchain` | Left at repo root, **not** moved into a `lean/` subfolder as `V4_MANIFEST.md` proposes for the Zenodo bundle. Lake's module-resolution expects `import Foo` to find `Foo.lean` at the package root; moving them would break the Lake project set up on `feature/dnls-foundations-lean`. The Zenodo deposit script can still copy these into `lean/` at packaging time — that's a deposit-assembly step, not a repo-layout one. |
| root (`CLAUDE.md`, `README_v3.md`, `REPO-MAP.md`, `REPO-MAP.csv`, `V4_MANIFEST.md`, `V4_README.md`, `V4_zenodo_description.md`, `TODO_v4_overnight.md`) | Untouched |

---

## What moved to `_archive/`, and why

| File | Reason |
|---|---|
| `dnls_long_time copy.py` | Byte-identical (md5 `4c786667a161386aba285799481c90e6`) to `code/dnls_long_time_axle.py`. Finder-generated duplicate name; the properly-named `_axle.py` copy is kept. |
| `generate_figures_v1.py` | Superseded. `V4_MANIFEST.md`'s own provenance note records the V2 checksum of the *unpatched* `generate_figures.py` as `60a000296bac3c26bae74a060f44f708`; the current `code/generate_figures.py` hashes to `a679c37660b95b1fa765adccd0179866` — i.e. it IS the patched version the manifest says V4 should ship. `generate_figures_v1.py` is the pre-patch predecessor. |
| `_perm_test` | 0-byte file, dated 2026-05-05, no reference anywhere in `REPO-MAP.md`, `CLAUDE.md`, or either manifest. Looks like a leftover permissions-check artifact. |

Nothing else was archived. Every other Python/CSV/figure file in `REPO-MAP.md`'s
§8 inventory is accounted for in `code/`, `data/`, or `figures/`.

---

## Findings that need your call, not mine

I did **not** unilaterally resolve these. Flagging per `CLAUDE.md` §9
("flag stale DOIs," "flag deposit claims unsupported by deposited code").

1. **`V4_MANIFEST.md` appears to cite the wrong paper version.** It was
   written 2026-05-07 and describes the Zenodo V4 deposit (DOI
   `10.5281/zenodo.20075822`) as containing `paper_v3.tex`/`.pdf`. But
   `paper/paper_v4.tex` exists, dated 2026-05-09 (two days later), and its
   own title page explicitly says *"Version 4 — finite-size scaling,
   long-time evolution, and self-trapping threshold gap"* and cites the
   **same** V4 DOI (`10.5281/zenodo.20075822`). That strongly suggests
   `paper_v4.tex` is the real, later-written text for the V4 deposit, and
   `V4_MANIFEST.md`'s file list is now one draft behind. I did not edit
   `V4_MANIFEST.md` — didn't want to guess at a Zenodo deposit's actual
   contents. Worth a five-minute check before your next deposit push.

2. **Two non-identical `DM3*Criticality_Grossi2026_v2.pdf` files** (now
   both in `criticality_paper/`) — `DM3.Criticality_Grossi2026_v2.pdf`
   (1,304,345 bytes) and `DM3Criticality_Grossi2026_v2.pdf` (1,327,946
   bytes), compiled 23 minutes apart on 2026-05-12. Different hashes, so
   this isn't a Finder-duplicate situation — one is a real revision of the
   other, but I can't tell which is authoritative without reading both.
   Left both in place.

3. **Four Book-3 website HTML files sitting at repo root**
   (`chapter-eta-dnls.html`, `chapter_eta.html`, `chapters-ladder.html`,
   `impa-portal.html`) don't belong to a DNLS-research code repo at all —
   they're Book 3 chapter/site pages. `REPO-MAP.md` §11 already flagged
   `impa-portal.html` here specifically as (surprisingly) the newest
   canonical copy across your whole machine, ahead of the AXLE and
   Documents copies. That's a cross-project call (does it move to
   `geometry`/AXLE, or does this repo keep hosting it?) that's bigger than
   today's cleanup — left untouched at root, not archived.

---

*Nothing above required deleting a single file. If any archived-file call
looks wrong, say so and I'll move it back.*
