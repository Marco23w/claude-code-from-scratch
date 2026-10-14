#!/bin/bash
# Tiny assertion helpers for phase check.sh files. Source it, then use ok/ko.
FAILS=0
pass() { echo "  [ok] $1"; }
fail() { echo "  [..] $1"; FAILS=$((FAILS+1)); }
need_file() { [ -f "$1" ] && pass "$2" || fail "$2"; }
need_dir()  { [ -d "$1" ] && pass "$2" || fail "$2"; }
need_grep() { grep -Eq "$1" "$2" 2>/dev/null && pass "$3" || fail "$3"; }
deny_grep() { if [ -f "$2" ] && grep -Eq "$1" "$2" 2>/dev/null; then fail "$3"; else pass "$3"; fi; }
need_json() { jq -e . "$1" >/dev/null 2>&1 && pass "$2" || fail "$2"; }
finish() { [ "$FAILS" -eq 0 ]; }
# patterns that look like a secret: long tokens, sk-..., EAAB..., ghp_...
SECRET_RE='(sk-[A-Za-z0-9]{10,}|EAA[A-Za-z0-9]{20,}|ghp_[A-Za-z0-9]{20,}|xox[abp]-[A-Za-z0-9-]{10,}|eyJ[A-Za-z0-9_-]{30,})'
