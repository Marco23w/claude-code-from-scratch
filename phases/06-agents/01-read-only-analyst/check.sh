#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
A="$(ls "$COURSE_WS"/.claude/agents/*-analyst.md 2>/dev/null | head -1)"
[ -n "$A" ] && pass "agent file .claude/agents/<channel>-analyst.md exists" || fail "agent file .claude/agents/<channel>-analyst.md exists"
[ -n "$A" ] && need_grep '^name: ' "$A" "frontmatter has name:"
[ -n "$A" ] && need_grep '^tools: ' "$A" "frontmatter has tools:"
[ -n "$A" ] && deny_grep '^tools: .*(Write|Edit|Bash)' "$A" "tools list is read-only (no Write, Edit, Bash)"
V="$COURSE_WS/reports/analyst-verdict.md"
need_file "$V" "reports/analyst-verdict.md produced by the agent"
need_grep '^## .*Verdict' "$V" "verdict has a '## Verdict' section"
need_grep '^## .*Weakest assumption' "$V" "verdict has a '## Weakest assumption' section"
finish
