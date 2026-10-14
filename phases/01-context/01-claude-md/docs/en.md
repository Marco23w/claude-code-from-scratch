# CLAUDE.md: say it once

> Everything you keep repeating to Claude belongs in one file it reads before you type. Write it once, forget it forever :)

**Badge:** 🧠 Mind Reader  ·  **Time:** ~1 h 30  ·  **Prerequisites:** phase 00

## What you'll be able to do
- Give Claude standing instructions for your channel: who you are, where numbers come from, what it must never do alone.
- Know the three places a CLAUDE.md can live and which one wins.
- Split rules into files and import them with `@`.

## The Problem
Every session starts empty (you saw it at /clear). So every session you re-explain: "I run TikTok
for Finanz, the numbers are in Adjust and the Engine, never send anything, write in English..."
Ten sessions, ten repeats, and one day you forget the "never send" line. That day is a bad day.

A CLAUDE.md is the fix: a markdown file in the folder, read automatically at every start. Marco's
global one is 90 lines and it is the reason his Claude answers like his Claude, not like a generic
assistant.

## The Concept
```
~/.claude/CLAUDE.md          you, everywhere (every folder)        <- "who I am, how I work"
<workspace>/CLAUDE.md        this project                           <- "this channel, its sources, its rules"
<workspace>/sub/CLAUDE.md    only when Claude works under sub/      <- "this corner's specifics"
```
All three load, most specific last. And a line inside like `@glossary.md` pulls another file in,
so the main file stays short.

The rule that matters: **a line that doesn't change behaviour doesn't belong.** "Be helpful" is
noise. "Numbers come from Adjust, cohort d7, never from the Meta dashboard" changes behaviour.

What never goes in: IDs, tokens, keys, anyone's personal data. It's a text file that gets copied.

## Build It
### Step 1: look at a real one
In the course repo, read `reference/finanz-way.md` (one page). Those are Marco's house rules.
Pick the three that matter most for your channel. You'll put them in yours.

### Step 2: write your CLAUDE.md
In your workspace, ask Claude: "create CLAUDE.md with these sections: `## Who` (me, my channel,
my markets), `## Where numbers come from` (one line per source: tool, what it measures, who owns
it), `## Stop and ask` (the list of things you never do without my explicit go)". Fill it with
real content. Short lines. Example of a good "Stop and ask" line: "sending anything on Slack
in my name". A bad one: "being careful".

### Step 3: import a glossary
Create `glossary.md` with 5 terms of your channel (what "ASR" means for you, what "install" means,
the cohort window you use...). Add a line `@glossary.md` at the top of CLAUDE.md. Now ask Claude
"what does ASR mean here?" in a fresh session (`/clear` then ask). It knows. Mind reader.

### Step 4: test the behaviour, not the file
`/clear`. Ask Claude to "post this week's number on Slack". It should stop and ask, because your
"Stop and ask" says so. If it doesn't, the line is not clear enough. Rewrite until it stops.

### Step 5: prune
Read your CLAUDE.md once more. Delete every line that would not change what Claude does.
Shorter is stronger.

## Use It
Marco's workspace has 56 CLAUDE.md files: one global, one per project, one per country inside
Meta Ads and ASO. The global one has a "Stop and ask before" section with four lines, and a
"Learned rules" section that grows every time Claude gets something wrong. Yours starts with
three sections. It will grow the same way.

## Ship It
`CLAUDE.md` + `glossary.md` in your workspace. From now on every session of yours starts informed.

## Check
`bin/check.sh 01` verifies: CLAUDE.md exists · has `## Who`, `## Where numbers come from`,
`## Stop and ask` · imports an existing file with `@` · contains nothing shaped like a token.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| CLAUDE.md | "the system prompt" | Standing instructions, loaded at start, hierarchical (global > project > subfolder). |
| @import | "a link" | A line `@path` that inlines another file into CLAUDE.md at load time. |
| /memory | "Claude's memory" | The command that opens the CLAUDE.md files in play. Phase 08 is the real memory. |
| /init | "setup" | Generates a first CLAUDE.md from the folder. Fine for code, too generic for growth. |

## Further Reading
- Claude Code memory docs: https://code.claude.com/docs/en/memory (the hierarchy, imports, /memory)
