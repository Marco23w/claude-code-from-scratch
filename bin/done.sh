#!/bin/bash
# Usage: bin/done.sh 03 [quiz_correct] -> runs the check; if it passes, records completion,
# awards XP and the badge, syncs progress. Prints the unlock banner.
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ID="$(printf '%02d' "$((10#${1:?phase id}))")"; QUIZ="${2:-}"
H="$(cat "$ROOT/.course/handle" 2>/dev/null)"; [ -n "$H" ] || { echo "Run bin/setup.sh first"; exit 1; }
PROG="$ROOT/progress/$H.json"; SESS="$ROOT/progress/$H.sessions.jsonl"
"$ROOT/bin/check.sh" "$ID" || { echo "Not yet: fix the [..] lines above, then run /done again."; exit 1; }
if jq -e --arg id "$ID" '.lessons[$id].check_passed == true' "$PROG" >/dev/null; then
  echo "Phase $ID was already passed. Nothing changes."; exit 0; fi
NOW_ISO="$(date -u +%Y-%m-%dT%H:%M:%SZ)"; NOW="$(date +%s)"
PREV="$(jq -r '[.lessons[] | select(.check_passed == true) | .completed_at] | max // .started' "$PROG")"
PREV_EPOCH="$(date -j -u -f "%Y-%m-%dT%H:%M:%SZ" "$PREV" +%s 2>/dev/null || date -j -f "%Y-%m-%d" "$PREV" +%s 2>/dev/null || echo 0)"
MIN=0
if [ -s "$SESS" ]; then
  MIN="$(jq -s --argjson p "$PREV_EPOCH" --argjson now "$NOW" '
    [ .[] | select(.start_epoch >= $p) | (.minutes // ((($now - .start_epoch) / 60) | floor)) ] | add // 0' "$SESS")"
fi
NQ="$(jq -r '[.questions[] | select(.stage=="post")] | length' "$(ls -d "$ROOT"/phases/"$ID"-*/[0-9][0-9]-*/ | head -1)quiz.json" 2>/dev/null || echo 0)"
XP_GAIN=100; [ -n "$QUIZ" ] && [ "$NQ" -gt 0 ] && [ "$QUIZ" -ge "$NQ" ] && XP_GAIN=150
NEXT="$(printf '%02d' $((10#$ID + 1)))"; [ "$NEXT" = "10" ] && NEXT="done"
jq --arg id "$ID" --arg at "$NOW_ISO" --argjson min "$MIN" --arg next "$NEXT" --argjson xp "$XP_GAIN" --arg quiz "${QUIZ:-}" '
  .lessons[$id] = ((.lessons[$id] // {}) | .completed_at = $at | .check_passed = true | .minutes = $min
                   | .attempts = (.attempts // 1) | .quiz = (if $quiz == "" then null else ($quiz | tonumber) end))
  | .xp = ((.xp // 0) + $xp)
  | .badges = ((.badges // []) + [$id] | unique)
  | .current = $next
  | if $id == "09" then .capstone_review = {"status":"pending","requested_at":$at} else . end' "$PROG" > "$PROG.tmp" && mv "$PROG.tmp" "$PROG"
# banner
B="$ROOT/badges.json"
EMOJI="$(jq -r --arg id "$ID" '.phases[$id].emoji' "$B")"; BADGE="$(jq -r --arg id "$ID" '.phases[$id].badge' "$B")"
UNLOCK="$(jq -r --arg id "$ID" '.phases[$id].unlock' "$B")"
XP="$(jq -r '.xp' "$PROG")"
TITLE="$(jq -r --argjson xp "$XP" '[.levels[] | select(.min_xp <= $xp)] | last | .title' "$B")"
echo
echo "=============================================="
echo "  $EMOJI  BADGE UNLOCKED: $BADGE"
echo "  $UNLOCK"
echo "  +$XP_GAIN XP  ->  total $XP XP  ->  level: $TITLE"
echo "=============================================="
[ "$NEXT" = "done" ] && "$ROOT/bin/certificate.sh" || echo "  Next: phase $NEXT. Run /learn when ready."
"$ROOT/.claude/hooks/course-sync.sh"
[ -f "$ROOT/.course/push_pending" ] && echo "Push pending (offline?): it will retry at the next session." || echo "Progress saved on learner/$H."
exit 0
