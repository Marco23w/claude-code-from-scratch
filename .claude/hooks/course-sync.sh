#!/bin/bash
# Commit ONLY the progress files and push to learner/<handle>.
# Offline or slow: the commit stays local and .course/push_pending makes the next session retry.
source "$(dirname "$0")/course-lib.sh"
cd "$ROOT" || exit 0
BRANCH="$(git branch --show-current 2>/dev/null)"
[ "$BRANCH" = "learner/$HANDLE" ] || exit 0
for f in "progress/$HANDLE.json" "progress/$HANDLE.sessions.jsonl" "progress/$HANDLE.certificate.md"; do [ -f "$f" ] && git add -- "$f" 2>/dev/null; done
if ! git diff --cached --quiet 2>/dev/null; then
  git -c user.name="$HANDLE" -c user.email="$HANDLE@course.local" commit -qm "progress: $HANDLE $(date +%F)" >/dev/null 2>&1
fi
git remote get-url origin >/dev/null 2>&1 || exit 0
if [ -n "$(git log "origin/$BRANCH..$BRANCH" --oneline 2>/dev/null)" ] || [ -f "$STATE/push_pending" ] || ! git show-ref --verify --quiet "refs/remotes/origin/$BRANCH"; then
  if perl -e 'alarm 20; exec @ARGV' git push -q -u origin "$BRANCH" >/dev/null 2>&1; then
    unlink "$STATE/push_pending" 2>/dev/null
  else
    touch "$STATE/push_pending"
  fi
fi
exit 0
