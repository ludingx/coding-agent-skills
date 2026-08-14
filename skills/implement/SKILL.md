---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

# Implement

Implement the work described by the user in the spec or tickets.

## Constraints

**Surgical changes** — touch only what you must, clean up only your own mess:
- Don't improve adjacent code, comments, or formatting
- Don't refactor things that aren't broken
- Match existing style, even if you'd do it differently
- If you notice unrelated dead code, mention it — don't delete it
- Remove only imports/variables that YOUR change made unused

**Simplicity first** — minimum code that solves the problem, nothing speculative:
- No features beyond what was asked
- No abstractions for single-use code
- No error handling for impossible scenarios
- If the solution could be significantly simpler, rewrite it

## Process

Use `/tdd` where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use `/code-review` to review the work.

Commit your work to the current branch.
