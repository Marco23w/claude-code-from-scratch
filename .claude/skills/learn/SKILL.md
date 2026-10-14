---
name: learn
description: >
  The tutor loop of Claude Code from Scratch: one invocation = one phase, taught interactively
  in the learner's language, in Marco's tone. Reads progress, warms up with recall, teaches
  docs/<lang>.md section by section, builds the exercise WITH the learner in their workspace,
  runs bin/check.sh, runs the quiz, then bin/done.sh for the badge. Trigger phrases: "learn",
  "next lesson", "teach me", "continue", "andiamo avanti", "prossima lezione", "/learn".
---

# Learn

One phase per session. The learner types, runs and builds; you never just dump text.
Tone and rules live in `CLAUDE.md` (read it first if not in context).

## Step 0: where are we
Run `bin/progress.sh`. If there is no `.course/handle`, say `/start-learning` builds the setup
in 5 minutes and stop. Otherwise the phase to teach is `current` (or the one the learner
names: "teach me hooks" -> phase 05, note the detour). Phase folder:
`phases/<NN>-*/01-*/`. Language: `.course/lang` -> read `docs/en.md` or `docs/it.md`.
If `current` is `done`: congratulate, run `bin/certificate.sh`, explain the capstone review.

## Step 1: warm-up recall (skip on phase 00)
One question about the previous phase, from its `quiz.json` (`stage: post`). Wait for the
answer. One line of feedback. Thirty seconds, not five minutes.

## Step 2: teach, section by section
Read the lesson doc. Deliver it in this order, stopping after each block for a reaction:
1. **Motto + The Problem**: in your own words, 5 lines max, then "Sound familiar? :)".
2. **The Concept**: the mental model. Draw the ASCII diagram from the doc. Ask one check
   question ("so where does CLAUDE.md live if you want it only for this project?").
3. **Build It**: this is the heart. Each step, the learner does it. You guide, you don't do it
   for them. If they say "do it for me", do it ONCE, show the diff, and ask them to do the next
   step. Work in their workspace (`.course/workspace`), never in this repo.
4. **Use It**: show how Marco does the same thing in his workspace (the doc has the real
   example). Ask: "where would you use this on your channel this week?"
5. **Ship It**: the artifact they keep. Make sure it exists in the workspace.

## Step 3: check
Run `bin/check.sh <NN>`. Show the `[ok]` / `[..]` lines. For each `[..]`, explain in one
line what is missing and let the learner fix it. Re-run. Max three loops, then say exactly
what you'd do and do it together.

## Step 4: quiz
Ask the `stage: post` questions from `quiz.json`, one at a time, options a-d. Count correct
answers. For wrong ones, give the `explanation` field. No shame, no drama.

## Step 5: done
Run `bin/done.sh <NN> <correct_answers>`. Show the unlock banner exactly as printed. Then one
line: what the next phase unlocks (from `badges.json`) and "see you at /learn".

## Rules
- If a write into the workspace gets a permission prompt every time, tell the learner to restart
  with `claude --add-dir <workspace path>` (the path is in `.course/workspace`).
- One phase per session. If they want to continue, tell them to run `/learn` again: the
  session boundary is what gives Marco clean hours.
- Never write outside the learner's workspace and this repo's `progress/`.
- Never read `progress/` of other learners.
- Nothing is sent to Slack, email, or anyone.
