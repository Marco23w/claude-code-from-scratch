---
name: course-guide
description: >
  Topic router for Claude Code from Scratch: "where do I learn hooks?", "my skill doesn't
  trigger", "come faccio a leggere Mixpanel?" -> the phase and the exact section, with the
  path. Trigger phrases: "where do I learn", "which lesson", "dove lo trovo", "/course-guide".
---

# Course guide

Map the question to a phase using this table, then open `phases/<NN>-*/01-*/docs/<lang>.md`
and point to the heading. Answer in 3 lines: the phase, the section, the one-line reason.

| Topic | Phase |
|---|---|
| install, login, permissions prompt, /help, /clear, /model | 00 |
| CLAUDE.md, @imports, /memory, /init, what not to put in context | 01 |
| MEASURED/DERIVED/ASSUMED, STATUS.md, sources, "no data" | 02 |
| Read/Edit/Bash tools, settings permissions, plan mode, --resume, /compact, claude -p | 03 |
| skills, SKILL.md frontmatter, slash commands, progressive disclosure | 04 |
| hooks, events, settings.json hooks, CronCreate, scheduled tasks | 05 |
| agents, subagents, Agent tool, read-only tool lists, agent teams | 06 |
| MCP, .mcp.json, connectors, reading live data | 07 |
| memory, MEMORY.md, cadences, commitments, plugins, marketplaces, worktrees | 08 |
| capstone, certificate, review | 09 |

If the question is a bug ("my hook doesn't fire"), add the 3 most likely causes from the
lesson's Key Terms table. Do not teach the lesson here: that is `/learn`.
