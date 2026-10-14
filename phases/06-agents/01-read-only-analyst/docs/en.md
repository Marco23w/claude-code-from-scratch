# Agents: a read-only analyst

> An agent is a Claude you brief once, hand a short list of tools, and send off to do one job. Give it fewer hands than you have, and it becomes trustworthy :)

**Badge:** 🤖 Team Builder  ·  **Time:** ~2 h 30  ·  **Prerequisites:** phase 05

## What you'll be able to do
- Write an agent file: name, description, tools, model, and the brief.
- Launch it from a session and get a verdict back, without it touching your files.
- Think like Marco's thesis: goal -> tasks -> one component per task -> one that checks the hand-offs.

## The Problem
Your weekly report is done (phase 04). Now someone has to read it critically: what's the weakest
number, what's the assumption that would collapse the plan, what would a sceptic ask on Monday.
If you ask the same Claude that wrote it, it will be kind to its own work. If you ask a
teammate, you wait a day.

An agent is a separate Claude with its own brief and its own, smaller, tool list. You give it
Read, Grep, Glob and nothing else: it can look, it cannot touch. It reads the report, writes
its verdict as its final message, and you decide. Marco has 31 of these, in three teams.

## The Concept
```
.claude/agents/tiktok-analyst.md
---
name: tiktok-analyst
description: Red-teams the weekly TikTok report. Use after /tiktok-weekly, or when I say "challenge this".
tools: Read, Grep, Glob          <- the hands. No Write, no Edit, no Bash: it cannot change anything.
model: sonnet                    <- cheaper and fast for reading; opus for heavy reasoning.
---
You are the sceptic... (the brief: what to read, what to produce, in what order)
```
How it runs: in your session you say "use the tiktok-analyst agent on reports/weekly-W42.md".
Claude launches it as a subagent (the Agent tool), it works in its own context, and only its
final message comes back. Your context stays clean. That's the point: one job, one component,
nothing leaks.

The thesis frame (reference/thesis-4-3-excerpt.md): start from the goal, split it into tasks,
give each task its own component, and add one component whose only job is checking the
hand-offs. The analyst is the checker of your weekly. A team is several of these, each with a
closed tool list, plus one that decides. Marco's meta-team: nine read-only roles, one strategist,
and a hook that blocks writes while they run.

## Build It
### Step 1: read a real one
`reference/examples/agents/growth-challenger.md` in the course repo. Notice: tools are three,
the brief says "verdict first", and the output is the final message, nothing written.

### Step 2: write your analyst
In your workspace, ask Claude: "create .claude/agents/<channel>-analyst.md with name
<channel>-analyst, tools Read, Grep, Glob, model sonnet, and this brief: read the latest
reports/weekly-W*.md and STATUS.md; produce `## Verdict` (one line: strong, or settling),
`## Weakest assumption` (the one number or belief that, if wrong, breaks the week),
`## Three questions a sceptic would ask`; never write files; every claim points to a line of
the report". Open the file. Check the tools line with your own eyes.

### Step 3: run it
`/clear` (agents load at start, so restart `claude` if it says it can't find it). Say: "use the
<channel>-analyst agent on this week's report". Watch: Claude says it's launching an agent,
waits, and returns a verdict. Ask Claude to save that verdict as `reports/analyst-verdict.md`
(the agent can't write; the main session can).

### Step 4: try to make it misbehave
Ask: "use the analyst to fix the typo in STATUS.md". It should say it can't: no Edit tool. If it
somehow edits, your tools line is wrong. That refusal is the feature.

### Step 5: the team question
Write three lines at the bottom of the verdict: if this were a team, what would the other two
roles be (one reads the raw data, one checks the hand-off between raw and weekly)? You'll build
them in the capstone if you want to.

## Use It
Marco's growth-challenger agent runs on every kill/scale decision above about 500 euro. It never
writes; the decision stays with him. The agent teams (meta, ASO, GEO) are 23 read-only roles that
run in parallel and hand their findings to one strategist. A PreToolUse hook (phase 05) makes
sure none of them can write to Meta, Slack or Supabase while a team runs.

## Ship It
`.claude/agents/<channel>-analyst.md` and `reports/analyst-verdict.md`: a second opinion on tap.

## Check
`bin/check.sh 06` verifies: the agent file exists with `name:` and `tools:` · tools contain no
Write, Edit or Bash · `reports/analyst-verdict.md` exists with `## Verdict` and
`## Weakest assumption`.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| Agent / subagent | "another AI" | A Claude with its own brief, tools and context, launched for one task; only its final message returns. |
| tools: | "permissions" | The closed list of what it can do. Read-only lists make agents safe to run unattended. |
| model: | "the engine" | Which Claude runs it. Sonnet for reading and routine, Opus for heavy multi-constraint reasoning. |
| Team | "a workflow" | Several agents with closed tools plus one that decides, often run in parallel. |

## Further Reading
- Subagents docs: https://code.claude.com/docs/en/sub-agents (frontmatter, tools, model, how they're invoked)
