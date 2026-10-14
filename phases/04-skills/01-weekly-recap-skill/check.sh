#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
S="$(ls -d "$COURSE_WS"/.claude/skills/*-weekly 2>/dev/null | head -1)"
[ -n "$S" ] && pass "a skill folder named <channel>-weekly exists" || fail "a skill folder .claude/skills/<channel>-weekly exists"
[ -n "$S" ] && need_file "$S/SKILL.md" "it has SKILL.md"
[ -n "$S" ] && need_grep '^name: ' "$S/SKILL.md" "frontmatter has name:"
[ -n "$S" ] && { [ "$(grep -m1 '^name:' "$S/SKILL.md" | awk '{print $2}')" = "$(basename "$S")" ] && pass "name equals the folder name" || fail "name equals the folder name"; }
[ -n "$S" ] && { L="$(awk '/^description:/{f=1} f&&/^[a-z]+:/&&!/^description:/{f=0} f' "$S/SKILL.md" | wc -c | tr -d ' ')"; [ "$L" -ge 80 ] && pass "description is at least 80 characters (it is the trigger)" || fail "description is at least 80 characters (it is the trigger)"; }
W="$(ls "$COURSE_WS"/reports/weekly-W[0-9][0-9].md 2>/dev/null | head -1)"
[ -n "$W" ] && pass "reports/weekly-Wnn.md produced by the skill" || fail "reports/weekly-Wnn.md produced by running the skill"
for h in 'Answer' 'Sources'; do [ -n "$W" ] && need_grep "^## .*$h" "$W" "weekly report has a '$h' section"; done
finish
