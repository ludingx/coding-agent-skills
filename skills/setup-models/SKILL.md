---
name: setup-models
description: Configure which model each subagent role uses across these skills, scaled to a reasoning budget. Writes a machine-level routing file that overrides skill defaults. Use for /setup-models, "configure models", "model budget", or changing which models the skills spawn.
disable-model-invocation: true
---

# Setup models

Write `~/.config/coding-agent-skills/models.md`, the machine-level routing file that sets the model for each subagent role. Skills that spawn subagents read it before spawning and fall back to their own defaults when it or a line is missing.

OpenCode only for now. In another agent, say this skill supports OpenCode only and stop.

## Steps

### 1. Load current state

The default mapping is the file shape in step 3. If `~/.config/coding-agent-skills/models.md` exists, read it and treat its `budget` line and `## opencode` role lines as the current choices. Otherwise start from the defaults. Drop any role line not listed in step 3 and keep every other section of the file untouched.

### 2. Budget, map, confirm

**(a) Ask the budget.** Use the question tool. Offer these exact labels and name the current budget, or say `large` matches the skill defaults when no file exists.

- `large — high reasoning`
- `medium — medium reasoning`
- `small — low reasoning`

**(b) Map.** Set every real selector's `#variant` to the budget's level (`high`, `medium`, or `low`). `inherit-parent` does not change.

**(c) Show roles and confirm.** Show each role with its value. List the lines step 1 dropped. Ask whether to accept as-is or change specific roles. A role takes a `provider/model#variant` selector the user names, or `inherit-parent` (the role runs on the parent session's model). Use the question tool.

Panel roles (`arena runners`, `architect runners`, `interrogate reviewers`) take a list. One subagent runs per entry and the list length sets the count. `arena cross-judge pool` is also a list, but arena picks one entry whose family differs from the parent's when possible. Keep at least two model families across each panel. The panels get their signal from model diversity.

Selectors are not checked against what OpenCode offers. A skill whose model is rejected falls back to its default, then to the parent model, and says so.

### 3. Write the file

Create `~/.config/coding-agent-skills/` if missing. Write the `budget` line and the `## opencode` section. Keep any other `## <agent>` section exactly as it was. Defaults:

```md
# coding-agent-skills model routing. One line per role. Delete a line to fall back to the skill default.
# `inherit-parent`: the role runs on the parent session's model (omit `model` on the subagent call).
# Panel lists: one subagent per entry, so list length sets the count.
budget: large (high)

## opencode
feature, refactoring: litellm/openai.gpt-6-luna#high
bug-fix: litellm/openai.gpt-6-luna#high
dl-agent helpers: inherit-parent
how explorer: litellm/openai.gpt-6-luna#high
how explainer: litellm/claude-opus-5-5#high
why investigators: litellm/openai.gpt-6-luna#high
why synthesizer: litellm/claude-opus-5-5#high
recall miners: litellm/openai.gpt-6-luna#high
reflect tooling: litellm/openai.gpt-6-luna#high
reflect judgment, divergent, synthesizer: litellm/claude-opus-5-5#high
arena runners: litellm/claude-opus-5-5#high, litellm/openai.gpt-6-luna#high
arena cross-judge pool: litellm/claude-opus-5-5#high, litellm/openai.gpt-6-luna#high
architect runners: litellm/claude-opus-5-5#high, litellm/openai.gpt-6-luna#high
swarm workers: litellm/openai.gpt-6-luna#high
interrogate reviewers: litellm/claude-opus-5-5#high, litellm/openai.gpt-6-luna#high
```

### 4. Allow reading the file

The file sits outside every workspace, so each read would prompt. Add these rules to the end of the top-level `permissions` array in `~/.config/opencode/opencode.json` (or `opencode.jsonc`) unless they are already present. Preserve every other setting and rule.

```json
{ "action": "external_directory", "resource": "~/.config/coding-agent-skills/*", "effect": "allow" },
{ "action": "read", "resource": "~/.config/coding-agent-skills/*", "effect": "allow" }
```

### 5. Confirm

Tell the user the file is written and applies to subagents spawned from now on. Re-running this skill updates it.
