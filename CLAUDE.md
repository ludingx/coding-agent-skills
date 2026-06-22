# software-agent-skills

This repository contains reusable skills and commands for AI coding agents.

## Skills

Skills live in `skills/<name>/SKILL.md`. When a user request matches a skill's intent, invoke it using the `skill` tool rather than implementing directly.

| Skill | Trigger |
|---|---|
| `surgical-changes` | Implementing a feature, fixing a bug, editing an existing codebase |
| `tdd` | Building with tests, red-green-refactor, test-first development |
| `make-plan` | Understanding requirements and producing an implementation plan before any code is written |

## Commands

Slash commands live in `.claude/commands/`. They are user-invoked entry points that orchestrate skills into end-to-end workflows.

| Command | Purpose |
|---|---|
| `/build` | Deliver a Jira ticket end-to-end: plan → TDD → PR → CI |