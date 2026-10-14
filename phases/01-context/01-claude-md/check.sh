#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
F="$COURSE_WS/CLAUDE.md"
need_file "$F" "CLAUDE.md exists in your workspace"
need_grep '^## ?(Who|Chi)' "$F" "has a 'Who' section (who you are, your channel)"
need_grep '^## ?(Where numbers come from|Da dove vengono i numeri)' "$F" "has a 'Where numbers come from' section"
need_grep '^## ?(Stop and ask|Fermati e chiedi)' "$F" "has a 'Stop and ask' section"
IMP="$(grep -Eo '^@[^ ]+' "$F" | head -1 | sed 's/^@//')"
if [ -n "$IMP" ] && [ -f "$COURSE_WS/$IMP" ]; then pass "imports an existing file with @ ($IMP)"; else fail "imports an existing file with @ (e.g. @glossary.md, and the file must exist)"; fi
deny_grep "$SECRET_RE" "$F" "no token-shaped string inside"
finish
