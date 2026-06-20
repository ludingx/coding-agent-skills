# software-agent-skills

A collection of reusable skills and commands for AI coding agents — Claude Code, OpenCode, Codex, Copilot, and others.

## Structure

```
skills/
  surgical-changes/   # Make the smallest change that satisfies the task
  tdd/                # Test-driven development with red-green-refactor loop
commands/
  build.md            # Build and deliver a Jira ticket end-to-end
```

## Skills

### surgical-changes
Guides the agent to make the minimum change required — no scope creep, no speculative cleanup, no unasked-for abstractions. Use when implementing features, fixing bugs, or writing tests in an existing codebase.

### tdd
Test-driven development using vertical slices (tracer bullets). One failing test → minimal code to pass → next slice. Avoids the horizontal-slicing anti-pattern of writing all tests up front.

## Commands

### build
End-to-end workflow for delivering a Jira ticket: fetch ticket → plan → TDD implementation → raise PR → monitor CI → cleanup. Designed for Claude Code's `/build` slash command.

## Usage

### Claude Code
Symlink skills into `~/.claude/skills/` and commands into `~/.claude/commands/`:

```bash
ln -s ~/software-agent-skills/skills/surgical-changes ~/.claude/skills/surgical-changes
ln -s ~/software-agent-skills/skills/tdd ~/.claude/skills/tdd
ln -s ~/software-agent-skills/commands/build.md ~/.claude/commands/build.md
```

### Other agents
Reference the `SKILL.md` files directly in your agent's system prompt or context.
