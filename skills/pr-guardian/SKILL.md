---
name: pr-guardian
description: "This skill should be used when the user is about to create or submit a pull request or merge request, when the user runs git push with a remote branch, when the user runs gh pr create or glab mr create or similar PR/MR commands, when the user says they are done with a feature or ready to submit, or when the user asks to review or check their PR or MR before it goes up."
argument-hint: [branch-name]
version: 1.0.0
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
