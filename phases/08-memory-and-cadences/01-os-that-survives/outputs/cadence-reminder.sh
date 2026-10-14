#!/bin/bash
# UserPromptSubmit hook — cadence reminders + staleness sentinel.
# 1) Reads .claude/cadences.json; for each cadence past its due day in the current
#    period, emits ONE reminder per period (sentinel files in .claude/state/).
# 2) Once per day, scans STATUS.md of this workspace (last-updated vs review-interval)
#    and flags overdue project reviews.
# Requires jq. Fails silent (exit 0) — never blocks a prompt.

ROOT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
STATE="$ROOT/.claude/state"
CADENCES="$ROOT/.claude/cadences.json"
mkdir -p "$STATE" 2>/dev/null

command -v jq >/dev/null 2>&1 || exit 0
[ -f "$CADENCES" ] || exit 0

TODAY=$(date +%Y-%m-%d)
DOW=$(date +%u)                 # ISO: 1=Mon..7=Sun
DOM=$(date +%d | sed 's/^0//')
WEEK=$(date +%G-W%V)            # ISO week, e.g. 2026-W27
MONTH=$(date +%Y-%m)
Q=$(( ($(date +%m | sed 's/^0//') - 1) / 3 + 1 ))
QUARTER="$(date +%Y)-Q$Q"
QMONTH=$(( ($(date +%m | sed 's/^0//') - 1) % 3 + 1 ))  # month index within quarter (1..3)

# --- cadence reminders ---
REMINDERS=""
N=$(jq '.cadences | length' "$CADENCES" 2>/dev/null) || exit 0
i=0
while [ "$i" -lt "$N" ]; do
  ID=$(jq -r ".cadences[$i].id" "$CADENCES")
  TYPE=$(jq -r ".cadences[$i].type" "$CADENCES")
  MSG=$(jq -r ".cadences[$i].message" "$CADENCES")
  DUE=0; PERIOD=""
  case "$TYPE" in
    weekly)    DUE_DOW=$(jq -r ".cadences[$i].due_dow // 5" "$CADENCES"); [ "$DOW" -ge "$DUE_DOW" ] && DUE=1; PERIOD="$WEEK" ;;
    monthly)   DUE_DOM=$(jq -r ".cadences[$i].due_dom // 1" "$CADENCES"); [ "$DOM" -ge "$DUE_DOM" ] && DUE=1; PERIOD="$MONTH" ;;
    quarterly) [ "$QMONTH" -eq 1 ] && DUE=1; PERIOD="$QUARTER" ;;
  esac
  SENTINEL="$STATE/cadence-$ID-$PERIOD"
  if [ "$DUE" -eq 1 ] && [ ! -f "$SENTINEL" ]; then
    REMINDERS="$REMINDERS- $MSG\n"
    touch "$SENTINEL"
  fi
  i=$((i+1))
done
if [ -n "$REMINDERS" ]; then
  echo "<cadence-reminder>"
  printf "%b" "$REMINDERS"
  echo "Tell the owner these are due; run them only on their go (or if they are already the task at hand)."
  echo "</cadence-reminder>"
fi

# --- staleness sentinel (once per day) ---
DAILY="$STATE/staleness-check-$TODAY"
if [ ! -f "$DAILY" ]; then
  touch "$DAILY"
  OVERDUE=""
  for f in "$ROOT"/STATUS.md; do
    [ -f "$f" ] || continue
    PROJ="STATUS.md"
    LU=$(grep -m1 '^last-updated:' "$f" | awk '{print $2}')
    RI=$(grep -m1 '^review-interval:' "$f" | awk '{print $2}' | tr -d 'd')
    [ -n "$LU" ] && [ -n "$RI" ] || continue
    LU_EPOCH=$(date -j -f "%Y-%m-%d" "$LU" +%s 2>/dev/null) || continue
    AGE_D=$(( ( $(date +%s) - LU_EPOCH ) / 86400 ))
    if [ "$AGE_D" -gt "$RI" ]; then
      OVERDUE="$OVERDUE- $PROJ: STATUS.md is ${AGE_D}d old (review-interval ${RI}d)\n"
    fi
  done
  if [ -n "$OVERDUE" ]; then
    echo "<staleness-alert>"
    printf "%b" "$OVERDUE"
    echo "Flag the stale STATUS.md to the owner (update it or confirm it is still current)."
    echo "</staleness-alert>"
  fi
fi
exit 0
