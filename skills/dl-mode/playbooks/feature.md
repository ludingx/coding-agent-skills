# Feature

**You own the design. Plan, review, verify.** Delegate implementation. Stay in the lead.

1. Write the throughput checkpoint as four todo items. A dimension that genuinely does not apply (single file, no fan-out) keeps its item with `n/a: <reason>` rather than being dropped:
   - **Blocking first steps.** Gates run before fan-out.
   - **Independent workstreams.** Disjoint files, services, or layers parallelize. Shared writes serialize.
   - **Shared mutable state.** Default to splitting the target. Serialize only for real invariants.
   - **Smallest safe decomposition.** If one worker is best, name why.
2. Delegate code-writing to a subagent with a specific scope (file paths, the data shape, and success criteria). Mandatory: no skip-with-reason escape, and Laziness Protocol does not override it (the gain is review separation, not lines saved). A subagent forbidden to spawn satisfies this by owning the diff directly with the same review separation. No "standing by" reply that waits on a nested agent. Surgical edits, re-ground against the source for upstream-derived files. Port shared-primitive improvements to all consumers and verify each. Commit liberally.
3. Verify on the surface the user uses (the running app, CLI, or UI). For a flagged feature, exercise both flag-on and flag-off states. "Inconclusive" or wrong-surface is not a pass. Flag it.
4. Rebase into small, ordered commits. Stack follow-ups.
5. Run **Opening a PR** when the user asks.

Code-coupled work (one feature, one migration) goes to a single owner with the checkpoint inline. That owner fans out internally after the blocking phase. Parent-level fan-out is for slices that produce independent artifacts (audits, cross-subsystem investigations, competing experiments). Rewrite the checkpoint at phase boundaries. Spawn a fresh owner rather than chaining interrupts.

Hand back: what you built, what you chose and why, the throughput checkpoint, open decisions.
