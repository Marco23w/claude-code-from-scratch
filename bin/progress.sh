#!/bin/bash
# Prints the learner's progress in one screen: badges, XP, level, phases.
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
H="$(cat "$ROOT/.course/handle" 2>/dev/null)"; [ -n "$H" ] || { echo "Run bin/setup.sh first"; exit 1; }
PROG="$ROOT/progress/$H.json"; B="$ROOT/badges.json"
XP="$(jq -r '.xp // 0' "$PROG")"
TITLE="$(jq -r --argjson xp "$XP" '[.levels[] | select(.min_xp <= $xp)] | last | .title' "$B")"
jq -r '"Learner: \(.name // .handle) (@\(.handle))  lang: \(.lang)  channel: \(.channel)\nWorkspace: \(.workspace)\nCurrent phase: \(.current)"' "$PROG"
echo "XP: $XP  ->  level: $TITLE"
echo "Badges:"
for id in 00 01 02 03 04 05 06 07 08 09; do
  E="$(jq -r --arg id "$id" '.phases[$id].emoji' "$B")"; N="$(jq -r --arg id "$id" '.phases[$id].badge' "$B")"
  if jq -e --arg id "$id" '.badges | index($id)' "$PROG" >/dev/null 2>&1; then echo "  $E  $id  $N"; else echo "  🔒  $id  $N"; fi
done
[ -f "$ROOT/.course/push_pending" ] && echo "WARNING: a push is pending (offline?)."
exit 0
