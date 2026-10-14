#!/bin/bash
# Writes progress/<handle>.certificate.md once all 10 phases are passed. Marco signs it by
# flipping capstone_review to passed from /corso-team; until then it says "pending review".
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
H="$(cat "$ROOT/.course/handle" 2>/dev/null)"; PROG="$ROOT/progress/$H.json"; B="$ROOT/badges.json"
N="$(jq -r '[.lessons[] | select(.check_passed == true)] | length' "$PROG")"
[ "$N" -ge 10 ] || { echo "Certificate needs all 10 phases ($N/10 so far)."; exit 1; }
NAME="$(jq -r '.name // .handle' "$PROG")"; XP="$(jq -r '.xp' "$PROG")"
MIN="$(jq -r '[.lessons[].minutes // 0] | add' "$PROG")"
STATUS="$(jq -r '.capstone_review.status // "pending"' "$PROG")"
OUT="$ROOT/progress/$H.certificate.md"
{
echo "# 🎓 Claude Code from Scratch: certificate"
echo
echo "**$NAME** completed all 10 phases of Claude Code from Scratch (Finanz growth edition)."
echo
echo "- Finished: $(date +%F)"
echo "- XP: $XP  ·  Hours logged: $(( MIN / 60 ))h $(( MIN % 60 ))m (DERIVED from session time)"
echo "- Capstone review: $STATUS"
echo
echo "## Badges"
for id in 00 01 02 03 04 05 06 07 08 09; do
  echo "- $(jq -r --arg id "$id" '.phases[$id].emoji + "  " + .phases[$id].badge' "$B")"
done
echo
echo "Signed by growth: Marco Amico, Head of Growth, Finanz (valid when capstone review = passed)."
} > "$OUT"
echo "Certificate written: progress/$H.certificate.md (status: $STATUS)"
exit 0
