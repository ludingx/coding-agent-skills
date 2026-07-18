# software-agent-skills

Reusable skills and commands for AI coding agents — Claude Code.

## Structure

```
skills/
  surgical-changes/SKILL.md   # Smallest change that satisfies the task
  tdd/SKILL.md                # Test-driven development, red-green-refactor
.claude/
  commands/
    build.md                  # /build slash command for Claude Code
CLAUDE.md                     # Claude Code instructions
plugin.json                   # Claude Code plugin registration
```

## Skills

### surgical-changes
Make the minimum change required — no scope creep, no speculative cleanup, no unasked-for abstractions. Use when implementing features, fixing bugs, or writing tests in an existing codebase.

### tdd
Test-driven development using vertical slices (tracer bullets). One failing test → minimal code to pass → next slice. Avoids the horizontal-slicing anti-pattern of writing all tests up front.

## Commands

### /build (Claude Code)
End-to-end workflow for delivering a Jira ticket: fetch ticket → plan → TDD implementation → raise PR → monitor CI → cleanup.

## Setup

Marketplace install:

```
/plugin marketplace add ludingx/coding-agent-skills
/plugin install coding-agent-skills@coding-agent-skills
```

Local / development install:

```
git clone git@github.com:ludingx/coding-agent-skills.git
claude --plugin-dir /path/to/coding-agent-skills
```

## Staying up to date

This is a third-party marketplace, so Claude Code does not auto-update it by default. The plugin tracks `ref: main` with no pinned sha, so every commit on main is treated as a new version — but you still need auto-update enabled for the marketplace to pick those up automatically.

**Option 1 — Enable auto-update (one-time):**

```
/plugin
```

Then go to the **Marketplaces** tab, select `coding-agent-skills`, and enable auto-update.

**Option 2 — Env var override:**

```
export FORCE_AUTOUPDATE_PLUGINS=1
```

**Option 3 — Via managed settings:**

Add to a managed `settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "coding-agent-skills": {
      "source": { "source": "github", "repo": "ludingx/coding-agent-skills" },
      "autoUpdate": true
    }
  }
}
```

**Manual update (always works):**

```
/plugin update coding-agent-skills
```

A restart is required for the update to take effect.

