#!/bin/bash
# First-run setup for a learner. Idempotent. Run from the repo root: bin/setup.sh
# /start-learning fills .course/{lang,channel,name} first, so this never has to ask.
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"; cd "$ROOT"
echo "== Claude Code from Scratch: setup =="
for t in git gh jq claude; do command -v "$t" >/dev/null 2>&1 || { echo "Missing: $t. See README prerequisites."; exit 1; }; done
gh auth status >/dev/null 2>&1 || { echo "Run: gh auth login"; exit 1; }
HANDLE="$(gh api user --jq .login | tr '[:upper:]' '[:lower:]')"
[ -n "$HANDLE" ] || { echo "Could not read your GitHub login."; exit 1; }
mkdir -p .course
LANG_="$(cat .course/lang 2>/dev/null || true)"
[ -n "$LANG_" ] || { read -r -p "Language [en/it]: " LANG_; LANG_="${LANG_:-en}"; }
CHANNEL="$(cat .course/channel 2>/dev/null || true)"
[ -n "$CHANNEL" ] || { read -r -p "Your growth area (meta, tiktok, aso, geo, ugc, markets, other): " CHANNEL; CHANNEL="${CHANNEL:-other}"; }
NAME="$(cat .course/name 2>/dev/null || true)"
[ -n "$NAME" ] || { read -r -p "Your name (for the certificate): " NAME; NAME="${NAME:-$HANDLE}"; }
WS="$(cat .course/workspace 2>/dev/null || echo "$HOME/Finanz/growth-os")"
printf '%s' "$HANDLE" > .course/handle; printf '%s' "$LANG_" > .course/lang
printf '%s' "$CHANNEL" > .course/channel; printf '%s' "$NAME" > .course/name; printf '%s' "$WS" > .course/workspace
echo "Handle: $HANDLE  lang: $LANG_  channel: $CHANNEL  workspace: $WS"
BR="learner/$HANDLE"
PROGRESS_URL="https://github.com/Marco23w/claude-code-from-scratch-progress.git"
git remote get-url progress >/dev/null 2>&1 || git remote add progress "$PROGRESS_URL"
if git show-ref --verify --quiet "refs/heads/$BR"; then git checkout -q "$BR"; else git checkout -q -b "$BR"; fi
git fetch -q progress "$BR" 2>/dev/null && git merge -q --ff-only "progress/$BR" 2>/dev/null || true
if [ ! -d "$WS" ]; then
  mkdir -p "$WS/reports" "$WS/work" "$WS/.claude"
  ( cd "$WS" && git init -q && cp "$ROOT/reference/STATUS_template.md" STATUS.md && printf '.DS_Store\nwork/\n*.csv\n' > .gitignore && git add -A && git -c user.name="$NAME" -c user.email="$HANDLE@course.local" commit -qm "growth-os: start" )
  echo "Workspace created: $WS"
else
  echo "Workspace exists: $WS"
fi
PROG="progress/$HANDLE.json"
if [ ! -f "$PROG" ]; then
  jq --arg h "$HANDLE" --arg n "$NAME" --arg l "$LANG_" --arg w "$WS" --arg c "$CHANNEL" --arg d "$(date +%F)" \
    '.handle=$h | .name=$n | .lang=$l | .workspace=$w | .channel=$c | .started=$d' progress/_template.json > "$PROG"
  : > "progress/$HANDLE.sessions.jsonl"
fi
printf '{"session_id":"setup-test","source":"startup"}' | CLAUDE_PROJECT_DIR="$ROOT" .claude/hooks/course-session-start.sh >/dev/null
printf '{"session_id":"setup-test","reason":"other"}' | CLAUDE_PROJECT_DIR="$ROOT" .claude/hooks/course-session-end.sh >/dev/null
grep -q '"sid":"setup-test"' "progress/$HANDLE.sessions.jsonl" && echo "Hooks: ok" || { echo "Hooks: FAILED"; exit 1; }
[ -f .course/push_pending ] && echo "Branch $BR committed locally (push to the private progress repo will retry at the next session; ask Marco to add you as collaborator)." || echo "Branch $BR in sync with the private progress repo."
echo
echo "Done :) Now run:  claude   and then  /learn"
