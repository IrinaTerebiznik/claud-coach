# claud-coach

> A Claude Code extension that teaches you to think instead of thinking for you — guides you through problems with questions, not answers, and enforces proper PRs so you stop wasting your reviewers' time.

Built for junior developers still building their instincts, and for everyone who keeps forgetting things before hitting submit.

**Especially useful for developers with ADHD or ADD.** Every response is structured to avoid information overload — short, segmented, one thing at a time. The task planning format, the session modes, and the communication rules are all designed with neurodivergent developers in mind.

---

## What's inside

### `mentor` — always-on teaching mode
Starts every session with a greeting and asks how you want to work:
- **Shadowing** — guided step-by-step through a full task, with a structured plan, testing section, and PR checklist built in
- **Quick question** — targeted help on something specific
- **Straight answers** — skip the guiding entirely

In shadowing mode, plans are segmented by topic, revealed one step at a time, and always end with testing and a PR checklist — so nothing gets forgotten.

If you need a straight answer mid-session, it asks: *"Just this question, or switch to direct mode for the rest of the chat?"* Mentor mode is back on by default next session.

### `pr-guardian` — PR/MR checklist enforcer
Runs automatically when you push or create a PR. Checks title, description, tests, and any company-specific requirements defined in `.pr-guardian.yml` at the repo root.

Also invokable directly: `/pr-guardian`

### `/wdyt` — quick sanity check
Type `/wdyt` at any point to get a fast verdict on your recent changes. Not a full review — just flags anything obviously wrong or missing before you push.

---

## Install

```bash
# In Claude Code
/plugins add https://github.com/<your-username>/claud-coach
```

---

## Configure your checklist

Drop a `.pr-guardian.yml` at the root of any repo to define your team's requirements:

```yaml
# .pr-guardian.yml
title:
  - Starts with ticket number (e.g. PROJ-123)
  - Under 72 characters

description:
  - Linked ticket in description
  - Testing steps provided
  - Breaking changes noted if any

code:
  - Unit tests added or updated
  - No debug logs left in

required_sections:
  - "## Summary"
  - "## Test Plan"
```

No `.pr-guardian.yml`? It falls back to a sensible default. See [`skills/pr-guardian/references/checklist-template.md`](skills/pr-guardian/references/checklist-template.md) for more examples.

---

## Use as a template

This repo is a GitHub template. Click **"Use this template"** to fork it as a starting point for your own Claude Code extension.

---

## License

[MIT](LICENSE)
