#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
F="$COURSE_WS/STATUS.md"
need_file "$F" "STATUS.md exists in your workspace"
need_grep '^last-updated: [0-9]{4}-[0-9]{2}-[0-9]{2}' "$F" "front matter has last-updated: YYYY-MM-DD"
need_grep '^review-interval: [0-9]+d' "$F" "front matter has review-interval: Nd"
need_grep '^\| *KR *\|.*\| *Source *\|' "$F" "KR table has a Source column"
ROWS="$(grep -E '^\|' "$F" | grep -vE '^\| *KR|^\|[- |]+\|$' | wc -l | tr -d ' ')"
[ "$ROWS" -ge 3 ] && pass "at least 3 KR rows ($ROWS)" || fail "at least 3 KR rows (found $ROWS)"
BAD="$(grep -E '^\|' "$F" | grep -vE '^\| *KR|^\|[- |]+\|$' | grep -vE 'MEASURED|DERIVED|ASSUMED|no data' | wc -l | tr -d ' ')"
[ "$BAD" -eq 0 ] && pass "every KR row carries MEASURED / DERIVED / ASSUMED or 'no data'" || fail "every KR row carries MEASURED / DERIVED / ASSUMED or 'no data' ($BAD rows without)"
finish
