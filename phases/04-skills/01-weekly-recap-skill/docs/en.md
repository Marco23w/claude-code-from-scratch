# Skills: your weekly recap as one command

> Anything you ask Claude more than twice is a skill waiting to be written. Write it once, run it with a slash :)

**Badge:** ⚡ One-Command Wonder  ·  **Time:** ~2 h 30  ·  **Prerequisites:** phase 03

## What you'll be able to do
- Turn a repeated request into `/<name>`: a folder, a `SKILL.md`, done.
- Write a description that makes Claude pick the skill on its own.
- Keep the skill short and push details into reference files it reads only when needed.

## The Problem
Every Monday you type the same 200 words: "take last week's export, give me the question, the
answer, one section per market, the sources at the bottom, in English, no decisions". Same
structure, same mistakes when you forget a line, and nobody else on the team can run "your"
recap because it lives in your head.

A skill is that paragraph, saved. `/tiktok-weekly` and it runs. Teammates clone your workspace
and have it too. Marco runs his Monday on `/lunedi`, a skill that calls six other skills.

## The Concept
```
.claude/skills/<name>/
├── SKILL.md          frontmatter (name, description) + the procedure, step by step
├── references/       optional: the long stuff (report structure, examples), read on demand
└── scripts/          optional: helpers the skill runs
```
The frontmatter is the trigger:
```yaml
---
name: tiktok-weekly
description: >
  Weekly TikTok recap for Finanz IT, on the canonical report structure (question, answer,
  one section per market, sources and limits). Use when I say "weekly", "recap", "/tiktok-weekly",
  or on Monday morning.
---
```
`name` must equal the folder name. `description` is what Claude reads to decide "is this the
skill for what they just asked?", so it carries the trigger phrases. Below the frontmatter: the
steps, in order, with what to read, what to produce, what never to do.

Progressive disclosure: the skill file stays short (what to do). Long templates go in
`references/` and the skill says "read references/structure.md". Claude loads it only then.

## Build It
### Step 1: steal the structure
Read `reference/examples/skills/growth-status.SKILL.md` in the course repo. Notice: frontmatter,
then numbered steps, then rules. That's the shape.

### Step 2: write the skill
In your workspace, ask Claude: "create .claude/skills/<channel>-weekly/SKILL.md: name equal to
the folder, a description of at least 80 characters with the trigger phrases, and these steps:
read reports/raw-W<nn>.md, write reports/weekly-W<nn>.md with the sections `## Question`,
`## Answer`, one `## <market>` per market, `## Sources and limits`; English; analysis only, no
decisions; every number labelled". Read the file. Shorten what you can.

### Step 3: move the template out
Create `references/structure.md` with the exact headings and a one-line rule per section. In
SKILL.md replace the long explanation with "follow references/structure.md".

### Step 4: run it
`/clear`, then `/<channel>-weekly`. Watch it read the raw report and write the weekly one. Open
`reports/weekly-W<nn>.md`. Is every number labelled? Is the Sources section honest? Fix the skill,
not the output, and run again. A skill you fix once is fixed forever.

### Step 5: trigger without the slash
`/clear`, then type "can you do the weekly?". If Claude picks your skill, the description works.
If not, add the phrase you just used to the description.

## Use It
Marco's `/acquisition-report` is 300 lines plus a reference file with the fixed structure of
every report since 25 Sep 2026. `/lunedi` chains it with the engine refresh, the scaling
decisions and the advisor email. Both started as one paragraph he was tired of retyping.

## Ship It
`.claude/skills/<channel>-weekly/` in your workspace, and this week's recap made by it.

## Check
`bin/check.sh 04` verifies: a `*-weekly` skill folder with `SKILL.md` · `name:` equals the folder
· description of 80+ characters · `reports/weekly-Wnn.md` exists with an `Answer` and a
`Sources` section.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| Skill | "a prompt template" | A folder with SKILL.md: procedure + trigger, invoked as /name or picked by Claude. |
| description | "the subtitle" | The trigger. Claude matches your words against it. Put the phrases you actually say. |
| Progressive disclosure | "nice to have" | Short SKILL.md, long references read only when needed. Keeps the context light. |
| Slash command | "the old way" | `.claude/commands/*.md` still works; skills are the same idea with a folder and references. |

## Further Reading
- Skills docs: https://code.claude.com/docs/en/skills (frontmatter fields, allowed-tools, arguments)
