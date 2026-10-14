# Tools and sessions: from a CSV to a report

> Claude Code has six hands: Read, Edit, Bash, Glob, Grep, Write. Learn which one it's using and you stop being surprised :)

**Badge:** 🛠️ Toolsmith  ·  **Time:** ~1 h 30  ·  **Prerequisites:** phase 02

## What you'll be able to do
- Read what Claude is doing: which tool, on which file, why it asks.
- Set permissions once in `settings.json` instead of saying yes forty times.
- Turn a raw export into a sourced report, and run Claude with no session at all (headless).

## The Problem
You export last week's numbers from Adjust or the Engine. A CSV. You open it, scroll, copy three
figures into a message, lose the filter you used, and on Monday nobody can rebuild the number.

Claude can do the boring part: read the file, total the columns, write a table, and write down
where the file came from. But only if you understand what it's doing with your files, so you can
say yes fast and no when it matters.

## The Concept
```
 Read    look at a file                    free, no question
 Glob    find files by name (*.csv)        free
 Grep    search text inside files          free
 Edit    change part of a file             asks (unless allowed)
 Write   create or overwrite a file        asks (unless allowed)
 Bash    run a command (ls, python, git)   asks (unless allowed)
```
Permissions live in `.claude/settings.json` of the workspace:
```json
{ "permissions": { "allow": ["Read", "Bash(ls:*)", "Bash(git status:*)"],
                   "deny":  ["Bash(rm:*)"],
                   "ask":   ["Write"] } }
```
`allow` = silent. `deny` = never. `ask` = the default. Project settings are shared with whoever
clones the folder; `settings.local.json` is yours only.

Sessions: `claude` starts fresh. `claude --continue` reopens the last one, `claude --resume` lets
you pick. `/compact` squeezes a long context into a summary when Claude starts forgetting.
`/cost` tells you what the session used. Plan mode (Shift+Tab twice) makes Claude think and
propose without touching files: great for "what would you do here?".

Headless: `claude -p "your prompt"` runs one prompt, prints one answer, no session. That's how
scripts and schedulers use Claude. It respects the same CLAUDE.md.

## Build It
### Step 1: get a CSV
Export last week from your channel's tool (Adjust, Mixpanel, the Engine, Meta). Save it as
`work/week.csv` in your workspace. No export at hand? Copy `outputs/sample-week.csv.example`
to `work/week.csv` and label everything ASSUMED later.

### Step 2: watch the tools
Ask Claude: "what's in work/week.csv?". Look at the line it prints before the answer: that's a
Read. Ask "which files here are csv?": Glob. Ask "which row has the biggest spend?": it may run
a Bash command with awk or python. Each time, notice the tool name.

### Step 3: the report
Ask: "write reports/raw-W<nn>.md (nn = this ISO week): a markdown table with the totals per
column that matter, every number MEASURED from work/week.csv, and a final line
`Source: <tool>, <report name>, <filter>, exported <date>`". Give it the real source. It asks
to Write: yes. Open the file. Check one total by hand against the CSV. One. Always.

### Step 4: stop saying yes
Create `.claude/settings.json` in the workspace with `allow` for `Read`, `Bash(ls:*)`,
`Bash(cat:*)`, `Bash(git status:*)` and `deny` for `Bash(rm:*)`. Restart `claude`. Ask for a
listing: no question this time.

### Step 5: headless
In Terminal, from your workspace, run:
`claude -p "Write the single word ok to reports/headless-ok.txt and nothing else" --allowedTools Write`
Then `cat reports/headless-ok.txt`. One prompt, no session, a file. Phase 05 makes this run on
a schedule.

## Use It
Marco's weekly acquisition report starts exactly like this: raw exports read by Claude, totals
checked once by hand, a `Sources and limits` section at the bottom of every report. His
`settings.local.json` has 416 allow rules, built over five months, one "always allow" at a time.

## Ship It
`reports/raw-W<nn>.md` with a Source line, and a `settings.json` that fits your hands.

## Check
`bin/check.sh 03` verifies: `reports/raw-Wnn.md` exists · it has a table · a `Source:` line ·
`reports/headless-ok.txt` exists and contains `ok`.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| Tool | "a feature" | One capability with its own permission: Read, Edit, Write, Bash, Glob, Grep, and MCP calls. |
| settings.json | "the config" | Permissions, hooks, env. Project file is shared; `.local.json` is yours. |
| Plan mode | "thinking mode" | Claude explores and proposes, writes nothing. Exit to execute. |
| /compact | "clear" | Summarises the context instead of wiping it. Use it when answers get vague. |
| Headless | "API mode" | `claude -p`: one prompt in, one answer out, scriptable. |

## Further Reading
- Permissions and settings: https://code.claude.com/docs/en/settings
- CLI reference (`-p`, `--continue`, `--resume`, `--allowedTools`): https://code.claude.com/docs/en/cli-reference
