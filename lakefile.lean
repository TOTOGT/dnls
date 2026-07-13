import Lake
open Lake DSL

package dnls

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "master"

@[default_target]
lean_lib TribonacciDNLS

@[default_target]
lean_lib FoldEvents

@[default_target]
lean_lib DNLSFoundations

-- DNLS_MeasureTheory_Roadmap.lean is deliberately NOT wired in as a
-- build target yet. It's a 118-theorem design document (Tiers 0-9,
-- mostly `sorry`/`True := trivial` placeholders) written without a
-- local Lean toolchain to check it against -- several Mathlib API
-- names in it (IsPicardLindelof, MemLp, etc.) are unverified guesses.
-- Wire it in as its own `lean_lib` once it has had a real compile pass;
-- until then, don't let its likely elaboration errors mask the status
-- of the three libraries above, which are real and load-bearing.
