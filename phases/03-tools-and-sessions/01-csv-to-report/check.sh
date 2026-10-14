#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
R="$(ls "$COURSE_WS"/reports/raw-W[0-9][0-9].md 2>/dev/null | head -1)"
[ -n "$R" ] && pass "reports/raw-Wnn.md exists ($(basename "$R"))" || fail "reports/raw-Wnn.md exists (nn = ISO week)"
[ -n "$R" ] && need_grep '^\|' "$R" "it contains a markdown table"
[ -n "$R" ] && need_grep '^Source:' "$R" "it has a 'Source:' line"
need_file "$COURSE_WS/reports/headless-ok.txt" "reports/headless-ok.txt exists (written by claude -p)"
need_grep 'ok' "$COURSE_WS/reports/headless-ok.txt" "headless-ok.txt contains 'ok'"
finish
