#!/bin/bash
# UserPromptSubmit hook: prints your channel's next deadline once a day (sentinel pattern).
# Edit DEADLINE and DOW. Never blocks: always exit 0.
DEADLINE="Weekly <channel> recap due Monday 10:00 (run /<channel>-weekly)"
DOW_DUE=1   # ISO weekday the deadline falls on: 1=Mon .. 7=Sun

ROOT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
STATE="$ROOT/.claude/state"; mkdir -p "$STATE" 2>/dev/null
TODAY="$(date +%F)"
SENTINEL="$STATE/deadline-reminder-$TODAY"
[ -f "$SENTINEL" ] && exit 0
touch "$SENTINEL"
DOW="$(date +%u)"
DAYS_LEFT=$(( (DOW_DUE - DOW + 7) % 7 ))
echo "<reminder>$DEADLINE. Days left: $DAYS_LEFT.</reminder>"
exit 0
