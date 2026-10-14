#!/bin/bash
# SessionEnd: close this session's record, then commit + push progress.
source "$(dirname "$0")/course-lib.sh"
INPUT="$(cat)"
SID="$(printf '%s' "$INPUT" | jq -r '.session_id // empty')"
[ -n "$SID" ] && [ -f "$SESS" ] || exit 0
NOW="$(now_epoch)"
jq -c --arg sid "$SID" --argjson now "$NOW" --arg iso "$(now_iso)" '
  if .sid == $sid and .end == null then
    .end = $iso | .minutes = ((($now - .start_epoch) / 60) | floor)
  else . end' "$SESS" > "$SESS.tmp" && mv "$SESS.tmp" "$SESS"
"$ROOT/.claude/hooks/course-sync.sh" >/dev/null 2>&1
exit 0
