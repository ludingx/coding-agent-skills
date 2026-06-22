---
name: make-plan
description: Analyse a task and produce a concise implementation plan. Use when the user wants to understand what needs to change before writing any code. Works with or without a Jira ticket.
---

# Understand & Plan

## Input

- **Jira ticket** (optional) — URL or ID. If provided, fetch the ticket via Atlassian MCP: summary, description, acceptance criteria, comments, and any linked issues or attachments that clarify scope. If the description references a design doc, Confluence page, or another ticket, fetch those too.
- **Reference ticket/PR** (optional) — fetch and note the patterns used; prefer them over inventing new ones.
- If no ticket is provided, work from the user's description of the task instead.

## Process

1. Analyse the requirements and acceptance criteria (or user description).
2. Identify files, modules, and interfaces that will need to change.
3. If a reference ticket/PR was provided, surface the patterns to follow.
4. Write a concise implementation plan: what changes, where, and why.
5. State assumptions explicitly. Stop and ask if anything is ambiguous before producing the plan.

## Output

Write the plan to `.claude/plan/<TICKET-ID>-phase1-plan.md` (use a short slug if no ticket ID is available). Structure:

1. **Ticket** — ID, URL, and summary (or task description if no ticket).
2. **Requirements** — description and acceptance criteria verbatim (pin the source of truth; later phases refer back here if context is compacted).
3. **Assumptions** — anything inferred rather than stated.
4. **Plan** — files to change, patterns to follow, and why.

Stop and wait for user approval of the plan before any implementation begins.
