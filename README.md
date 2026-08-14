# coding-agent-skills

Reusable skills and commands for AI coding agents.

## Claude Code

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

### Staying up to date

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

**Manual update:**

```
/plugin update coding-agent-skills
```

A restart is required for the update to take effect.

## OpenCode

After cloning this repository, add its skills to the global OpenCode config at
`~/.config/opencode/opencode.json`. Replace `{absolute_path}` with the output
of `realpath /path/to/coding-agent-skills`:

```json
{
  "skills": {
    "paths": [
      "{absolute_path}/skills"
    ]
  }
}
```

### Invoking Skills

Skills are not available as slash commands in OpenCode. To invoke a skill:

- **Option 1** — Type `/skills` to browse and select a skill from the list
- **Option 2** — Mention it directly in chat, e.g. `use the make-plan skill for this task`

This repository does not currently include OpenCode-specific command files; use the skills path above to load its workflows.

## Codex

Marketplace install:

```bash
codex plugin marketplace add ludingx/coding-agent-skills
codex plugin add coding-agent-skills@coding-agent-skills
```

Start a new Codex session before using the installed skills. You can also use
`/plugins` to browse, install, or uninstall marketplace plugins interactively.

### Invoking Skills

To invoke a skill deliberately, reference it with `$` in your prompt. For
example:

```text
$make-plan Plan this change.
```

### Staying up to date

Refresh the marketplace to retrieve the latest version from `main`:

```bash
codex plugin marketplace upgrade coding-agent-skills
```

After upgrading, start a new Codex session before using updated skills.

## Workflow

The skills are designed to be used in sequence. A typical feature or bug fix flows like this:

### 1. Plan — `/make-plan`

Start here. Give it a task description or ticket. The model explores the codebase, thinks through the problem, and writes a plan to `.claude/plan/`.

### 2. Stress-test — `/grill-with-docs`

Optional but recommended for anything non-trivial. Run this after reviewing the plan to challenge assumptions, surface edge cases, and sharpen domain language. Updates ADRs and the glossary as decisions land.

### 3. Implement — `/implement`

Execute the approved plan. Follows surgical and simplicity constraints automatically. Uses `/tdd` at pre-agreed seams for new behaviour.

### 4. Review — `/code-review`

Run before raising a PR. Reviews against both coding standards and the original spec.

---

Other skills available when needed:

| Skill | When to use |
|---|---|
| `/grilling` | Stress-test a decision interactively |
| `/domain-modeling` | Capture or refine domain terminology |
| `/using-git-worktrees` | Isolate feature work from your current workspace |
| `/handoff` | Hand context to another agent or session |
| `/delivery-workflow` | Follow the end-to-end delivery workflow |
