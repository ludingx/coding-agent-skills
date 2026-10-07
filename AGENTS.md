# software-agent-skills

This repository contains reusable skills and commands for AI coding agents.

## Skill-Driven Execution

When a user request matches a skill's intent, load and follow the skill from `skills/<name>/SKILL.md` rather than implementing directly.

## Skill Structure

```
skills/{skill-name}/
  SKILL.md    ← workflow definition
```

Always check for an applicable skill before implementing. Never rationalize skipping a skill because the task seems small.
