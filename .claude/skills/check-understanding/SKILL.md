---
name: check-understanding
description: >
  Quiz on one phase of Claude Code from Scratch, outside the lesson loop. Usage:
  /check-understanding 05. Reads phases/05-*/01-*/quiz.json and asks all questions, with
  feedback and the lesson section to re-read. Trigger phrases: "quiz me", "check my
  understanding", "fammi il quiz", "/check-understanding".
---

# Check understanding

1. Phase id from the argument (`05`), or ask which. Find `phases/<NN>-*/01-*/quiz.json`.
2. Ask every question (pre and post), one at a time, options a-d, in the learner's language
   (`.course/lang`; translate on the fly if the quiz is in English).
3. Score. For each miss, show the `explanation` and the heading of `docs/<lang>.md` to re-read.
4. Does not change progress or XP: this is practice. Say so.
