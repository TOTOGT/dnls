**PREPRINT — NOT PEER REVIEWED**

# Verification Statement & Conflict-of-Interest Disclosure

This file exists because every deposit tied to this repository is
**self-published** (Zenodo, author-deposited, no journal, no external
editor assigning referees). That is a real limitation, and this
document says so plainly rather than letting the Lean badge or DOI
alone imply a review process that didn't happen.

---

## 1. Verification statement

**What formal verification is standing in for.** Conventional peer
review has a human referee, chosen by an editor independent of the
author, check correctness before publication. Nothing in this
pipeline has that. Instead, mathematical claims that are stated as
"formally verified" are checked by an automated, third-party-run
kernel: Lean 4, via GitHub Actions (`.github/workflows/verify-proofs.yml`),
which installs a fresh toolchain, builds every proof from source, and
runs `#print axioms` on each theorem to show exactly what it depends
on (including whether it still contains a `sorry`).

**What that does and doesn't cover.** A green kernel check means: this
statement, as formally written, follows from Mathlib's axioms by valid
logical steps, checked by software the author did not write and can't
quietly bias. It does **not** mean: the formalization is a faithful
translation of the informal claim in the paper, that the choice of
hypotheses is the right one, that the result is novel, or that the
surrounding numerical/empirical claims (which are ordinary Python/SciPy
computations, not Lean) are correct. Kernel-checking replaces "is this
argument valid" review, not "is this the right question, and does this
paper honestly represent what it computed" review — the second kind
still has no external referee here.

**Current status (updated as CI runs change).** As of the most recent
run on the `add-ci-workflow` branch (PR #1), the build is **not**
green:

- `FoldEvents.lean` fails to compile — three `maximum recursion depth`
  errors (lines 103–105).
- `TribonacciDNLS.lean` fails to compile — an unresolved Mathlib
  identifier (line 113), a `simp` that makes no progress (line 120),
  and `rfl`/definitional-equality mismatches around the `tribonacci`
  recursion (lines 138–142).

Until these are fixed and a run is green, treat every theorem in this
repo as **written and believed correct by the author, not yet
kernel-verified** — see the live status at the repo's Actions tab and
open PRs, not at any claim made in prose (including prose written
before this file existed). This file will be updated when that
changes; it is not a one-time badge.

---

## 2. Conflict of interest / collaboration statement

- **No conflicts of interest.** None declared. The author has no
  financial, institutional, or personal relationship that could be
  reasonably seen as influencing the content of these deposits.
- **Zero collaboration.** This is solo work. Pablo Nogueira Grossi is
  the sole author of the papers, code, and formalizations in this
  repository — no co-authors, no external collaborators, no lab, no
  research group, on any current deposit.
- **No institutional affiliation, no salary, no grant, no revenue.**
  This research is unpaid and unaffiliated. G6 LLC (Newark, NJ) is a
  personal bookselling entity (used to sell books on eBay), not a
  research funder, employer, or institution — it has no stake in any
  result here and does not commission, review, or influence this work.
  No grant, university, or employer has reviewed or funded any of it.
  To date, $0 has been earned from any deposit, PDF, or membership
  tied to this work — there is no revenue stream this disclosure could
  be protecting.
- **Job-market disclosure.** The author is currently seeking a book
  deal, literary/agent representation, and a salaried research or
  teaching position, and has not yet decided on a graduate program.
  None of these are currently in place — there is no existing
  employer, agent, or publisher relationship to disclose beyond this.
- **Publisher relationship.** Zenodo is a self-deposit archive
  (CERN/OpenAIRE); depositing here does not constitute peer review or
  editorial endorsement by Zenodo, CERN, or any journal.
- **AI assistance.** Portions of the Lean formalization, proof
  drafting, CI tooling, and this document were produced with the
  assistance of Claude (Anthropic), directed and reviewed by the
  author. AI assistance is disclosed here rather than left implicit;
  it does not substitute for the machine kernel-check itself, which is
  what actually verifies the proofs regardless of how they were
  drafted.
- **No anonymous referee.** No external, independent referee has
  reviewed the mathematical content of these deposits. The kernel
  check described in §1 is offered as a partial, narrow substitute —
  it establishes logical validity, not novelty, correctness of framing,
  or fitness for any particular scientific claim.
- **Contact / identity.** ORCID 0009-0000-6496-2186. Zenodo contact:
  pgrossi888@outlook.com. Corrections, disputes, or independent
  review of any claim in this repository are welcome via GitHub issue
  or the contact above.

---

*Last updated alongside PR #1 (`add-ci-workflow`), the first attempt to
actually run these proofs through a Lean kernel.*
