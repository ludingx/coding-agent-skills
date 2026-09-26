# coding-agent-skills

Reusable skills for AI coding agents, supporting general software engineering work—from clarifying requirements and planning through implementation, review, and delivery.

## Installation

These skills work with Claude Code, OpenCode, and Codex.

<details>
<summary><strong>Claude Code</strong></summary>

Marketplace install:

```text
/plugin marketplace add ludingx/coding-agent-skills
/plugin install coding-agent-skills@coding-agent-skills
```

Local / development install:

```bash
git clone git@github.com:ludingx/coding-agent-skills.git
claude --plugin-dir /path/to/coding-agent-skills
```

### Staying up to date

Claude Code does not automatically update third-party marketplaces by default. Enable auto-update from the `/plugin` command's **Marketplaces** tab, or configure the marketplace in managed settings. You can also update manually:

```text
/plugin update coding-agent-skills
```

Restart Claude Code for updates to take effect.

</details>

<details>
<summary><strong>OpenCode</strong></summary>

After cloning this repository, add its skills to the global OpenCode config at
`~/.config/opencode/opencode.json`. Replace `{repo_absolute_path}` with the absolute
path to this repository:

```json
{
  "skills": {
    "paths": [
      "{repo_absolute_path}/skills"
    ]
  }
}
```

### Staying up to date

Pull the latest changes in the cloned repository:

```bash
cd /path/to/coding-agent-skills
git pull origin main
```

### Invoking skills

Skills are not slash commands in OpenCode. Browse available skills with `/skills`, or mention a skill directly in your prompt, for example: `use the make-plan skill`.

</details>

<details>
<summary><strong>Codex</strong></summary>

Marketplace install:

```bash
codex plugin marketplace add ludingx/coding-agent-skills
codex plugin add coding-agent-skills@coding-agent-skills
```

Start a new Codex session before using installed or updated skills. Use `/plugins` to browse and manage plugins.

### Invoking skills

Reference a skill with `$` in your prompt, for example:

```text
$make-plan Plan this change.
```

### Staying up to date

Refresh the marketplace to retrieve the latest version from `main`:

```bash
codex plugin marketplace upgrade coding-agent-skills
```

</details>

## Skills

The skills support different stages of software engineering work. Use the ones that fit the task; they do not require adopting a new process.

### User-invoked skills

- [`make-plan`](./skills/make-plan/SKILL.md): Explore a task and produce a concise implementation plan.
- [`grilling`](./skills/grilling/SKILL.md): Stress-test a plan, decision, or idea by surfacing assumptions and edge cases.
- [`grill-with-docs`](./skills/grill-with-docs/SKILL.md): Sharpen a plan and capture decisions in project documentation.
- [`implement`](./skills/implement/SKILL.md): Implement work from an approved plan or specification.
- [`delivery-workflow`](./skills/delivery-workflow/SKILL.md): Guide work from planning through implementation, pull request, CI, and cleanup.
- [`code-review`](./skills/code-review/SKILL.md): Review changes against coding standards and the original requirements.
- [`research`](./skills/research/SKILL.md): Investigate a topic using high-trust sources and capture findings.
- [`prototype`](./skills/prototype/SKILL.md): Build a throwaway prototype to explore a design question.
- [`to-spec`](./skills/to-spec/SKILL.md): Turn a discussion into a specification.
- [`to-tickets`](./skills/to-tickets/SKILL.md): Break work into implementation tickets.

### Model-invoked skills

- [`using-git-worktrees`](./skills/using-git-worktrees/SKILL.md): Set up an isolated worktree for feature work.
- [`domain-modeling`](./skills/domain-modeling/SKILL.md): Clarify domain terminology and record architectural decisions.
- [`handoff`](./skills/handoff/SKILL.md): Prepare a concise handoff for another agent.
- [`tdd`](./skills/tdd/SKILL.md): Follow a test-driven development workflow.

## Suggested workflow

For a feature or bug fix, a typical flow is:

1. **Plan** — Use [`make-plan`](./skills/make-plan/SKILL.md) to understand the task and outline the work.
2. **Align** — Optionally use [`grilling`](./skills/grilling/SKILL.md) or [`grill-with-docs`](./skills/grill-with-docs/SKILL.md) to challenge assumptions and clarify scope.
3. **Implement** — Use [`implement`](./skills/implement/SKILL.md) to carry out the approved plan.
4. **Review** — Use [`code-review`](./skills/code-review/SKILL.md) to check the changes against project standards and requirements.

Use other skills as appropriate for the task, such as [`research`](./skills/research/SKILL.md), [`domain-modeling`](./skills/domain-modeling/SKILL.md), [`using-git-worktrees`](./skills/using-git-worktrees/SKILL.md), or [`handoff`](./skills/handoff/SKILL.md).
