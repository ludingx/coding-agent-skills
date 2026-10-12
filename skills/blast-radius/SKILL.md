---
name: blast-radius
description: Find what a change could break outside its diff, and prove its key safety fact by running real code. Use for “blast radius”, “what could this break”, or a small diff you do not trust yet.
disable-model-invocation: true
---

# Blast radius

Find what a change could break elsewhere before it ships. `how` explains what the code does. `why` explains why it is shaped that way. Blast radius looks for breakage beyond the changed code.

Listing callers is not the whole job. Search can find callers; investigate breakage that search will miss.

## Prove the load-bearing safety fact

A convincing write-up is not proof. Identify one or two facts the change's safety depends on and prove them by running code where practical.

Use this evidence ladder and report where you stopped:

1. **Assertion.** You said it is safe. This is not evidence by itself.
2. **Source.** You pointed to a real `file:line` or the library's own source.
3. **Reasoned exclusion.** You walked through why a bad case cannot reach the changed behavior.
4. **Execution.** A script or test calls real code and would fail if the claim were wrong.
5. **Live reproduction.** You exercised it in the running application.

A small script importing the same dependency version the application uses is often enough to prove a specific claim.

## Steps

1. Read the change. Understand what it adds, changes, deletes, and now does differently, including implications not explicit in the diff. For PR history and motivation, use `why`.
2. Find the load-bearing safety fact. State what must be true for the change not to break consumers. Prove that fact rather than producing a long list of speculative risks.
3. Follow what symbol search can miss. Read the pinned source and local patches for dependencies. Trace scheduling and lifecycle behavior, serialized API or database shapes, wire formats, cross-language consumers, feature flags, and downstream callers several hops away.
4. Report only confirmed risks as findings. For each, cite `file:line`, describe how it breaks, estimate likelihood and impact, and say how to check it. List important risks you checked and cleared. Do not invent callers when search finds none.
5. Prove the safety fact with a script, test, or live reproduction. Run it and report what happened. For a large or wide change, use `arena` to challenge the analysis independently.

## Hand back

- **Change:** what it does, including non-obvious effects.
- **Safety fact:** state it, give the strongest evidence reached, and mark it unproven if needed.
- **Risks:** confirmed failure paths with source locations, likelihood, impact, and evidence.
- **Cleared:** important risks checked and why they do not apply.
- **Before merge:** the cheapest meaningful test or reproduction.

Write the result through `unslop`, cite real code, and remove private information before sharing publicly.

**Reply:** the change summary and the safety fact, proven or marked unproven.
