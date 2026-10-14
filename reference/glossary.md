# Glossary (EN / IT)

| Term | EN | IT |
|---|---|---|
| Claude Code | Claude in your terminal: reads files, edits, runs commands, with your go | Claude nel terminale: legge file, modifica, lancia comandi, con il tuo via |
| CLAUDE.md | Standing instructions Claude reads at the start of every session | Istruzioni fisse che Claude legge all'inizio di ogni sessione |
| Context | What Claude can "see" right now: your prompt, files read, CLAUDE.md, tool results | Cio' che Claude "vede" adesso: prompt, file letti, CLAUDE.md, risultati dei tool |
| Tool | One thing Claude can do: Read, Edit, Bash, Glob, Grep, WebFetch, an MCP call | Una cosa che Claude sa fare: Read, Edit, Bash, Glob, Grep, WebFetch, una chiamata MCP |
| Permission | Your yes/no before a tool runs; allowlists in settings.json | Il tuo si'/no prima che un tool giri; allowlist in settings.json |
| Skill | A folder with SKILL.md: a reusable procedure, invoked as /name | Una cartella con SKILL.md: una procedura riusabile, invocata come /nome |
| Hook | A shell command Claude Code runs on an event (SessionStart, Stop, PreToolUse...) | Un comando shell che Claude Code lancia su un evento (SessionStart, Stop, PreToolUse...) |
| Agent / subagent | A separate Claude with its own prompt and tool list, launched for one task | Un Claude separato con il suo prompt e i suoi tool, lanciato per un compito |
| MCP | Model Context Protocol: how Claude talks to external tools and data (Slack, Mixpanel, Supabase...) | Model Context Protocol: come Claude parla con strumenti e dati esterni (Slack, Mixpanel, Supabase...) |
| Memory | Notes Claude keeps across sessions, indexed by MEMORY.md | Appunti che Claude tiene tra una sessione e l'altra, indicizzati da MEMORY.md |
| STATUS.md | The state file of a project: target vs actual, sources, next action | Il file di stato di un progetto: target vs actual, fonti, prossima azione |
| MEASURED / DERIVED / ASSUMED | Label of every number: read / computed / guessed | Etichetta di ogni numero: letto / calcolato / supposto |
| Headless | `claude -p "..."`: one prompt, one answer, no interactive session | `claude -p "..."`: un prompt, una risposta, nessuna sessione interattiva |
| Plugin | A packaged set of skills/agents/hooks you install from a marketplace | Un pacchetto di skill/agenti/hook che installi da un marketplace |
| Growth OS | Your folder with CLAUDE.md + STATUS.md + skills + agents + hooks + MCP: how you run your channel | La tua cartella con CLAUDE.md + STATUS.md + skill + agenti + hook + MCP: come fai girare il tuo canale |
