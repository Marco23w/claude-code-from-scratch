# Claude Code from Scratch 🐣 -> 🏆

From "what is this terminal" to running your growth channel on your own Growth OS. Ten phases,
ten badges, one certificate. Made for the Finanz growth team, by growth. Taught inside Claude
Code by Claude itself :)

Italian version: [README.it.md](README.it.md)

## How it works
1. You clone this repo and open Claude Code in it.
2. `/start-learning` -> 3 questions, setup, a tiny placement quiz. 5 minutes.
3. `/learn` -> one phase per session. Claude teaches, you build in your own workspace, a script
   checks your work, you take a 4-question quiz, you unlock a badge. Repeat.
4. Phase 09 is the capstone: your own Growth OS, used for one real week. Marco reviews it and
   signs the certificate.

Every phase ships something you keep: a CLAUDE.md, a STATUS.md, a skill, a hook, an agent...
By the end you have the same kind of system Marco runs, at your scale.

## The ten phases

| Phase | Badge | You build | ~Time |
|---|---|---|---|
| 00 First session | 🐣 Hello Claude | your first file, made by Claude | 1 h |
| 01 Context | 🧠 Mind Reader | a CLAUDE.md for your channel | 2 h |
| 02 The Finanz way | 🔎 Source Hunter | a STATUS.md with sourced KRs | 2 h |
| 03 Tools and sessions | 🛠️ Toolsmith | a report from a CSV, plus a headless run | 2 h |
| 04 Skills | ⚡ One-Command Wonder | your weekly recap as a slash command | 3 h |
| 05 Hooks | 🪝 Puppet Master | a reminder hook and a safety guard | 3 h |
| 06 Agents | 🤖 Team Builder | a read-only analyst agent | 3 h |
| 07 MCP | 🔌 Plugged In | a live KR from a real source | 3 h |
| 08 Memory and cadences | 🧬 Never Forgets | memory, cadences, a plugin | 2 h |
| 09 Capstone | 🏆 Growth OS Owner | your Growth OS, one real week | 8 h |

Hours are estimates (ASSUMED) and will be corrected after the first learners.
XP: 100 per phase, +50 for a perfect quiz. Levels: Rookie -> Operator -> Builder -> Architect -> Growth OS Owner.

## Before you start (10 minutes, once)
- A Mac with Homebrew.
- Claude Code installed and logged in with your Finanz seat: `npm install -g @anthropic-ai/claude-code`, then `claude`.
- GitHub: member of the Finanz org, and `gh` logged in: `brew install gh jq && gh auth login`.
- Clone: `git clone https://github.com/Marco23w/claude-code-from-scratch.git && cd claude-code-from-scratch && claude`, then `/start-learning`.

When Claude Code asks whether to trust this folder's hooks, say yes: they are the four small
scripts in `.claude/hooks/`, and you can read them.

## What gets tracked, and what doesn't
The course logs, on your own branch `learner/<your-handle>` in a **private** repo
(`claude-code-from-scratch-progress`, visible to you and Marco only): when a session starts and ends,
which phases you passed, check results, quiz scores, minutes, and the feedback you send with `/feedback`.
It never logs your prompts, your transcripts, or your files. Marco reads it every Monday to see who needs a hand.
Details: `progress/SCHEMA.md`.

## Commands
`/start-learning` · `/learn` · `/check-understanding NN` · `/course-guide` · `/done NN` · `/progress` · `/feedback`

## Credits
Structure inspired by [AI Engineering from Scratch](https://aiengineeringfromscratch.com)
(Rohit Ghumare, MIT): phases, lesson beats, tutor skills, every lesson ships something.
Content and tone: Marco Amico, Head of Growth, Finanz.
