#!/bin/bash
# Usage: bin/check.sh 03   -> runs phases/03-*/01-*/check.sh against the learner's workspace.
# Prints one line per criterion, then RESULT: PASS|FAIL. Records the attempt in progress.
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ID="$(printf '%02d' "$((10#${1:?phase id, e.g. 03}))")"
PH="$(ls -d "$ROOT/phases/$ID"-* 2>/dev/null | head -1)"
[ -d "$PH" ] || { echo "No phase $ID"; exit 1; }
LESSON="$(ls -d "$PH"/[0-9][0-9]-* 2>/dev/null | head -1)"
[ -x "$LESSON/check.sh" ] || { echo "Phase $ID has no check yet"; exit 1; }
export COURSE_ROOT="$ROOT"
export COURSE_HANDLE="$(cat "$ROOT/.course/handle" 2>/dev/null)"
export COURSE_WS="$(cat "$ROOT/.course/workspace" 2>/dev/null)"
export COURSE_CHANNEL="$(cat "$ROOT/.course/channel" 2>/dev/null)"
export COURSE_LESSON_DIR="$LESSON"
[ -d "$COURSE_WS" ] || { echo "Workspace not found: $COURSE_WS (run bin/setup.sh)"; exit 1; }
OUT="$("$LESSON/check.sh" 2>&1)"; RC=$?
echo "$OUT"
PROG="$ROOT/progress/$COURSE_HANDLE.json"
if [ -z "$COURSE_NO_COUNT" ] && [ -f "$PROG" ] && command -v jq >/dev/null; then
  jq --arg id "$ID" '.lessons[$id] = ((.lessons[$id] // {}) | .attempts = ((.attempts // 0) + 1))' "$PROG" > "$PROG.tmp" && mv "$PROG.tmp" "$PROG"
fi
if [ $RC -eq 0 ]; then echo "RESULT: PASS $ID"; else echo "RESULT: FAIL $ID"; fi
exit $RC
