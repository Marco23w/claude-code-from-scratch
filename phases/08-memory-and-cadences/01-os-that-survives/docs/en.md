# Memory and cadences: an OS that survives the week

> A system you have to remember to run is not a system. Memory, cadences and plugins are what make it run on its own :)

**Badge:** 🧬 Never Forgets  ·  **Time:** ~2 h  ·  **Prerequisites:** phase 07

## What you'll be able to do
- Keep what Claude learns about your channel across sessions, in a memory folder with an index.
- Register recurring jobs in a file and let a hook remind you when they're due.
- Install a plugin (a packaged set of skills) from a marketplace and know what it adds.

## The Problem
After seven phases you have a CLAUDE.md, a STATUS, a skill, two hooks, an agent, a live source.
Then you go on holiday for a week. You come back: STATUS is stale, the weekly didn't run, and
Claude has forgotten the three things you decided on Thursday because they were in a session,
not in a file.

Three fixes. Memory: a folder of small notes Claude reads through an index, so decisions
survive. Cadences: a JSON of jobs with a due day, and the hook from phase 05 that nags once per
period. Plugins: skills written by someone else (Marco, for instance) that you install instead
of rewriting.

## The Concept
```
memory/
├── MEMORY.md                 the index: one line per note, loaded at start
├── decision_angles_w42.md    one fact per file, with frontmatter (name, description, type)
└── feedback_no_tags_oct13.md

.claude/cadences.json         [{id, type: weekly|monthly, due_dow|due_dom, message}]
.claude/hooks/cadence-reminder.sh   UserPromptSubmit: once per period, sentinel in .claude/state/

~/.claude/plugins/            where /plugin marketplace add + /plugin install put things
```
Memory rules: one fact per file; MEMORY.md is an index, never the content; frontmatter so a
script can list them; link related notes with `[[name]]`. Marco's folder has 1,032 notes and a
241-line index; yours starts with one.

Cadences: the file is the list, the hook is the alarm. `type: weekly, due_dow: 1` means "from
Monday on, until done". The sentinel file (`.claude/state/cadence-<id>-<week>`) is what makes it
fire once. Marco's `cadences.json` has 10 entries; the Monday report is one of them.

Plugins: a marketplace is a git repo with a `.claude-plugin/marketplace.json`; a plugin is a
folder with skills, agents, hooks. `head-of-growth` is Marco's: 14 growth skills (weekly
report, country report, ASO copy, Meta audit).

Worktrees, one line: `claude --worktree <name>` gives Claude a separate copy of the folder to
work in parallel without touching yours. Not today, but it exists.

## Build It
### Step 1: your first memory
Create `memory/MEMORY.md` with the header "# Memory index" and one line linking to
`memory/decision_<something>.md`: the decision you took in phase 07 (which source, which query,
why). Write that note with frontmatter (name, description, type: project) and a line "Why:" and
"How to apply:". Add `@memory/MEMORY.md` to your CLAUDE.md. `/clear`, ask "what source do we use
for <KR>?". It knows, from the note.

### Step 2: cadences
Copy `outputs/cadences.template.json` to `.claude/cadences.json` and put one real weekly job in
it (the weekly recap, due_dow 1). Copy `outputs/cadence-reminder.sh` to `.claude/hooks/`, make
it executable, wire it in settings.json as a UserPromptSubmit hook (you did this in phase 05).
Restart, type anything: on the due day you see `<cadence-reminder>` with your job. Type again:
silence. Sentinel.

### Step 3: install Marco's plugin
In `claude`: `/plugin marketplace add Marco23w/head-of-growth-marketplace` (private repo, you are a
collaborator), then `/plugin install head-of-growth@head-of-growth-local`. Run `/weekly-experiments-report`
once and see what a mature skill looks like. Then look at `~/.claude/plugins/`: that's where it lives.

### Step 4: stale check
Set `last-updated` in STATUS.md to a date 10 days ago. Add to your cadence hook the staleness
block from `reference/examples/hooks/cadence-reminder.sh` (the second half of the file). Restart,
type: a `<staleness-alert>` says STATUS is 10 days old. Fix the date. That alert is the one
Marco's whole workspace runs on.

## Use It
Marco's session starts with: the memory index (1,032 notes), the cadence reminders due this
period, the commitments due in two days, the Slack threads waiting. None of it typed. All of it
from the three mechanisms you just built, at scale.

## Ship It
`memory/` with an index, `cadences.json` with a weekly job and its hook, one plugin installed.
Your OS now outlives your attention.

## Check
`bin/check.sh 08` verifies: `.claude/cadences.json` valid with a weekly entry · a `*cadence*`
hook executable · `memory/MEMORY.md` links to an existing note · the head-of-growth plugin is
installed under `~/.claude/plugins/`.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| Memory | "Claude remembers" | Files you (or Claude) write, indexed by MEMORY.md, loaded via CLAUDE.md. Nothing magic. |
| Cadence | "a reminder" | A job with a due day in cadences.json, fired once per period by a hook with a sentinel. |
| Plugin | "an app" | A folder of skills/agents/hooks installed from a marketplace repo. |
| Marketplace | "a store" | A git repo with `.claude-plugin/marketplace.json` listing plugins. Can be local or private. |
| Worktree | "a branch" | A separate working copy so Claude can work in parallel without touching your files. |

## Further Reading
- Memory: https://code.claude.com/docs/en/memory · Plugins: https://code.claude.com/docs/en/plugins
