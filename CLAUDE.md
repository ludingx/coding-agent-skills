# software-agent-skills

This repository contains reusable skills and commands for AI coding agents.

## Skills

Skills live in `skills/<name>/SKILL.md`. When a user request matches a skill's intent, invoke it using the `skill` tool rather than implementing directly.

| Skill | Trigger |
|---|---|
| `surgical-changes` | Implementing a feature, fixing a bug, editing an existing codebase |
| `tdd` | Building with tests, red-green-refactor, test-first development |
| `using-git-worktrees` | Starting feature work that needs isolation, or before executing implementation plans |
