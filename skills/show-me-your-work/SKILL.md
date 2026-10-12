---
name: show-me-your-work
description: Keep a reviewable decision trail for long-running or unattended work. Use a local TSV by default; commit it when a reviewer needs the audit trail. Use for /show-me-your-work or multi-phase work that someone will review later.
disable-model-invocation: true
---

# Show me your work

Keep one canonical, append-only decision log.

## Format

Use a TSV with one row per meaningful decision. Cells are single-line. Evidence is a pointer, not prose. Start from `references/decision-log-template.tsv`.

- `ts`: ISO-8601 UTC timestamp.
- `phase`: phase or workstream.
- `decision`: what was chosen or done, in one line.
- `why`: reason in plain words. If a principle drove it, explain the decision rather than relying on jargon.
- `evidence`: path or identifier that proves it, such as a commit SHA, PR number, `file:line`, artifact, trace, or screenshot.
- `result`: predicate outcome such as `tests green`, `reverted`, `INCONCLUSIVE`, or `open`.

Log decision points and checkpoints, not every action: selected direction, verified unit, pivot or revert, blocker, or gate correction. For iterative work, log each iteration. Skip self-evident steps.

Use `scripts/log.sh <logfile> <phase> <decision> <why> <evidence> <result>` to append a row safely. It creates the header when needed, normalizes tabs and newlines, and protects spreadsheet formula-leading cells. Plain `printf` is also acceptable when cells are trusted and correctly escaped.

## Where it lives

The log is a working artifact by default. Keep it at `decisions.tsv` in the work directory, or `.audit/<task-slug>.tsv` when several efforts run at once. Leave it uncommitted unless the work is substantial enough that a reviewer needs the trail to trust the result.

## Audit the log

Before handing back, compare the log against the current conversation and available artifacts. Use a transcript only when the runtime exposes it for this session; do not claim to audit hidden transcript data. Check that each row maps to a real decision or action, each evidence pointer resolves and proves its claim, and important forks or pivots are recorded.

Correct the log without rewriting history. Never delete or edit an earlier row. If a row was false, incomplete, or unsupported, append a row that supersedes it and points to the evidence. Do not audit rows from other runs unless current work exposes a specific error in them.

## Independent review

For high-stakes or long unattended work, ask a fresh subagent to review the trail and available evidence for weakly supported decisions, missing verification, risky choices, or gaps. Prefer a different model family when the runtime offers that choice. The reviewer should not redo the work.

End the hand-back with an `Attention` section. State the reviewer model only if known. List specific flags by row or evidence pointer, or say `No flags`.

## Reviewing and reusing the trail

Read from top to bottom, follow evidence pointers, and spot-check claims. Other skills should refer to this skill for the log format instead of inventing another one.
