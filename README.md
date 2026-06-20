# software-agent-skills

Reusable skills and commands for AI coding agents — Claude Code and OpenCode.

## Structure

```
skills/
  surgical-changes/SKILL.md   # Smallest change that satisfies the task
  tdd/SKILL.md                # Test-driven development, red-green-refactor
.claude/
  commands/
    build.md                  # /build slash command for Claude Code
.opencode/
  agents/
    sde-agent.md              # SDE agent for OpenCode
CLAUDE.md                     # Claude Code instructions
AGENTS.md                     # OpenCode instructions
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

## Installation

### Claude Code
```bash
git clone https://github.com/ludingx/software-agent-skills.git
cd software-agent-skills
claude --plugin-dir .
```

Or add to your project's `CLAUDE.md`:
```
Use skills from: https://github.com/ludingx/software-agent-skills
```

### OpenCode
```bash
git clone https://github.com/ludingx/software-agent-skills.git ~/.config/opencode/software-agent-skills
```

Then reference `sde-agent` in your project's `opencode.json`.
