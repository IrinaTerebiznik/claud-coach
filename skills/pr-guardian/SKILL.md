---
name: pr-guardian
description: "Standalone PR/MR checklist enforcer. No mentor mode, no teaching — just a fast, direct checklist check. Activates when the user runs git push, gh pr create, glab mr create, signals they are done with a task, or invokes /pr-guardian directly. Does not require mentor to be active."
argument-hint: [branch-name]
version: 1.1.0
---

# PR Guardian

Catch missing or low-quality PR/MR metadata before it reaches a reviewer. This is a checklist enforcer, not a teaching moment.

## Activation

Activate automatically when detecting:
- `git push` with a remote tracking branch
- `gh pr create`, `glab mr create`, `glab mr update`
- User signals they are done with a task or feature

Also user-invokable via `/pr-guardian`.

## Execution Steps

### Step 1 — Load the checklist

Look for `.pr-guardian.yml` in the current repo root.
- If found: use it as the checklist source.
- If not found: use the Default Checklist defined in `references/checklist-template.md`.

### Step 2 — Gather PR context

Run the following to understand the change:
```
git diff main...HEAD --stat
git log main...HEAD --oneline
```

If a PR/MR already exists (e.g. the branch has an open MR), fetch its current title and description via the appropriate CLI (`gh pr view` or `glab mr view`).

### Step 3 — Run the checklist

For each item, assign a status:
- `✓` — clearly satisfied
- `✗` — missing or not acceptable
- `?` — cannot confirm without user input

### Step 4 — Report and block if needed

Output a compact checklist summary. If any `✗` items exist, do not let the submission proceed silently — present them and ask the user to address them first. If only `?` items remain, ask the user to confirm each one before continuing.

## Output Format

```
PR Guardian — [branch-name]

Title:     ✓ "Add retry logic for failed MQTT connections"
           ✗ Title must start with ticket number (PROJ-123)

Description:
           ✓ Explains why the change was needed
           ✗ Missing test steps
           ? Screenshots — does this affect any UI? (yes/no)

Code:
           ✓ Unit tests added
           ✗ 2 TODO comments left without tracking issue
           ✓ No debug logs or commented-out code

Required sections:
           ✓ ## Summary
           ✗ ## Test Plan — missing

Issues to fix before submitting: 3
```

## Reading `.pr-guardian.yml`

See `references/checklist-template.md` for the full format and a ready-to-copy template.

Required sections (if listed under `required_sections`) are checked by scanning the PR description for exact heading matches.

## Tone

Direct. Scannable. No explanations for why items matter — the developer is responsible for knowing. One line per item, status symbol first.

## Companion Hook: Pre-push Code Review

A `PreToolUse` agent hook can be added to `~/.claude/settings.json` to automatically scan for artifacts before every `git push` in a given directory scope. It complements pr-guardian by catching code-level issues (debug logs, commented-out code, test artifacts) before the PR metadata check.

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "agent",
            "if": "Bash(git push*)",
            "statusMessage": "Reviewing changes before push...",
            "timeout": 60,
            "prompt": "Pre-push code review gate.\n\nStep 1: Run pwd. If the current directory is NOT under /home/orbito/Repos/, output exactly this JSON and stop:\n{\"hookSpecificOutput\": {\"hookEventName\": \"PreToolUse\", \"permissionDecision\": \"allow\"}}\n\nStep 2: Run: git diff main..HEAD to get the full diff of changes about to be pushed.\n\nStep 3: Perform a thorough code review of the diff. Check for:\n\nARTIFACTS (must block):\n- debug print() or console.log statements left in\n- commented-out code blocks\n- test-only hardcoded values or artifacts\n- TODO comments without a linked ticket/issue\n\nCODE QUALITY (block if significant):\n- logic errors or incorrect behavior\n- security issues (hardcoded secrets, injection risks, unsafe input handling)\n- missing error handling for cases that can realistically fail\n- broken or missing tests for new behavior\n- naming or clarity issues that would confuse a reviewer\n\nStep 4a: If issues found, output exactly this JSON (fill in a concise summary of findings):\n{\"hookSpecificOutput\": {\"hookEventName\": \"PreToolUse\", \"permissionDecision\": \"deny\", \"permissionDecisionReason\": \"Code review found issues:\\n<list each issue on its own line>\"}}\n\nStep 4b: If the code looks good, output exactly this JSON:\n{\"hookSpecificOutput\": {\"hookEventName\": \"PreToolUse\", \"permissionDecision\": \"allow\"}}"
          }
        ]
      }
    ]
  }
}
```

Adjust the path in Step 1 to match the desired scope (e.g. `/home/user/Repos/`).
