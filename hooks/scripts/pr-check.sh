#!/bin/bash
# Reads the Bash tool command from CLAUDE_TOOL_INPUT (JSON: {"command": "..."})
# Outputs a reminder if a PR/MR submission command is detected.

COMMAND=$(echo "${CLAUDE_TOOL_INPUT}" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('command', ''))
except Exception:
    print('')
" 2>/dev/null)

if echo "$COMMAND" | grep -qE '(git push|gh pr create|gh pr edit|glab mr create|glab mr update)'; then
  echo "PR_GUARDIAN: Submission command detected. Invoke the pr-guardian skill before proceeding — check title, description, tests, and the .pr-guardian.yml checklist for this repo."
  exit 0
fi
