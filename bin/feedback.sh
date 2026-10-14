#!/bin/bash
# Usage: bin/feedback.sh <phase|general> "<text>"  -> appends to progress/<handle>.feedback.jsonl and syncs (private repo).
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
H="$(cat "$ROOT/.course/handle" 2>/dev/null)"; [ -n "$H" ] || { echo "Run bin/setup.sh first"; exit 1; }
PH="${1:?phase id or 'general'}"; TXT="${2:?feedback text}"
F="$ROOT/progress/$H.feedback.jsonl"
jq -nc --arg ph "$PH" --arg t "$TXT" --arg at "$(date -u +%FT%TZ)" '{at:$at, phase:$ph, text:$t, status:"new"}' >> "$F"
echo "Feedback saved (phase $PH). Marco reads it on Monday. Thank you :)"
"$ROOT/.claude/hooks/course-sync.sh"
[ -f "$ROOT/.course/push_pending" ] && echo "Push pending (offline?): it will retry at the next session." || echo "Synced to the private progress repo."
exit 0
