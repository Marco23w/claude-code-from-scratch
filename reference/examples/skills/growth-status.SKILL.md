---
name: growth-status
description: >
  Cross-project cockpit for the Claude_Code workspace. Reads every Projects/*/STATUS.md
  (plus Projects/Tesi/STATO_TESI.md) and renders one table: project, goal, KR target vs
  actual, staleness, next action. Flags anything past its review-interval. Use when Marco
  says "growth status", "cockpit", "stato dei progetti", "dove siamo su tutto", "/growth-status",
  or at the start of a weekly planning session. Read-only, no MCP calls — instant.
---

# /growth-status — workspace cockpit

## What it does
One screen answering: where is every project vs its target, what's stale, what's the next action.

## Steps
1. Read every `Projects/*/STATUS.md`. For Tesi, read `Projects/Tesi/STATO_TESI.md` instead (map: Fase → status, Prossima azione → next action, Consegna → deadline).
2. For each file parse the header lines `last-updated:` and `review-interval:` (format `<N>d`). Compute staleness: **OVERDUE** if `today - last-updated > review-interval`, **due soon** if within 20% of the interval.
3. Render ONE table, sorted OVERDUE first, then by review-interval ascending:

| Project | Goal (short) | KR: target vs actual | Freshness | Next action |

4. Below the table, two short sections:
   - **Overdue reviews** — each OVERDUE project with how many days late.
   - **Open decisions (Marco)** — union of all "Open decisions" sections, deduped, each tagged with its project.
5. If invoked with `--weekly`, additionally launch the `cross-channel-synthesizer` agent (root `.claude/agents/`) and append its board-grade weekly delta.

## Hard rules
- Report ONLY what the STATUS.md files contain. Never fetch live data, never fill a gap with an estimate — surface "no data" cells as-is; a cluster of "no data" is itself a finding worth flagging.
- If a project folder has no STATUS.md, list it in a final line "No state file: <projects>" — that's a gap, not an error.
- Keep the whole output to one screen: table + two sections, no prose padding.
