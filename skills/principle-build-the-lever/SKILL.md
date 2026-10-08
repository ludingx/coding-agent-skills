---
name: principle-build-the-lever
description: Apply to non-trivial edits, migrations, analyses, and checks. Build a rerunnable tool that does or proves the work instead of doing it by hand.
disable-model-invocation: true
---

# Build the Lever

When the work is not trivial, build the smallest tool that does it instead of repeating manual steps.

A codemod, generator, or script makes the work consistent and rerunnable. The tool also gives a reviewer an artifact they can inspect and run. A hand-done change can only be rechecked by doing the work again.

- Do the first unit by hand to learn the recipe. Then build the tool and rerun it on that unit. Compare the result with the hand-done version.
- Use a codemod or script for edits, a generator for repetitive files, a query for analysis, or a rerunnable check for verification.
- Prefer a deterministic tool over delegating manual repetition. If one tool can process every unit, run it yourself.
- When subagents need a shared procedure, write the procedure as a skill. Include the recipe, verification contract, and do-not-touch boundaries. Keep it outside their write scope.
- Make the tool safe to rerun. Commit it when the work outlives the session.

The bar is triviality, not repetition. A one-off still earns a tool when the tool makes the result checkable. Keep it smaller than a framework. This differs from **principle-encode-lessons-in-structure**, which makes a recurring instruction a durable guardrail. For verification tools, see **principle-prove-it-works**.
