---
name: start-learning
description: >
  One-time onboarding for Claude Code from Scratch (Finanz growth edition). Asks why the learner
  is here, their language, name and growth area, runs bin/setup.sh, runs a 5-question placement
  quiz and writes .course/LEARNING.md. Trigger phrases: "start learning", "start the course",
  "onboard me", "inizia il corso", "cominciamo", "/start-learning".
---

# Start learning

You are onboarding one person from the Finanz growth team into **Claude Code from Scratch**:
10 phases, one lesson each, from "what is this terminal" to "I run my channel on my own
Growth OS". Your job here is small: learn who they are, set them up, place them, hand over to
`/learn`. Everything you say follows `CLAUDE.md` (Marco's tone: light, radically simple,
arrows ->, smiles :), one emoji where it helps).

## Step 1: three questions, one at a time
Use a structured question tool if available, otherwise lettered options in plain text.
1. Language: English or Italian? (write `.course/lang` = `en` or `it`)
2. Your growth area: meta, tiktok, aso, geo, ugc, markets, other? (write `.course/channel`)
3. Your name as it should appear on the certificate (write `.course/name`)
Then ask, in their language, in one line: "Why are you here? One sentence." Keep the answer
for `LEARNING.md`. Do not interrogate. Three answers and a sentence, that's it.

## Step 2: setup
Run `bin/setup.sh`. It reads the three files, creates the branch `learner/<handle>`, the
workspace `~/Finanz/growth-os`, the progress file, and smoke-tests the hooks. If it fails,
show the exact line and the fix from the README prerequisites, then run it again.
Tell the learner, in one paragraph, what the course logs (timestamps, phases, check results,
minutes) and what it never logs (prompts, transcripts, files). It is in `progress/SCHEMA.md`.

## Step 3: placement quiz, 5 questions
Ask these one at a time, options a-d, no hints:
1. What does CLAUDE.md do? (standing instructions Claude reads at start / a changelog /
   a config for the API / a list of files to ignore)
2. A "skill" in Claude Code is... (a folder with SKILL.md that becomes a slash command /
   a model fine-tune / a plugin store / a prompt you paste)
3. A hook is... (a shell command Claude Code runs on an event like Stop or PreToolUse /
   a keyboard shortcut / an API webhook / a git hook)
4. MCP lets Claude... (call external tools and data through servers / train on your data /
   browse the web only / send emails)
5. "MEASURED / DERIVED / ASSUMED" labels are for... (every number that enters a report or a
   decision / code comments / git commits / Slack messages)
Score it. 0-2 correct -> start at phase 00. 3-4 -> start at 00 anyway but say the first two
phases will be quick. 5 -> offer to start at phase 02 (phases 00 and 01 still need their
check and /done to unlock the badges, in any order). Never skip the Finanz way (phase 02).

## Step 4: write .course/LEARNING.md
```
# LEARNING.md  (local, not committed)
Name · handle · language · channel
Why I'm here: <their sentence>
Placement: <score>/5 -> start at phase <NN>
Plan: 10 phases, ~3h each for the big ones. One phase per week is the pace. Two is great.
Next: /learn
```
Then show `bin/progress.sh` output (all badges locked, 0 XP) and say: "Run /learn. First badge
is 20 minutes away :)".

## Rules
- Nothing is sent anywhere. No Slack, no email. Progress goes to the learner's own branch only.
- If the learner already has `.course/handle`, skip to Step 4 and say so in one line.
