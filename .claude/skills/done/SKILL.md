---
name: done
description: >
  Marks a phase of Claude Code from Scratch as done: runs the check, awards XP and the badge,
  saves progress on the learner's branch. Usage: /done 03. Trigger phrases: "done", "fatto",
  "ho finito", "mark as done", "/done".
---

# Done

Run `bin/done.sh <NN>` (phase id from the argument or from `current` in `bin/progress.sh`).
If the check fails, show the `[..]` lines and help fix them; do not retry blindly.
If it passes, show the unlock banner exactly as printed. If the quiz was not run in this
session, offer `/check-understanding <NN>` as practice (it does not change XP).
