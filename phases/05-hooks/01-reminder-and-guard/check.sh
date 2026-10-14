#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
S="$COURSE_WS/.claude/settings.json"
need_json "$S" ".claude/settings.json is valid JSON"
jq -e '.hooks.UserPromptSubmit' "$S" >/dev/null 2>&1 && pass "has a UserPromptSubmit hook" || fail "has a UserPromptSubmit hook"
jq -e '.hooks.PreToolUse' "$S" >/dev/null 2>&1 && pass "has a PreToolUse hook" || fail "has a PreToolUse hook"
H="$COURSE_WS/.claude/hooks"
R="$(ls "$H"/*remind* 2>/dev/null | head -1)"; G="$(ls "$H"/*guard* 2>/dev/null | head -1)"
[ -n "$R" ] && [ -x "$R" ] && pass "reminder script exists and is executable" || fail "reminder script .claude/hooks/*remind*.sh exists and is executable (chmod +x)"
[ -n "$G" ] && [ -x "$G" ] && pass "guard script exists and is executable" || fail "guard script .claude/hooks/*guard*.sh exists and is executable (chmod +x)"
if [ -n "$R" ]; then OUT="$(printf '{"prompt":"hi"}' | "$R" 2>/dev/null)"; [ -n "$OUT" ] && pass "reminder prints something on a sample prompt" || fail "reminder prints something on a sample prompt"; fi
DANGER="r""m -r""f /tmp/x"
if [ -n "$G" ]; then printf '{"tool_name":"Bash","tool_input":{"command":"%s"}}' "$DANGER" | "$G" >/dev/null 2>&1; [ $? -eq 2 ] && pass "guard exits 2 on a recursive delete" || fail "guard exits 2 on a Bash recursive-delete input"; fi
if [ -n "$G" ]; then printf '{"tool_name":"Bash","tool_input":{"command":"ls"}}' | "$G" >/dev/null 2>&1; [ $? -eq 0 ] && pass "guard exits 0 on 'ls'" || fail "guard exits 0 on a harmless command"; fi
finish
