---
name: correct
description: Find recurring mistakes agents make in this repository and fix them at the strongest practical level, from architecture and types through checks and tests. Use for /correct or when asked to stop repeated mistakes.
disable-model-invocation: true
---

# Correct

When agents are repeatedly corrected for the same mistake, change the repository so the next agent is less likely to repeat it. A prompt reminder is not a durable fix when the repository can enforce the rule.

Assume contributors see only files they opened, copy the nearest example, and take the shortest path that compiles. Make a locally plausible change correct across the repository.

## Find mistake classes

Read recent commits, reverts, review comments, agent instructions, and workaround comments. Group mistakes into classes. Treat a class as recurring only when there is evidence it happened more than once.

## Fix each class at the highest useful level

1. **Eliminate it with architecture.** Give each piece of state one owner and each task one supported path. Hide internals so the wrong import fails. Replace hand-synchronized lists with one source of truth. Delete obsolete paths and dead code that invite copying.
2. **Make invalid states unrepresentable.** Strengthen types and APIs, applying **principle-type-system-discipline**. If the bad change still compiles, add a lint or CI check whose error names the supported file, type, or function. If the pattern is already widespread, fail only when a change adds more.
3. **Test behavior.** Fix or delete tests that would still pass if the functions they call returned nothing.
4. **Write docs or agent rules last, and only for judgment calls.** Instructions are not enforcement if a contributor can skip them.

## Prove and prevent recurrence

Fix the most frequent mistake classes first. For each new check, prove it fails on a real past mistake, then run it locally and in CI when CI supports it. Exceptions need a reason, an expiry, and an owner.

Keep a table in the relevant `AGENTS.md` or contributor instructions pairing each rule with its enforcement. When corrected, fix the mistake and add or strengthen enforcement. If a rule already exists but is unenforced, treat that as a repeat and address it at the highest useful level. Remove rules once the mistake cannot occur.

**Reply:** each mistake class and its evidence, the enforcement level chosen, and why a stronger level was not practical.
