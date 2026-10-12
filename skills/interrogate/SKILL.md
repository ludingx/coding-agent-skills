---
name: interrogate
description: "Use for \"interrogate\", \"adversarial review\", \"multi-model review\", \"challenge this\", \"stress test this code\", \"find blind spots\", or \"tear this apart\". Two independent model reviewers challenge a change from different angles, then the lead synthesizes a verdict."
disable-model-invocation: true
---

# Interrogate

Spawn two independent reviewers to adversarially review code changes. Both receive the same prompt and rubric and work without seeing the other's findings. The adversarial signal comes from model diversity, not assigned personas.

The deliverable is a synthesized verdict. Do not automatically apply changes.

Spawn subagents with the current agent's subagent tool: `Agent` in Claude Code or `task` in OpenCode.

## Step 1. Determine Scope

Identify the review scope from context:

- If the user points to specific files or a diff, use those.
- If on a feature branch, run `git diff main...HEAD` (or the appropriate base branch) for the full changeset.
- If the user's message references recent work, gather the relevant files.

Package the diff (or file contents) plus surrounding context reviewers need to understand the code.

## Step 2. State Intent

Before spawning reviewers, state the intent explicitly. Derive it from:

- The user's message
- Commit messages
- The PR description, if one exists
- The code itself

Write one clear paragraph. If the intent is unclear, ask the user before proceeding.

## Step 3. Spawn Reviewers

Launch both reviewers in one message so they run in parallel. In OpenCode, read `~/.config/coding-agent-skills/models.md` if it exists. The `interrogate reviewers` line under `## opencode` lists Reviewer A's model, then Reviewer B's. When the file or line is missing, use the table defaults:

| Reviewer | Requested model | OpenCode default |
|---|---|---|
| Reviewer A | `openai.gpt-6-luna` | `litellm/openai.gpt-6-luna#high` |
| Reviewer B | `fireworks-deepseek-v4p1-flash` | `litellm/fireworks-deepseek-v4p1-flash#high` |

For each reviewer:

- Use `general-purpose` in Claude Code or `general` in OpenCode.
- In OpenCode, set the `task` model to the reviewer's configured entry, or its table default. Omit `model` only for an `inherit-parent` entry. Otherwise do not rely on the default subagent model or leave the model unset.
- On other agents, request the listed model when the subagent tool supports it. If a model is rejected, use the closest valid model from the same family and reasoning tier, and report the fallback. Do not silently drop a reviewer or substitute a different model family.
- Tell it not to edit files.

If a requested model is unavailable, report which assignment failed and what fallback ran. Continue with an available reviewer, but label the verdict incomplete if both reviewers did not run.

Read `references/reviewer-prompt.md` and fill in the template with:

1. The stated intent
2. The diff or file contents
3. The review rubric from `references/rubric.md`
4. The code-quality lens from `references/code-quality-review.md`

Send the same filled template to both reviewers.

## Step 4. Synthesize

When results return, build a unified picture:

1. Parse all reviewer findings.
2. Identify consensus. Findings raised independently by both reviewers are the highest signal.
3. Read lone-reviewer findings too, but weight them accordingly. Correctness and security findings deserve scrutiny even when only one reviewer raises them.
4. Deduplicate findings and note which reviewers raised each one.
5. Note disagreements. If one reviewer flags something and the other explicitly says the opposite, include that context in the verdict.

## Step 5. Lead Judgment

You are the lead reviewer, a pragmatic senior engineer, not a neutral aggregator. Read `references/lead-judgment.md` in full and apply its framework.

Categorize every finding:

- **Act on**: Real issues affecting correctness, security, or maintainability that should block the change.
- **Consider**: Legitimate points where the tradeoff is uncertain and worth the user's attention.
- **Noted**: Valid but not actionable now, for example because it is low impact or context dependent.
- **Dismissed**: Wrong, nitpicky, or missing context. Briefly explain why.

For each finding, include the reviewer(s) who raised it, its category, and a one-line reason for the categorization.

## Output Format

Present the verdict in this structure:

### Intent

[The stated intent paragraph from Step 2]

### Reviewers

- Reviewer A: [model name], [N findings]
- Reviewer B: [model name], [N findings]

### Act On

[Findings to address. For each: description, reviewers who raised it, and why it matters.]

### Consider

[Findings worth thinking about. For each: description, reviewers who raised it, and the tradeoff involved.]

### Noted

[Valid but low-priority findings.]

### Dismissed

[Rejected findings with a brief rationale.]

### Agreement Map

[Where reviewers agreed or diverged, and what that pattern tells us.]
