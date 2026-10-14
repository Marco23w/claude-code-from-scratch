---
name: feedback
description: >
  Sends feedback about the course to Marco: a lesson that is unclear, a check that feels wrong,
  a missing step, an idea. Saved in the learner's private progress branch, read every Monday.
  Usage: /feedback 03 "the headless step didn't work on my Mac". Trigger phrases: "feedback",
  "this is unclear", "non e' chiaro", "segnala", "/feedback".
---

# Feedback

1. Phase id from the argument or from `current` in `bin/progress.sh`; `general` if it is not about a phase.
2. If the learner gave no text, ask one question: "What was unclear or wrong, in one or two sentences?"
   Do not reformulate their words; keep them as they are.
3. Run `bin/feedback.sh <phase> "<text>"`. Show the confirmation line.
4. Say in one line that it goes to a private repo only Marco and they can see, and that the
   lesson gets updated from it. Nothing else is sent anywhere.
