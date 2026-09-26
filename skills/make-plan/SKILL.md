---
name: make-plan
description: Think through a task deeply, then produce a concise implementation plan. Use when the user wants to understand what needs to change before writing any code. Works with or without a Jira ticket. Agents must invoke this skill whenever the user mentions "plan", "make a plan", "create a plan", or any similar intent to plan before implementation.
---

# Make Plan

## Input

Jira ticket or user description. Fetch any linked docs, reference PRs, or Confluence pages.

## Process

1. **Explore** — read the codebase, domain docs, and ADRs before forming opinions.
2. **Think** — work through these internally before writing anything:
   - What problem is actually being solved? Is the stated solution the right one?
   - What edge cases and failure modes exist?
   - What existing modules/interfaces does this touch?
   - Where should the seam be?
   - What could go wrong with the obvious approach?
   - What is out of scope?
   - How will this be tested?

   Surface genuine blockers to the user one at a time.
3. **Write** — produce the plan at `.claude/plans/<TICKET-ID>-plan.md`. If no ticket exists, use a short kebab-case slug of the task (e.g. `.claude/plans/add-payment-retry-plan.md`). Wait for approval.

## Output format

Problem / Solution / Assumptions / Implementation decisions / Testing / Out of scope / Tickets (optional)
