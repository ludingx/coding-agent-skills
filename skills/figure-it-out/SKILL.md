---
name: figure-it-out
description: Design an auditable workflow when no existing playbook fits, especially for large migrations or ambitious multi-part work. Scale rigor to risk, run a hypothesis loop, and leave a decision trail. Use for /figure-it-out or “figure it out”.
disable-model-invocation: true
---

# Figure it out

When no existing playbook fits, design one before coding. The deliverable is a sequence of phases scaled to the task, a testable outcome, and a decision trail another person can audit later.

## Start

Open a todo list. First read the Principles section of the **dl-mode** skill. Then add the phases below as todos.

## Phase A: Frame

Ground the task before committing to a long run. State:

- A falsifiable definition of done, per **principle-prove-it-works**.
- Scope in rough units of effort, plus blockers discovered during grounding.
- Rigor level and why. One-way doors and high-blast-radius changes get stronger gates; reversible, low-stakes steps get lighter ones. Rigor comes from gates and artifacts, not “try harder”.

Present framing and tradeoffs before a multi-hour run. Proceed with reversible work per **principle-never-block-on-the-human**; use a checkpoint for a long run.

## Phase B: Design the workflow

Decompose the work into atomic, independently verifiable units. Sequence the riskiest unknown first. Scaffold verification before features, per **principle-foundational-thinking**.

- Build a verification harness and capture the pre-change baseline when comparisons matter.
- Use **architect** for one-way-door design decisions. Skip it for mechanical work whose shape is already concrete. Do not repeat an already settled design bakeoff, per **principle-laziness-protocol**.
- Parallelize only across independent seams. Give each writer isolated files or a worktree, per **principle-separate-before-serializing-shared-state**. Do not over-fan-out.
- Write down the designed phases and identify what needs human review.

Add concrete execution todos between the design and verification phases. Update the decision trail as each step lands, not only at the end.

## Phase C: Run loop

Treat each unit as an experiment. State the hypothesis, make the smallest change, measure it against the predicate on the real artifact, and keep it only if it advances the result. Revert changes that do not help. Apply **principle-sequence-verifiable-units**: verify one unit before starting the next.

- Inspect artifacts; do not accept a worker's self-report as proof. If a check passes suspiciously easily, inspect the observation method.
- Pair delegated work with a judgment gate. If a worker games the gate, harden the contract. If the gate itself is wrong, fix it directly rather than routing around it.
- Use verdicts `VERIFIED`, `NOT VERIFIED`, or `INCONCLUSIVE`. Inconclusive is not a pass. Report negative results plainly.

## Phase D: Keep the audit trail

Use **show-me-your-work** for the canonical decision log. Commit the trail when the work is substantial enough that a reviewer needs it to audit the result later. The trail and diff should let someone return to the work and understand what happened.

## Phase E: Verify and hand back

Check the whole result against the Phase A predicate on the real product, not just the harness. Encode recurring corrections as a gate, lint rule, check, or script, per **principle-encode-lessons-in-structure**.

**Reply:** the workflow designed, rigor level and why, decision-trail path, what is verified against the predicate, and what remains open.
