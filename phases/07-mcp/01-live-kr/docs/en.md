# MCP: a live KR from a real source

> MCP is the plug. Once a tool is plugged in, "how many accounts last week?" stops being an export and becomes a question :)

**Badge:** 🔌 Plugged In  ·  **Time:** ~2 h 30  ·  **Prerequisites:** phase 06

## What you'll be able to do
- Explain what an MCP server is and where it's configured (`.mcp.json`, scopes, connectors).
- Plug one source of your channel into Claude Code, read-only.
- Put a live number into STATUS.md with the source written as `mcp:<server>` and an as-of date.

## The Problem
Phase 03 started from a CSV you exported by hand. Fine once. But the Monday report needs the
number every week, your STATUS wants it fresh, and your analyst agent wants to check it. Exports
don't scale, and they lose the filter you used.

MCP (Model Context Protocol) is how Claude talks to tools: Mixpanel, Supabase, Slack, Notion,
Adjust, Meta Ads, Google Drive. Each one is a "server" that exposes a few functions. Plug it in
and Claude can call "run this query" or "read this channel" as a tool, with the same yes/no
permissions as everything else.

## The Concept
```
Claude Code  --MCP-->  server (mixpanel)   --API-->  Mixpanel
             --MCP-->  server (supabase)   --SQL-->  your database
             --MCP-->  claude.ai connector --OAuth-->  Slack, Drive, Notion, Gmail
```
Where it's configured:
- `.mcp.json` in the workspace (project scope, shared with whoever clones): local servers like
  a database or a browser.
- `claude mcp add <name> ...` (user scope): yours, every folder.
- claude.ai connectors: the ones you authorise in the browser (Slack, Notion, Drive); they show
  up as `mcp__claude_ai_<Name>__<tool>`.

Secrets never go in `.mcp.json`. Use `${MIXPANEL_SECRET}` and set the variable in your shell.
A token in a file in a git repo is a token on the internet.

Posture: read-only first. You read a KR; you don't write to Mixpanel, you don't post to Slack.
Writes come later, one at a time, each with an explicit go. This is the Finanz way, line 2.

## Build It
### Step 1: pick the source
Your channel's main number lives somewhere: Mixpanel (accounts, funnels), Supabase/Engine
(spend, creatives), Adjust (installs), Meta Ads (spend). Pick the one that holds your first KR
from phase 02. Ask the tutor which MCP is the right one and whether you already have access
(some need Marco to grant it: say so in the Monday check-in if you're blocked).

### Step 2: plug it in
Two routes. (a) A claude.ai connector: authorise it in the browser, restart `claude`, type
`/mcp` and see it listed. (b) A local server: add it to `.mcp.json` from `outputs/mcp.template.json`
with the env variable, never the token; set the variable in your shell; restart; `/mcp`.

### Step 3: ask the question
"Using the <server> MCP, how many <your KR> last ISO week, with the exact query you ran?"
Claude calls the tool (it asks: yes). Read the number AND the query. If the query is wrong (wrong
event, wrong window), fix it now: this query becomes the source line.

### Step 4: into STATUS.md
Update the KR row: Actual = the number, Status = MEASURED, Source = `mcp:<server>` plus the
query in a few words, As of = today. Now `last-updated` is today too.

### Step 5: prove it's live
Tomorrow (or after the next data refresh), ask the same question. Different number, same query.
That's the moment the export dies.

## Use It
Marco's weekly report reads Mixpanel funnels, Adjust cohorts, Meta spend and the Engine's
Supabase through MCP, all read-only, and the report's Sources section lists the query for each
figure. Writes to Meta or Slack exist too, but each one waits for his explicit go, and a hook
blocks them while agent teams run.

## Ship It
A plugged-in source and a STATUS row that reads itself.

## Check
`bin/check.sh 07` verifies: `.mcp.json` valid with at least one server · no token-shaped string in
it · STATUS.md has a row with `mcp:` in Source, labelled MEASURED, with an as-of date within 7 days.
If you used only a claude.ai connector, still create `.mcp.json` with that server's name as a
placeholder entry: the file is the record of what your OS depends on.

## Key Terms
| Term | What people say | What it actually means |
|---|---|---|
| MCP | "the API" | Model Context Protocol: a standard way for Claude to call external tools as functions. |
| Server | "the integration" | One MCP endpoint exposing a few tools (query, read, list). Local or remote. |
| Scope | "where it's installed" | Project (`.mcp.json`, shared), user (yours everywhere), connector (claude.ai account). |
| `${VAR}` | "a placeholder" | Environment variable expansion: the secret lives in your shell, not in the file. |
| Read-only posture | "being careful" | Only reading tools allowed until a write has an explicit go. |

## Further Reading
- MCP in Claude Code: https://code.claude.com/docs/en/mcp (scopes, `claude mcp add`, env expansion)
