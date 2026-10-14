#!/bin/bash
# Shared helpers for the course hooks. Sourced, never run.
# Everything fails silent (exit 0): a tracking hook must never block a learner.
ROOT="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
STATE="$ROOT/.course"
[ -f "$STATE/handle" ] || exit 0
HANDLE="$(cat "$STATE/handle")"
[ -n "$HANDLE" ] || exit 0
PROG="$ROOT/progress/$HANDLE.json"
SESS="$ROOT/progress/$HANDLE.sessions.jsonl"
command -v jq >/dev/null 2>&1 || exit 0
now_iso() { date -u +%Y-%m-%dT%H:%M:%SZ; }
now_epoch() { date +%s; }
