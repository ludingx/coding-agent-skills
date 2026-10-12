---
name: ketchup
description: Catch the user up on everything in this chat since their last message, in plain language, with enough context to decide any action items. Use for /ketchup.
disable-model-invocation: true
---

# Ketchup

Catch the user up on everything in this chat since their last message before `/ketchup`. Subagent results are not user messages. Write in the plain voice of [`bro`](../bro/SKILL.md), but skip its restating step. Assume the user remembers their last message and nothing after it. Use names for PRs, branches, and agents that the user will recognize.

## Gather what changed

Keep the turn read-only except for creating visuals for the reply. Do not change code, start an app or job, or post anything. Collect your own work since the user's last message, subagent reports, and other messages in the chat. Check the current state of each PR, CI run, or agent this chat touched. Say which are still running or could not be checked.

An action item is a decision only the user can make, such as a product choice, approval, irreversible action, or access the agent lacks. Include anything still waiting on the user, even if it was raised before their last message. Work the agent can still do is not an action item.

## Write the reply

Start with one sentence saying how many action items remain, or that there are none. If nothing happened and nothing is waiting on the user, say so and stop.

Then summarize what happened, most important first, and explain what each result means for the user. Skip steps that changed nothing. Name any work the agent can still do in one line.

For each action item, give an executive summary: the decision, why it matters now, options and their costs, a recommendation, and what happens if the user does not answer. Say when something is unknown rather than guessing. Link details when they exist, but include enough context for the user to decide without opening the link.

Show the current state and options side by side when useful. Prefer an existing screenshot, video, artifact, table, diff, or diagram over dense prose. Create a visual only when it clarifies the decision. Never invent numbers or imply a screen was captured when it was not. Link only artifacts that exist.
