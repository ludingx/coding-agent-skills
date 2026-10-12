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

### dl-mode

Run `/dl-mode <task>`. dl-mode stays on for the rest of the session. The plugin ships `coding-agent-skills:dl-agent`, the subagent that dl-mode spawns for playbook steps.

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

Skills are not slash commands in OpenCode. Browse available skills with `/skills`, or mention a skill directly in your prompt, for example: `use the grilling skill`.

### dl-mode

To make the `dl-agent` subagent available globally, link its definition into OpenCode's global agent directory:

```bash
mkdir -p ~/.config/opencode/agents && ln -s {repo_absolute_path}/.opencode/agents/dl-agent.md ~/.config/opencode/agents/dl-agent.md
```

Invoke dl-mode by asking OpenCode to use the `dl-mode` skill for your task. dl-mode stays on for the rest of the session. `dl-agent` is the subagent dl-mode spawns for playbook steps.

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
$grilling Stress-test this plan.
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

- [`dl-mode`](./skills/dl-mode/SKILL.md): Route a request to a playbook (investigate, pick up prior work, build a feature, fix a bug, or babysit a PR) with shared rules for verified, root-cause work.
- [`grilling`](./skills/grilling/SKILL.md): Stress-test a plan, decision, or idea by surfacing assumptions and edge cases.
- [`grill-with-docs`](./skills/grill-with-docs/SKILL.md): Sharpen a plan and capture decisions in project documentation.
- [`research`](./skills/research/SKILL.md): Investigate a topic using high-trust sources and capture findings.
- [`to-spec`](./skills/to-spec/SKILL.md): Turn a discussion into a specification.
- [`to-tickets`](./skills/to-tickets/SKILL.md): Break work into implementation tickets.
- [`bro`](./skills/bro/SKILL.md): Restate the last message in plain language, without jargon.
- [`unslop`](./skills/unslop/SKILL.md): Cut AI writing patterns and jargon from text.
- [`reflect`](./skills/reflect/SKILL.md): Review the session transcript with parallel reviewers and turn durable learnings into skill edits you approve.
- [`tdd`](./skills/tdd/SKILL.md): Write a failing regression test before fixing a bug, when the test path is clear and cheap.
- [`architect`](./skills/architect/SKILL.md): Explore types, signatures, and module boundaries before implementing a change.
- [`arena`](./skills/arena/SKILL.md): Compare parallel implementations, choose a base, and graft in the strongest ideas.
- [`interrogate`](./skills/interrogate/SKILL.md): Adversarially review a change and sort findings by actionability.
- [`how`](./skills/how/SKILL.md): Explain how a subsystem works and build a working mental model of its architecture.
- [`why`](./skills/why/SKILL.md): Investigate why code was shaped a certain way, using available evidence and explicit confidence levels.
- [`teach`](./skills/teach/SKILL.md): Explain what something is, how it works, and why in one clear account.
- [`recall`](./skills/recall/SKILL.md): Reconstruct recent working context and return a concise brief on current status and next steps.
- [`ketchup`](./skills/ketchup/SKILL.md): Catch up on this chat since the user's last message and summarize outstanding decisions.
- [`blast-radius`](./skills/blast-radius/SKILL.md): Investigate what a change could break beyond its diff and prove the key safety fact.
- [`correct`](./skills/correct/SKILL.md): Turn recurring agent mistakes into structural fixes, checks, and tests.
- [`create-verification-skill`](./skills/create-verification-skill/SKILL.md): Create a project-local skill and feature map for driving and verifying the real app.
- [`maintain-verification-skill`](./skills/maintain-verification-skill/SKILL.md): Audit and update an existing app verification skill and feature map.
- [`show-me-your-work`](./skills/show-me-your-work/SKILL.md): Keep a reviewable decision trail for long-running or unattended work.
- [`swarm`](./skills/swarm/SKILL.md): Run parallel subagents across independent work and return one evidence-based report.
- [`figure-it-out`](./skills/figure-it-out/SKILL.md): Design and run a rigorous workflow when no existing playbook fits.
- [`typescript-best-practices`](./skills/typescript-best-practices/SKILL.md): Apply TypeScript-specific type-system practices to `.ts` and `.tsx` files.
- [`setup-models`](./skills/setup-models/SKILL.md): Choose which model each subagent role uses, scaled to a reasoning budget. OpenCode only for now.

### Model-invoked skills

- [`prototype`](./skills/prototype/SKILL.md): Build an isolated, throwaway UI or logic prototype to settle a design question.
- [`principle-experience-first`](./skills/principle-experience-first/SKILL.md): Choose the best experience for the people who use and maintain the result.
- [`principle-attack-the-premise`](./skills/principle-attack-the-premise/SKILL.md): Question a premise shared by multiple failed fixes before adding another fix based on it.
- [`principle-model-the-domain`](./skills/principle-model-the-domain/SKILL.md): Choose data structures that encode the domain before implementing logic.
- [`principle-type-system-discipline`](./skills/principle-type-system-discipline/SKILL.md): Design types to rule out invalid states, distinguish domain values, and check variants exhaustively.
- [`principle-migrate-callers-then-delete-legacy-apis`](./skills/principle-migrate-callers-then-delete-legacy-apis/SKILL.md): Migrate internal callers and delete obsolete APIs in the same change when compatibility is not required.
- [`principle-explain-the-number`](./skills/principle-explain-the-number/SKILL.md): Check what a measured number actually establishes before trusting or reporting it.
- [`principle-guard-the-context-window`](./skills/principle-guard-the-context-window/SKILL.md): Keep large payloads out of the main context and return concise findings.
- [`principle-never-block-on-the-human`](./skills/principle-never-block-on-the-human/SKILL.md): Proceed with reversible work and pause for irreversible actions or product decisions.
- [`principle-sequence-verifiable-units`](./skills/principle-sequence-verifiable-units/SKILL.md): Break multi-step work into units that each end with a check.
- [`principle-build-the-lever`](./skills/principle-build-the-lever/SKILL.md): Build a rerunnable tool that performs or proves non-trivial work.
- [`principle-name-the-state`](./skills/principle-name-the-state/SKILL.md): Replace tangled guards with positive, domain-named predicates.
- [`using-git-worktrees`](./skills/using-git-worktrees/SKILL.md): Set up an isolated worktree for feature work.
- [`domain-modeling`](./skills/domain-modeling/SKILL.md): Clarify domain terminology and record architectural decisions.
- [`handoff`](./skills/handoff/SKILL.md): Prepare a concise handoff for another agent.

## Suggested workflow

For a feature or bug fix, a typical flow is:

1. **Align** — Optionally use [`grilling`](./skills/grilling/SKILL.md) or [`grill-with-docs`](./skills/grill-with-docs/SKILL.md) to challenge assumptions and clarify scope.
2. **Build** — Use [`dl-mode`](./skills/dl-mode/SKILL.md) to build the feature or fix the bug, open the PR, and babysit it until it is ready for human approval.

Use other skills as appropriate for the task, such as [`research`](./skills/research/SKILL.md), [`domain-modeling`](./skills/domain-modeling/SKILL.md), [`using-git-worktrees`](./skills/using-git-worktrees/SKILL.md), or [`handoff`](./skills/handoff/SKILL.md).
