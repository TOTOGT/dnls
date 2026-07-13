# _archive/MANIFEST.md — Book 3 site files rehomed to geometry, 2026-07-12

These four files are Book 3 website pages, not DNLS research code — they
never belonged in this repo. Per Pablo's direction ("book 3 files need to
be rehomed at the geometry repo"), moved out. Nothing deleted.

| File | Disposition |
|---|---|
| `chapter_eta.html` | **Rehomed** — now `geometry/ch-eta-dnls.html`, linked from `living-book.html`'s Scientists Series section. This copy here is now a stale duplicate; keep the geometry one current. |
| `chapter-eta-dnls.html` | Superseded. An older draft of the same chapter (872 lines, no date-stamped revision beyond May 8) — `chapter_eta.html` (750 lines, revised July 6) was the newer version and is the one that got rehomed. |
| `chapters-ladder.html` | **Rehomed** — now `geometry/ch-recurrence-ladder.html`, linked from `living-book.html`. Its relative links (`Sportal.html`, `index.html`, `chapters-diagram.html`, etc.) all resolved correctly once dropped into geometry's root — no edits needed. |
| `impa-portal.html` | Stale. geometry's own `impa-portal.html` (2026-07-12, 272,392 bytes) is newer than this copy (2026-06-20, 272,288 bytes) — geometry was already ahead, so no rehoming needed, just confirming this copy is no longer the reference. |

See the `geometry` repo's `feature/rehome-dnls-chapters` branch (commit
adding `ch-eta-dnls.html` and `ch-recurrence-ladder.html`) for the
receiving-end details.
