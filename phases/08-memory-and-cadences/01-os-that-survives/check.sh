#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
C="$COURSE_WS/.claude/cadences.json"
need_json "$C" ".claude/cadences.json is valid JSON"
jq -e '[.cadences[] | select(.type=="weekly")] | length > 0' "$C" >/dev/null 2>&1 && pass "has at least one weekly cadence" || fail "has at least one weekly cadence"
R="$(ls "$COURSE_WS"/.claude/hooks/*cadence* 2>/dev/null | head -1)"
[ -n "$R" ] && [ -x "$R" ] && pass "cadence reminder hook exists and is executable" || fail "cadence reminder hook .claude/hooks/*cadence*.sh exists and is executable"
M="$COURSE_WS/memory/MEMORY.md"
need_file "$M" "memory/MEMORY.md exists"
LINK="$(grep -Eo '\]\(([^)]+\.md)\)' "$M" | head -1 | sed -E 's/\]\((.*)\)/\1/')"
[ -n "$LINK" ] && [ -f "$COURSE_WS/memory/$LINK" ] && pass "MEMORY.md links to an existing note ($LINK)" || fail "MEMORY.md links to an existing note in memory/"
ls -d "$HOME"/.claude/plugins/*/head-of-growth* "$HOME"/.claude/plugins/*/*/head-of-growth* >/dev/null 2>&1 && pass "head-of-growth plugin installed" || fail "head-of-growth plugin installed (ask the tutor for the marketplace command)"
finish
