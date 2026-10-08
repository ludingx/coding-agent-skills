---
name: principle-sequence-verifiable-units
description: Apply to multi-step work, sweeps, migrations, and stacked delivery. Break the work into small units, verify each one before continuing, and order delivery so the sequence proves itself.
disable-model-invocation: true
---

# Sequence Verifiable Units

Order work as small units that each end in a checked state. Do not advance until the current unit passes its check.

In a sweep, migration, or repeated edit, bracket each unit with a known-good state, one change, and a check. Rebase onto a clean baseline first when the check needs to measure against the current base. When a script edits each unit, run its check anyway.

Stack commits or pull requests in an order that lets a reviewer replay the reasoning. Common sequences include a failing test before its fix, subtraction before reshaping, a baseline before a treatment, and a scaffold before its feature.

This complements **principle-prove-it-works**, which requires real evidence, and **principle-build-the-lever**, which makes repeated checks cheap.
