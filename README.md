# claud-coach

> A Claude Code plugin that teaches you to think instead of handing you answers — and blocks sloppy PRs before they reach your reviewers.

Built for developers still building their instincts, and for everyone who keeps forgetting things before hitting submit. **Especially useful for developers with ADHD or ADD** — every response is short, structured, and one thing at a time.

---

## What it does

- **Guides you through tasks** with questions instead of answers (shadowing mode)
- **Checks your PR** automatically before every `git push` or `gh pr create`
- **Quick sanity check** on demand with `/wdyt` — fast verdict, no lecture

---

## Commands

Once the plugin is installed, use these in any Claude Code session:

**Mentor mode** — teaching companion with built-in PR checks:

| Command | What it does |
|---|---|
| `/dev-mentor:mentor` | Start or re-enter mentor mode |
| `/dev-mentor:mentor shadowing` | Jump straight into guided task mode |
| `/dev-mentor:mentor straight` | Switch to direct answers |
| `/dev-mentor:wdyt` | Quick sanity check on recent changes |

**PR Guardian** — standalone, no mentor needed:

| Command | What it does |
|---|---|
| `/dev-mentor:pr-guardian` | Run the PR checklist — direct, no teaching |

PR Guardian runs **automatically** before `git push` and `gh pr create`, regardless of which mode is active.

---

## Install

```bash
# In Claude Code
/plugins add https://github.com/IrinaTerebiznik/claud-coach
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

No `.pr-guardian.yml`? It falls back to a sensible default. See [`skills/pr-guardian/references/checklist-template.md`](skills/pr-guardian/references/checklist-template.md) for examples.

---

## Testing in a clean environment

Uses Docker to spin up a fresh environment with no existing Claude Code config or plugins.

**1. Build the image:**
```bash
docker build -t claud-coach-test .
```

**2. Create a `.env` file in the project root:**
```bash
ANTHROPIC_API_KEY=your_key_here
```

> `.env` is already in `.gitignore` — your key won't be committed.

**3. Run a clean container:**
```bash
docker run -it --rm \
  -v $(pwd):/plugin \
  --env-file .env \
  claud-coach-test bash
```

**4. Inside the container, start Claude with the plugin loaded:**
```bash
claude --plugin-dir /plugin
```

**5. Verify it works:**
- Session-start greeting appears with the three mode options
- Commands respond: `/dev-mentor:mentor`, `/dev-mentor:wdyt`, `/dev-mentor:pr-guardian`
- Hook fires when you run `git push`

---

## Use as a template

This repo is a GitHub template. Click **"Use this template"** to fork it as a starting point for your own Claude Code plugin.

---

## License

[MIT](LICENSE)
