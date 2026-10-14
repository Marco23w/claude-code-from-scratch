# Hooks: the harness nags for you

> A hook is a tiny script Claude Code runs on an event. No prompt, no memory needed: it just happens. Every time :)

**Badge:** 🪝 Puppet Master  ·  **Time:** ~2 h 30  ·  **Prerequisites:** phase 04

## What you'll be able to do
- Name the events Claude Code fires and pick the right one for a job.
- Write a hook that injects context on every prompt (a deadline, a status) without you typing it.
- Write a guard that blocks a dangerous command before it runs, with exit code 2.
- Know how the course itself tracks you: with three of these.

## The Problem
Phase 01 gave Claude standing instructions. But instructions are passive: Claude reads them,
then you still have to remember the Friday report, the stale STATUS, the thing you promised.
And a rule like "never delete recursively" is a wish until something enforces it.

Hooks are the enforcement. They run outside the model: a shell script, triggered by an event,
that prints context, writes a file, or says no. Marco's workspace has 17 of them. The reminders
you'll see in his sessions (cadences, commitments due, Slack pending) are not Claude being
clever. They are hooks.

## The Concept
```
 event                 when                              what people use it for
 SessionStart          claude opens                      refresh a cache, print "where we are"
 UserPromptSubmit      you press enter                   inject context: deadlines, reminders
 PreToolUse            before a tool runs                guard: block or allow (exit 2 = block)
 PostToolUse           after a tool ran                  lint, format, log
 Stop                  Claude finished a turn            heartbeat, save a summary
 SessionEnd            claude closes                     cleanup, sync, push
```
Each hook gets JSON on stdin (session id, the prompt, the tool and its input). What it prints
on stdout becomes context for Claude (on UserPromptSubmit and SessionStart). Exit 0 = fine.
Exit 2 = block, and stderr is the reason shown to Claude. Anything else = non-blocking error.

Wiring, in `.claude/settings.json` of the workspace:
```json
{ "hooks": {
    "UserPromptSubmit": [ { "hooks": [ { "type": "command",
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/deadline-reminder.sh", "timeout": 5 } ] } ],
    "PreToolUse": [ { "matcher": "Bash", "hooks": [ { "type": "command",
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/rm-guard.sh", "timeout": 5 } ] } ]
} }
```
`matcher` filters which tool. `timeout` is seconds. `$CLAUDE_PROJECT_DIR` is the folder you
opened Claude in, so the path works on any machine.

Two patterns worth stealing. The sentinel: a hook that should fire once a day touches a file
named with today's date and checks it first. And the heartbeat: a Stop hook writing a timestamp,
so even a killed terminal leaves a trace. The course tracking uses both. Read
`.claude/hooks/course-session-start.sh` in the course repo: it's 30 lines.

## Build It
### Step 1: the reminder
In your workspace, create `.claude/hooks/deadline-reminder.sh` from `outputs/deadline-reminder.sh`.
Put your real deadline in it (the Friday report, the Monday weekly). `chmod +x` it. Test it
without Claude: `printf '{"prompt":"hi"}' | .claude/hooks/deadline-reminder.sh`. It should print
your reminder in a `<reminder>` tag. Run it again: nothing, the sentinel says today is done.

### Step 2: the guard
Create `.claude/hooks/rm-guard.sh` from `outputs/rm-guard.sh`. It reads the JSON, pulls
`tool_input.command`, and if the command is a recursive delete (`rm -r...`), writes a reason to
stderr and exits 2. Test: `printf '{"tool_name":"Bash","tool_input":{"command":"rm -rf /tmp/x"}}' | .claude/hooks/rm-guard.sh; echo $?` -> 2.
Then with `ls` -> 0.

### Step 3: wire both
Ask Claude: "add both hooks to .claude/settings.json as in outputs/settings.hooks.json". Check
the JSON is valid: `jq . .claude/settings.json`. Restart `claude` (hooks load at start).

### Step 4: see them live
Type anything: your reminder appears in Claude's context (it may mention it). Ask Claude to
"delete the work folder recursively": the guard blocks it and Claude tells you why. That's the
feeling you want: the rule holds even when you forget it.

### Step 5: look at your own tracking
In the course repo, read `.claude/settings.json`. Three hooks: SessionStart, Stop, SessionEnd.
Now you know exactly what the course records about you, and you could have written it.

## Use It
Marco's `cadence-reminder.sh` (copied in `reference/examples/hooks/`) reads a `cadences.json`
with weekly, monthly and quarterly jobs, and fires each one once per period with a sentinel file.
His `team-readonly-guard.py` is a PreToolUse hook that blocks writes to Meta Ads, Slack and
Supabase whenever an agent team is running. One rule, enforced, forever.

## Ship It
Two hooks in your workspace: a reminder that speaks once a day and a guard that never sleeps.

## Check
`bin/check.sh 05` verifies: valid `settings.json` with `UserPromptSubmit` and `PreToolUse` ·
`*remind*.sh` and `*guard*.sh` executable · the reminder prints on a sample prompt · the guard
exits 2 on a recursive delete and 0 on `ls`.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| Hook | "a plugin" | A shell command bound to an event, configured in settings.json. Runs outside the model. |
| Exit code 2 | "an error" | The blocking code. Exit 1 is a non-blocking error, so guards must use 2. |
| matcher | "a filter" | Which tool (PreToolUse/PostToolUse) or source (SessionStart) the hook applies to. |
| Sentinel | "a lock file" | An empty file whose existence means "already done this period". |
| CronCreate | "a scheduler" | In-session scheduled prompts. For real schedules use a Stop/SessionStart hook or launchd. |

## Further Reading
- Hooks reference: https://code.claude.com/docs/en/hooks (events, stdin fields, exit codes, matchers)
