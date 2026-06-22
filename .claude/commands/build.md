Build and deliver a Jira ticket end-to-end.

Input: `$ARGUMENTS` — a Jira ticket URL or ID, plus optional reference ticket/PR for pattern guidance.

Run all phases in this session, pausing at each approval gate.

---

## Standards

**Think first**
- State assumptions explicitly. If multiple interpretations exist, present them.
- If something is unclear, stop and ask before proceeding.

**Scope discipline**
- Follow the `surgical-changes` skill throughout: smallest change that satisfies the ticket, nothing speculative, touch only what's required, report unrelated issues rather than fixing them inline.

**Loopback**
- If a later phase reveals the Phase 1 plan was wrong, stop and return to Phase 1 — re-do the plan and re-confirm it — rather than forcing the wrong plan through.

---

## Pre-flight

Run all checks before Setup. If any fail, stop and ask the user how to proceed.

1. Working tree is clean: `git status --porcelain` must be empty.
2. Atlassian MCP is reachable: call `atlassianUserInfo` as a lightweight probe.
3. Branch name does not already exist locally or on `origin`. If it does, ask the user whether to resume the existing branch (use `EnterWorktree` with `path: <existing-worktree>`) or pick a new name.

---

## Setup

1. Fetch the Jira ticket via Atlassian MCP. Capture: summary, description, acceptance criteria, comments, and any linked issues or attachments that clarify scope. If the description references a design doc, Confluence page, or another ticket, fetch those too.
2. If a reference ticket/PR was provided, fetch both and note the patterns used.
3. Pull latest from main: `git fetch origin && git merge --ff-only origin/main` (run from the repo root). If the merge fails, stop and ask the user to resolve before continuing.
4. Use the ticket ID (lowercased) as the branch name (e.g. `ncpp-91`).
5. Create the worktree with the git CLI first so the branch name has no `worktree-` prefix: `git worktree add -b <branch-name> .claude/worktrees/<branch-name> origin/main` (from the repo root). Then call the `EnterWorktree` tool with `path: .claude/worktrees/<branch-name>` to switch the session into that worktree.
6. All subsequent work happens inside that worktree. At the start of Phase 3, use `ExitWorktree` with `action: "keep"` so the branch persists for PR creation.

---

## Phase 1 — Understand & Plan

Follow the `plan` skill. Pass the Jira ticket and any reference ticket/PR as context.

**Approval gate**: stop and wait for user approval of the plan before starting Phase 2.

---

## Phase 2 — Test-Driven Implementation

- Decide whether the ticket needs tests. Some tickets (e.g. removing a feature flag, deleting dead code, config-only changes) have no new behaviour to encode. If so, state why in the output artifact, implement the change directly, and confirm the existing suite still passes.
- Otherwise: follow the `tdd` skill. Drive the work in **vertical slices** — one failing test (RED) → minimal code to pass (GREEN) → next slice. Do not write all tests up front. Refactor only while GREEN.
- Prefer modifying existing tests that cover adjacent behaviour over creating new test files.
- Confirm the full suite passes before finishing the phase.

Output: `.claude/plan/<TICKET-ID>-phase2-tdd.md` — the slices implemented, test files touched, and production files changed (or the no-tests-needed justification).

**Approval gate**: stop and wait for user approval before starting Phase 3.

---

## Phase 3 — Raise PR

1. Exit the worktree: call `ExitWorktree` with `action: "keep"`.
2. Push the branch: `git push -u origin <branch-name>`.
3. Create the PR using `gh pr create` — GitHub will pick up the repo's PR template automatically. No need to supply a body manually.
4. Print the PR URL for the user.

**Approval gate**: confirm the PR URL with the user before starting Phase 4.

---

## Phase 4 — Monitor CI & Fix

Use `/loop 30s` to poll CI until all checks settle, then fix any failures. The loop prompt should:

1. Run `gh pr checks <PR-number> --json name,state` and check whether any check is still `IN_PROGRESS`, `QUEUED`, or `PENDING`.
2. If checks are still running → reschedule (do nothing, let `/loop` fire again in 30s).
3. If all checks pass → send a `PushNotification` ("PR #N: all CI checks passed") and stop the loop.
4. If any check failed:
   - Fetch the log: `gh run view <run-id> --log-failed | grep -A 10 "FAILED\|Error\|error:"`.
   - Fix only the code that caused the failure — do not touch unrelated code.
   - Commit and push the fix.
   - Continue the loop to re-poll the new run.
5. After **3 failed fix attempts** on the same check, stop the loop and ask the user for guidance.

**Approval gate**: confirm all CI checks pass with the user before starting Phase 5.

---

## Phase 5 — Cleanup

- Delete all plan artifacts for this ticket (`.claude/plan/<TICKET-ID>-phase*.md`). No plan files should remain.

Output: none (this phase only removes artifacts).
