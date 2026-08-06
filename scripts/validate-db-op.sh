#!/bin/bash
INPUT=$(cat)
QUERY=$(echo "$INPUT" | jq -r '.tool_input.query // empty')
if echo "$QUERY" | grep -iE '\b(DROP|TRUNCATE)\b' > /dev/null; then
  echo "Blocked: DROP/TRUNCATE require explicit user confirmation first." >&2
  exit 2
fi
exit 0