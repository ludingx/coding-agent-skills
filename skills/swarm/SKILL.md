---
name: swarm
description: Fan out parallel subagents across independent slices or declared race arms, then aggregate one evidence-based report. Use for /swarm, parallel coverage, races, gauntlets, or exploration.
disable-model-invocation: true
---

# Swarm

Fan out N parallel subagents across separate slices, races of the same brief, or a mix. The parent waits, aggregates, and returns one report.

## Start

Open a todo list with one entry per phase before launching workers.

1. Frame
2. Fan out
3. Aggregate
4. Report

## Phase A: Frame

1. State the done predicate and the artifact or report the swarm must return.
2. Choose the shape. Partition into slices, race N workers on identical briefs, or mix both. For a race or mixed shape, declare `first pass`, `rank all`, or `best-of` before spawning.
3. Set N from the user or derive it from the shape. N is the total worker count, not a promise of runtime concurrency. Respect the runtime's limits.
4. Pick the worker model. In OpenCode, read `~/.config/coding-agent-skills/models.md` if it exists and use the `swarm workers` line under `## opencode`, defaulting to `litellm/openai.gpt-6-luna#high`. Omit `model` for `inherit-parent`. If the call rejects the model, use the default and say so. On other agents, use the parent model. For a model race, name each arm's model up front; do not claim a model assignment the runtime cannot make.
5. Give each worker its own writable output and define what it may write. When workers verify or measure commits, each brief names the exact SHAs. A measurement brief also names the method (sample count, what one sample is, and order), and the worker records both in its result.

## Phase B: Fan out

Spawn independent workers in parallel when the runtime supports it. Use `dl-agent` for code-writing and helper tasks; use a workflow's prescribed specialist for review lanes when required. Each brief must be self-contained, scoped, and name its output. Keep workers isolated when they write files or branches; never have parallel workers write the same shared state. If the runtime cannot launch the requested fan-out, reduce N or do the work sequentially and report the limitation.

Each brief includes the goal, scope, exact slice or race arm, verification, and report format. Reports use `PASS`, `ISSUES`, or `BLOCKED` with evidence. A worker that proves a defect reports `ISSUES` and lists every issue it can prove, not only the first.

If a worker drops out, proceed with N-1 and note the missing coverage.

## Phase C: Aggregate

Read the terminal results. Drop a result that does not record the SHAs and method its brief names, and respawn that worker once if practical. After a second miss, record a gap. A gap does not count as a pass. For coverage, every required slice needs a result. For a race, apply the selection rule declared up front. Do not paste raw worker dumps.

Keep a compact result table, one-line evidenced issues, and explicit gaps or dropouts.

## Phase D: Report

Return one consolidated in-chat report with the table, issue one-liners, gaps or dropouts, and the race rule when used.
