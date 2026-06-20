# software-agent-skills

This repository contains reusable skills and commands for AI coding agents.

## Skill-Driven Execution

When a user request matches a skill's intent, load and follow the skill from `skills/<name>/SKILL.md` rather than implementing directly.

## Intent Mapping

| User intent | Skill |
|---|---|
| Implementing a feature or fixing a bug | `skills/surgical-changes/SKILL.md` |
| Building with tests, TDD, red-green-refactor | `skills/tdd/SKILL.md` |
| Delivering a Jira ticket end-to-end | `.opencode/agents/sde-agent.md` |

## Skill Structure

```
skills/{skill-name}/
  SKILL.md    ← workflow definition
```

Always check for an applicable skill before implementing. Never rationalize skipping a skill because the task seems small.
