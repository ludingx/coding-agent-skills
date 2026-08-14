---
name: delivery-workflow
description: Build and deliver a task end-to-end through understanding, planning, implementation, PR creation, CI monitoring, and cleanup. Use only when the user explicitly invokes this workflow with a Jira ticket URL/ID or task description.
disable-model-invocation: true
---

# Delivery Workflow

Build and deliver a task end-to-end.

Input: `$ARGUMENTS` — a Jira ticket URL/ID or freeform task description, plus
an optional reference ticket or PR for pattern guidance.

Run each phase in this session and pause at every approval gate.

## Setup

Stop and ask the user if any step fails.

1. Verify the working tree is clean with `git status --porcelain`.
2. If a ticket was provided, verify Atlassian MCP is reachable with a lightweight probe.
3. If a ticket was provided, fetch its summary, description, acceptance criteria, comments, and linked context. Fetch any reference ticket or PR too.
4. Fetch the latest remote state with `git fetch origin`.
5. Derive the branch name:
   - With a ticket, use its lowercased ID, such as `ncpp-91`.
   - Without a ticket, use the kebab-case task slug, such as `add-payment-retry`.
   - If the branch already exists locally or on `origin`, ask the user whether to resume it or choose a new name.
6. Follow the `using-git-worktrees` skill to create an isolated workspace from `origin/main`. Perform all remaining work in that worktree.

## Phase 1 — Understand and Plan

Follow the `make-plan` skill, passing the ticket and any reference context.

**Approval gate:** Stop and wait for the user to approve the plan. If requested,
run `grill-with-docs` before starting Phase 2. Return to this phase whenever
later work shows that the plan is incorrect.

## Phase 2 — Implement

Follow the `implement` skill. Confirm the agreed test suite passes before
finishing this phase.

**Approval gate:** Stop and wait for user approval before starting Phase 3. If
implementation invalidates the plan, return to Phase 1.

## Phase 3 — Raise the PR

1. Push the branch with `git push -u origin <branch-name>`.
2. Create the PR with `gh pr create`, allowing GitHub to apply the repository PR template.
3. Provide the PR URL to the user.

**Approval gate:** Confirm the PR URL with the user before starting Phase 4.

## Phase 4 — Monitor CI and Fix Failures

1. Obtain the PR head SHA with `gh pr view <PR-number> --json headRefOid --jq '.headRefOid'`.
2. Check CI with `gh pr checks <PR-number> --json name,state,workflow`.
3. If checks are still in progress, wait before checking again.
4. If every check passes, notify the user and continue to Phase 5.
5. If a check fails:
   - Stop and ask the user for guidance when the failed check is external and cannot be fixed in code.
   - Otherwise, locate the failed GitHub Actions run, inspect its failed logs, and fix only the code responsible.
   - Commit and push the fix.
   - Stop and ask the user for guidance after three failed fix attempts for the same check.

**Approval gate:** Confirm that CI passes with the user before starting Phase 5.

## Phase 5 — Cleanup

1. Keep the worktree unless the user asks to remove it.
2. Delete plan artifacts for this task.
3. Delete any CI fix-attempt counters created during this workflow.
