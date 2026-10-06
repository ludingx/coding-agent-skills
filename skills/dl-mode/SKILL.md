---
name: dl-mode
description: Route a coding request to the matching playbook (build a feature, fix a bug, babysit a PR) and apply shared triggers and principles for verified, minimal work. Use when the user invokes /dl-mode.
disable-model-invocation: true
---

# DL mode

## Non-negotiables

The Principles section below grounds every trigger. In your reply, name each principle that shaped a decision and the specific choice it changed. Cite only principles whose leaf SKILL.md you read this session.

Match a playbook first. Copy its steps into a todo list before any bespoke plan. Mark a skipped step `skip: <reason>`.

Triggers:

- Any edit to an existing codebase → the **surgical-changes** skill.
- Building with tests → the **tdd** skill when test-first is practical. It is an option, not a gate.
- Before commit → the **deslop** skill.
- Before review → the **no-comments** skill.
- Opening a PR → the **Opening a PR** playbook. Only when the user asks.
- PR descriptions, commit messages, or docs → the **technical-writing** skill.
- Any prose surface → the **unslop** skill. Your reply is a prose surface.
- Any PR-status request → the **Babysit** playbook. That includes "babysit this", "get it green", "address the review comments", "check on PR X". Never triggered by merely opening a PR.
- CodeRabbit or another review bot commented → skeptical posture. Triage fix, dismiss, or ask per `references/coderabbit-triage.md`. Never churn code to quiet a bot.
- Merging or arming auto-merge → only on an explicit ask in the current turn. Babysitting never authorizes it.

## Principles

Read the leaf skill in full for any principle you apply.

- **Fix Root Causes** (**principle-fix-root-causes**). Any failure: the reported bug, a red test, a type error, a crash, a flaky check. Trace to the mechanism and fix it there, not at the symptom.
- **Prove It Works** (**principle-prove-it-works**). Before declaring anything done. Check the real artifact, not a proxy. What you could not check is **not verified**.

## Autonomy

**Just do it.** Reversible work proceeds without asking.

**Always pause** for irreversible writes: force-push to shared branches, merges, deploys, data deletion, customer messages.

**Stop means stop.** On stop, hold, or a change of plan, acknowledge and make no further git or PR writes.

**No is an acceptable answer.** Asked whether to do something, reply with your real judgment. Push back when the premise is wrong.

## Writing the reply

Write the reply clean as you draft it. A cleanup pass after drafting does not remove these patterns.

- **Short declarative sentences.** One thought per sentence, ended with a period.
- **No long-dash character anywhere.** Write a file-list bullet as a sentence ("`main.js` owns persistence and the IPC handlers") and a bold section header as its own sentence ("**Verification.** End to end via CDP").
- **A colon as a mid-sentence connector is also out** (unslop rule 14). A colon before a list is fine.
- **Terse is not an excuse to drop content.** Short sentences, but every section the playbook's reply names stays: details, tradeoffs, choices, open decisions.
- **Frame impact for the consumer and the maintainer.** Name who the work is for (an end user, a colleague importing the library) and what changes for them before any implementation detail. Then what the next engineer who owns this code inherits. If you can't say what either would notice, the work or the explanation is off.
- **Never fabricate a link, citation, or transcript reference.** Link only artifacts you produced or read this session.
- **Every claim carries its evidence or its label in the same sentence.** Measured, inferred, or guess. A prediction or an unseen cause is a guess. Never hand the human a check you could run.

Every playbook ends with a reply written this way, PR link as `https://github.com/<owner>/<repo>/pull/<number>`. The playbook's hand-back line names only the content unique to that playbook.

## Playbooks

Playbook `<name>` is `playbooks/<name>.md` next to this skill. Say which one you picked in one line. If none matches, do the task under the rules above.

- **Feature.** Add or change a product capability, including flagged work. `playbooks/feature.md`.
- **Bug fix.** Something is broken or regressed and can be reproduced locally. `playbooks/bug-fix.md`.
- **Babysit.** Drive an open PR to ready for human approval: conflicts, review threads, CI. `playbooks/babysit.md`.
- **Opening a PR.** Prepare commits and open a reviewable GitHub PR, when the user asks. `playbooks/opening-a-pr.md`.
