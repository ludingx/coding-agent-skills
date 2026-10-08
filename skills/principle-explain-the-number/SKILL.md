---
name: principle-explain-the-number
description: Apply before trusting, reporting, or acting on a measured number such as speedup, regression, throughput, latency, or eval result. Identify its limiter and rule out measurement errors.
disable-model-invocation: true
---

# Explain the Number

A measured number is a claim about a system. Before you trust it, report it, or act on it, find what limits it and rule out that it measured something else.

A run that went wrong can still print a plausible number. Failed requests, skipped or cached work, an untuned side, and run-to-run noise can all produce results that look valid.

- Ask “why not double?” Name the resource or code path that bounds the result. Use a profile or system counters from the run, then map the limiter to source. A guess from reading code is not a measured limiter.
- List what else the number could measure, then rule out each possibility with evidence. Check for errors, skipped or cached work, an untuned side, noise, and work too small to matter end to end.
- Keep the run count, spread, and limiter with the number so a reader can check the claim.

For performance numbers, use a benchmark checklist when the repository provides one. For eval results, check that each trial did the task, the gap holds across trials and models, and the scenario matters.

If the evidence behind a number has no run count, no spread, or no named limiter, or the time saved exceeds the total time the changed part took, the measurement is not yet explained. Recheck it before reporting the claim.

This differs from **principle-prove-it-works**, which checks whether an output is real. This principle checks whether a measured number means what you say it means.
