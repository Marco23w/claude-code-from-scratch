#!/bin/bash
# SessionStart: open a session record, close orphans, retry a pending push,
# and tell the tutor where the learner is. Logs timestamps only.
INPUT="$(cat)"
# New learner (no setup yet): tell the tutor to open with the one sentence that starts everything.
ROOT0="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
if [ ! -f "$ROOT0/.course/handle" ]; then
  echo '<course-welcome>New learner, no setup yet. Whatever they write first, answer in ONE line: "Welcome to Claude Code from Scratch :) Type: start learning" (and in Italian: "Scrivi: start learning"). Then run the start-learning skill as soon as they do. Do nothing else before.</course-welcome>'
  exit 0
fi
source "$(dirname "$0")/course-lib.sh"
SID="$(printf '%s' "$INPUT" | jq -r '.session_id // empty')"
SOURCE="$(printf '%s' "$INPUT" | jq -r '.source // "startup"')"
case "$SOURCE" in startup|resume) ;; *) exit 0 ;; esac
[ -n "$SID" ] || exit 0
touch "$SESS"
LAST="$(cat "$STATE/last_activity" 2>/dev/null || echo 0)"
if grep -q '"end":null' "$SESS" 2>/dev/null; then
  jq -c --argjson last "$LAST" '
    if .end == null then
      (if $last > .start_epoch then $last else .start_epoch end) as $e
      | .end = ($e | todate) | .minutes = ((($e - .start_epoch) / 60) | floor) | .closed = "orphan"
    else . end' "$SESS" > "$SESS.tmp" && mv "$SESS.tmp" "$SESS"
fi
NOW="$(now_epoch)"
jq -nc --arg sid "$SID" --arg start "$(now_iso)" --argjson se "$NOW" \
  '{sid:$sid, start:$start, start_epoch:$se, end:null, minutes:null}' >> "$SESS"
echo "$NOW" > "$STATE/last_activity"
[ -f "$STATE/push_pending" ] && "$ROOT/.claude/hooks/course-sync.sh" >/dev/null 2>&1
if [ -f "$PROG" ]; then
  DONE="$(jq -r '[.lessons[] | select(.check_passed == true)] | length' "$PROG")"
  CUR="$(jq -r '.current // "00"' "$PROG")"
  XP="$(jq -r '.xp // 0' "$PROG")"
  LANG_="$(jq -r '.lang // "en"' "$PROG")"
  echo "<course-progress handle=\"$HANDLE\" lang=\"$LANG_\" xp=\"$XP\">Phases passed: $DONE/10. Current phase: $CUR. The learner is here to learn: greet them in their language and offer /learn.</course-progress>"
fi
exit 0
