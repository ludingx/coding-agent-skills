# Refactoring

**You own the behavior contract. Change structure, not behavior.** If the task also needs a bug fix or new capability, separate that work and route it to Bug fix or Feature. Do not call a redesign behavior-preserving without checking its effects.

1. Run **how** over the affected code and its callers. Name the behavior that must survive, including error paths and the surface the user actually uses. Capture it before editing with a characterization test, snapshot, recorded output, or equivalence harness. If none is feasible, state the gap and record the observable behavior you can compare; a type check alone is not a behavior pin.
2. Name the current and target data shapes per **principle-model-the-domain**. Describe the intended boundary, types, and call path. Use **architect** before changing a function boundary and pass along the `how` findings. Prefer a smaller, more readable shape over a new layer that only moves code.
3. Subtract dead paths before adding structure. Migrate callers and remove the old internal API in the same bounded change rather than leaving two supported ways to do the same thing. If callers cannot migrate together, name the boundary and the explicit removal point. Use a rerunnable search or script to find callers, including references in tests and documentation.
4. Make small changes and rerun the behavior pin after each unit. Delegate implementation when allowed, with a scoped brief naming the invariant and verification command. Review the diff yourself. A failure means stop, investigate, and fix or undo your own unit before continuing; do not assume a changed snapshot is correct.
5. Verify the complete result on the matching surface, not only against a type check or a subagent report. Compare before and after outputs when possible. Check that no obsolete callers or compatibility paths remain. Report any behavior you could not verify as inconclusive, not unchanged.
6. Check whether the result lowers reader load. If it does not, reconsider the refactor. Run **Opening a PR** only when the user asks.

Hand back: what structure changed, the behavior pinned before the change, the before-and-after evidence, and any unverified paths. No new behavior.
