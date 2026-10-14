#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
need_file "$COURSE_WS/CLAUDE.md" "CLAUDE.md"
need_file "$COURSE_WS/STATUS.md" "STATUS.md"
N="$(ls -d "$COURSE_WS"/.claude/skills/*/SKILL.md 2>/dev/null | wc -l | tr -d ' ')"; [ "$N" -ge 2 ] && pass "2 skills ($N)" || fail "2 skills (found $N)"
N="$(ls "$COURSE_WS"/.claude/agents/*.md 2>/dev/null | wc -l | tr -d ' ')"; [ "$N" -ge 1 ] && pass "1 agent ($N)" || fail "1 agent (found $N)"
jq -e '.hooks | length > 0' "$COURSE_WS/.claude/settings.json" >/dev/null 2>&1 && pass "1 hook wired in settings.json" || fail "1 hook wired in settings.json"
jq -e '.mcpServers | length > 0' "$COURSE_WS/.mcp.json" >/dev/null 2>&1 && pass "1 MCP server" || fail "1 MCP server in .mcp.json"
LU="$(grep -m1 '^last-updated:' "$COURSE_WS/STATUS.md" | awk '{print $2}')"
if [ -n "$LU" ]; then AGE=$(( ( $(date +%s) - $(date -j -f %Y-%m-%d "$LU" +%s) ) / 86400 )); [ "$AGE" -le 7 ] && pass "STATUS updated this week ($LU)" || fail "STATUS updated this week (last $LU)"; else fail "STATUS has last-updated"; fi
D="$(cd "$COURSE_WS" && git log --since='7 days ago' --format=%ad --date=short 2>/dev/null | sort -u | wc -l | tr -d ' ')"
[ "$D" -ge 4 ] && pass "commits on $D distinct days in the last week (need 4+)" || fail "commits on at least 4 distinct days in the last week (found $D)"
finish
