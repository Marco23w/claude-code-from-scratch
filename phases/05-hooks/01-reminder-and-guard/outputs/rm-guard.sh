#!/bin/bash
# PreToolUse hook (matcher: Bash): blocks recursive deletes. Exit 2 = block, stderr = reason.
INPUT="$(cat)"
CMD="$(printf '%s' "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)"
if printf '%s' "$CMD" | grep -Eq '(^|[;&| ])rm[[:space:]]+-[A-Za-z]*r'; then
  echo "Blocked by rm-guard: recursive delete is not allowed here. Delete by hand if you really mean it." >&2
  exit 2
fi
exit 0
