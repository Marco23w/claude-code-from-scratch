#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
M="$COURSE_WS/.mcp.json"
need_json "$M" ".mcp.json is valid JSON"
jq -e '.mcpServers | length > 0' "$M" >/dev/null 2>&1 && pass "at least one MCP server configured" || fail "at least one MCP server in mcpServers"
deny_grep "$SECRET_RE" "$M" "no literal token in .mcp.json (use \${ENV_VAR})"
F="$COURSE_WS/STATUS.md"
need_grep 'mcp:' "$F" "STATUS.md has a KR row with Source mcp:<server>"
ASOF="$(grep -E 'mcp:' "$F" | grep -Eo '[0-9]{4}-[0-9]{2}-[0-9]{2}' | sort | tail -1)"
if [ -n "$ASOF" ]; then AGE=$(( ( $(date +%s) - $(date -j -f %Y-%m-%d "$ASOF" +%s) ) / 86400 )); [ "$AGE" -le 7 ] && pass "as-of date within 7 days ($ASOF)" || fail "as-of date within 7 days (found $ASOF)"; else fail "the mcp: row has an as-of date"; fi
grep -E 'mcp:' "$F" | grep -q MEASURED && pass "the mcp: row is labelled MEASURED" || fail "the mcp: row is labelled MEASURED"
finish
