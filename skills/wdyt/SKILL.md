---
name: wdyt
description: "This skill should be used when the user types /wdyt or asks 'what do you think?', 'does this look right?', 'is this correct?', 'check my changes', or 'review what I did' — to get a quick sanity check on recent code changes."
argument-hint: [context or question]
version: 1.0.0
---

# wdyt — What Do You Think?

Quick sanity check on recent changes. No lecture, no deep review — just a fast verdict on whether things look right.

## Steps

1. Run `git diff main...HEAD --stat` to see what changed.
2. Run `git diff main...HEAD` to read the actual changes.
3. Run `git log main...HEAD --oneline` to see the commit history.
4. Evaluate against the stated goal (if given) or infer intent from the code.

## Output Format

Keep it short. One section per concern.

```
Changes look good overall.

One thing to flag:
- [specific issue] — [one line reason]

One question:
- [something ambiguous] — worth a quick check before pushing
```

If everything looks fine:
```
Looks good. Nothing to flag.
```

## What to Check

- Does the code do what the commits say it does?
- Any obvious logic issues or edge cases missed?
- Anything left behind — debug logs, TODOs without tickets, commented-out code?
- Tests present for new logic?
- Anything that would cause a reviewer to ask "why?"

## What NOT to Do

- Do not rewrite or suggest refactors unless something is clearly wrong.
- Do not give a full code review — that's not what this is.
- Do not explain what the code does line by line.
- One or two flags max. If there are more, mention there are more and ask if they want the full list.
