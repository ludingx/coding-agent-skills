---
name: principle-attack-the-premise
description: Apply when two or more fixes share a premise and fail the same gate. Record the premise, take a census of which actors hold the imbalance, then question the premise before adding another fix that assumes it.
disable-model-invocation: true
---

# Attack the Premise

When two or more fixes share a premise and fail the same gate, suspect the premise, not just the fixes. Each failure is evidence about what they assumed.

**Pattern:**

- **Write down the premise.** State in one sentence what every failed fix assumed.
- **Take a census before the next fix.** Count which actors hold the imbalance. The census shows who holds it, not how large it is. Make the census rerunnable, per [Build the Lever](../principle-build-the-lever/SKILL.md).
- **Look for skew.** If the same few actors hold most of the imbalance on every run, find what assigns them that role. Follow that assignment as the next “why,” per [Fix Root Causes](../principle-fix-root-causes/SKILL.md).
- **Remove the asymmetry instead of compensating for it**, per [Laziness Protocol](../principle-laziness-protocol/SKILL.md). Rotate or randomize the role, or move it so no actor holds it every time. A return path, shared pool, batched hand-off, or periodic rebalance leaves the assignment in place and adds work on every run.

**Stop:**

- Do not start another fix until the premise is written down and the census exists.
- If the census is even across actors, this premise is not the cause. Keep the census as evidence and investigate elsewhere.

This differs from [Redesign from First Principles](../principle-redesign-from-first-principles/SKILL.md), which rebuilds a design around a new requirement. This principle questions a fact the current design assumes.
