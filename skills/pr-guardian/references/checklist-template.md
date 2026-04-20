# PR Guardian — Checklist Template

Drop a `.pr-guardian.yml` file at your repo root to define team-specific requirements.
PR Guardian reads this file automatically on every PR submission.

## Full Format

```yaml
# .pr-guardian.yml
# Drop this at the root of your repo and adjust to your team's standards.

title:
  - Descriptive (not "fix", "wip", "update", or similar vague labels)
  - Starts with a verb (Add, Fix, Refactor, Remove, Update)
  - Under 72 characters

description:
  - Explains why the change was made, not just what changed
  - Includes steps to test or reproduce
  - Notes breaking changes if any

code:
  - Unit tests added or updated for new logic
  - No debug logs, console.logs, or print statements left in
  - No commented-out code blocks
  - TODO comments have a linked issue or ticket

required_sections:
  - "## Summary"
  - "## Test Plan"
```

## Minimal Version (just the essentials)

```yaml
# .pr-guardian.yml
title:
  - Descriptive and under 72 characters

description:
  - Explains why

code:
  - Tests added
  - No debug code

required_sections:
  - "## Summary"
```

## Example: Team with Ticket Numbers

```yaml
# .pr-guardian.yml
title:
  - Starts with ticket number (e.g. PROJ-123)
  - Under 72 characters

description:
  - Linked ticket URL in description
  - Testing steps provided
  - Breaking changes noted if applicable

code:
  - Unit tests added or updated
  - No debug logs
  - CHANGELOG updated if public API changed

required_sections:
  - "## Summary"
  - "## Test Plan"
  - "## Files Updated"
```

## Example: Open Source / GitHub Flow

```yaml
# .pr-guardian.yml
title:
  - Starts with a verb (Add, Fix, Refactor, Remove)
  - Under 72 characters
  - No issue number required

description:
  - Motivation explained
  - Steps to reproduce the bug (for fixes) or use the feature (for additions)
  - Screenshots for UI changes

code:
  - Tests present
  - No debug code
  - Docs updated if public API changed

required_sections:
  - "## What"
  - "## Why"
  - "## How to test"
```

## Notes

- `required_sections` items are matched as exact heading strings in the PR description.
- All fields under `title`, `description`, and `code` are treated as human-readable rules — PR Guardian evaluates them by reasoning about the actual PR content, not regex matching.
- If `.pr-guardian.yml` is absent, PR Guardian falls back to the default checklist built into the skill.
