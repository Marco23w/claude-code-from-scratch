# Capstone: your Growth OS

> Everything you built, assembled, and used for one real week. Not a demo: your channel, your numbers, your Monday :)

**Badge:** 🏆 Growth OS Owner + 🎓 certificate  ·  **Time:** ~8 h over one week  ·  **Prerequisites:** phase 08

## What you'll be able to do
- Run your channel for a week on your own system: CLAUDE.md, STATUS, 2 skills, 1 agent, 1 hook, 1 MCP.
- Show it to Marco in 15 minutes and defend three questions without notes.
- Hand the same system to a teammate who clones your repo.

## The Problem
Eight phases of pieces. Pieces are not a system until they run together on real work, under
real time pressure, for days in a row. The capstone is that week. It will break something: a
hook that fires too often, a skill that reads the wrong file, a source that needs a token you
don't have. Fixing those is the course.

## The Concept
The review grid (`reference/capstone-rubric.md`), in short:
```
 must                                                   proven by
 CLAUDE.md   who, sources, stop-and-ask, no secrets      file
 STATUS.md   3 KRs, labelled, sourced, updated this week  file + git log
 2 skills    both run and produce their output            run them live
 1 agent     read-only, Verdict + Weakest assumption      run it live
 1 hook      fires on its event, useful, never blocks     show it firing
 1 MCP       one live KR, mcp: source, as-of < 7 days     STATUS row
 the week    commits on 4+ distinct days                  git log
 the demo    15 min with Marco, 3 questions, no notes     Marco's call
```
Pass = every "must". Marco records `passed` or `redo` (with one line of why) from his Monday
skill. `passed` turns your certificate from "pending" to signed.

## Build It
### Step 1: assemble (day 1)
Make the workspace a git repo you push: `gh repo create <handle>/growth-os-<channel> --private
--source . --push` (private: your KRs are inside). Check the seven artifacts are there:
`bin/check.sh 09` from the course repo tells you what's missing, except the week itself.

### Step 2: run the week (days 1 to 5)
Every working day: open `claude` in the workspace, do one real thing for your channel through
the OS (the weekly on Monday, a number check, an analyst verdict on a decision, a STATUS
update). Commit at the end of the day: `git add -A && git commit -m "day n: <what>"`. Four
commits on four different days is the floor.

### Step 3: break and fix (whenever it happens)
Something will misbehave. Write what broke and what you changed in `memory/` as one note each
(phase 08). Those notes are the most valuable part of the review: they prove you understand
the system, not just the recipe.

### Step 4: the decision (at least once)
Take one real decision on a number that came out of the OS (a KR from MCP, a verdict from the
agent). Write it in STATUS under "This week" with the source. "We kept angle X because
CR W42 = 10.6% (mcp:mixpanel, funnel Y) vs 8.1% baseline" is the sentence Marco wants to read.

### Step 5: demo and done (day 5 or the next Monday)
Run `bin/check.sh 09` until it passes. `bin/done.sh 09` marks the capstone pending review and
writes your certificate as pending. Book 15 minutes with Marco: walk through the seven pieces,
show the hook firing and the agent running, answer his three questions. He flips the status.

## Use It
This is where Marco's workspace came from: one folder, one STATUS, one skill, five months ago.
Yours is the same thing at week one. Everything after this is adding one component at a time,
each with a check, each with a source.

## Ship It
`<handle>/growth-os-<channel>`: a repo a teammate can clone and run. And a certificate :)

## Check
`bin/check.sh 09` verifies: CLAUDE.md · STATUS.md updated within 7 days · 2 skills · 1 agent ·
1 hook wired · 1 MCP server · commits on 4+ distinct days in the last week. The demo is Marco's.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| Growth OS | "my setup" | The folder that runs your channel: context, state, skills, agents, hooks, sources. |
| Capstone review | "the exam" | 15 minutes, seven pieces live, three questions. Pass or redo with a reason. |
| Certificate | "a badge" | `progress/<handle>.certificate.md`, signed when Marco sets the review to passed. |

## Further Reading
- Your own `memory/` notes from the week. Seriously: reread them before the demo.
