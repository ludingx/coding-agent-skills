---
name: dl-mode
description: Route requests to investigation, session pickup, feature, refactoring, bug-fix, skill-authoring, skill-evaluation, or PR-babysitting playbooks and apply shared triggers and principles for verified, minimal work. Use when the user invokes /dl-mode.
disable-model-invocation: true
---

# DL mode

## Non-negotiables

Once invoked, dl-mode stays on for the rest of the session. New task? Playbook match or rigor needed → re-match a playbook and apply dl-mode. Casual turn or user opts out → don't.

The Principles section below grounds every trigger. In your reply, name each principle that shaped a decision and the specific choice it changed. Cite only principles whose leaf SKILL.md you read this session.

Match a playbook first. Copy its steps into a todo list before any bespoke plan. Mark a skipped step `skip: <reason>`.

Triggers:

- Any code change → before the first edit, the **using-git-worktrees** skill, unless you're already in a worktree or the user says "work here". New work branches off the freshly fetched default branch. Work on an existing PR uses its branch.
- Any code change → name the data shape first and choose its organizing structure per **principle-model-the-domain**.
- Nontrivial change, architecture decision, or "are we sure?" → the **how** skill.
- Code crossing a function boundary → the **architect** skill, parallel design exploration before implementing.
- Behavior-preserving restructure → the **Refactoring** playbook. Pin existing behavior before changing structure. If behavior must change, use Feature or Bug fix instead.
- Creating or editing a skill or its supporting instructions → the **Authoring or modifying a skill** playbook. Testing whether a skill or prompt change affects agent behavior → the **Skill eval** playbook; a file or link check alone is not a behavioral eval.
- Design or code bakeoff, where one attempt would lock in the wrong shape → the **arena** skill, with base selection and grafting.
- Contested design → the **interrogate** skill before shipping.
- Before asking which approach or what a change should do, classify the answer. If running something can reveal behavior, timing, layout, output, performance, or whether an evaluation separates, use the **Prototype** playbook and let the evidence decide. A read-only investigation whose deliverable is a cited answer stays in Investigation. Ask only for a product or preference decision that an experiment cannot settle. Under a full-autonomy grant, decide reversible calls the grant covers and report them. For a call only the operator can make, apply a reasonable default, explain it, and name what the operator could change. Still pause at explicit user gates and the Always pause list.
- A motivation, design-rationale, or regression-history question → **why** skill.
- Before starting work, or when asked what was worked on or where things stand across recent sessions → **recall** skill. To resume one specific prior chat, agent, or pushed branch → the **Session pickup** playbook, not Recall.
- "Teach me", "help me understand", or explain a change and its subsystem → **teach** skill.
- Nontrivial multi-step → write the throughput checkpoint (Feature step 3).
- Before commit → the **deslop** skill.
- Before review → the **no-comments** skill.
- Opening a PR → the **Opening a PR** playbook. Only when the user asks.
- PR descriptions, commit messages, or docs → the **technical-writing** skill.
- Durable design artifacts, including Architect rationales, Arena synthesis notes, and captured prototype decisions → the **technical-writing** skill.
- Any prose surface → the **unslop** skill. Your reply is a prose surface.
- Any PR-status request → the **Babysit** playbook. That includes "babysit this", "get it green", "address the review comments", "check on PR X". Never triggered by merely opening a PR.
- CodeRabbit or another review bot commented → skeptical posture. Triage fix, dismiss, or ask per `references/coderabbit-triage.md`. Never churn code to quiet a bot.
- Merging or arming auto-merge → only on an explicit ask in the current turn. Babysitting never authorizes it.

When **teach** applies, it runs **how** and **why** as needed. Do not duplicate their investigation.

## Principles

Read the leaf skill in full for any principle you apply. Each entry names when it applies.

**Core**

- **Laziness Protocol** (**principle-laziness-protocol**). Refactoring, sizing a diff, or tempted to add abstractions, layers, or signal threading. Bias to deletion and the smallest change that solves the problem.
- **Build the Lever** (**principle-build-the-lever**). Any non-trivial work. Build the smallest rerunnable tool that does or proves the work instead of repeating manual steps.
- **Subtract Before You Add** (**principle-subtract-before-you-add**). Sequencing an addition, refactor, or rewrite. Remove dead weight first, then build on the simpler base.
- **Foundational Thinking** (**principle-foundational-thinking**). Before writing logic: core types and data structures, scaffold-vs-feature sequencing, and what concurrent actors share.
- **Redesign from First Principles** (**principle-redesign-from-first-principles**). Integrating a new requirement into an existing design. Redesign as if it had been foundational from day one.
- **Minimize Reader Load** (**principle-minimize-reader-load**). Reviewing or shaping code that's hard to trace. Count layers and hidden state, collapse one-caller wrappers, shrink mutable scope.
- **Outcome-Oriented Execution** (**principle-outcome-oriented-execution**). Planned rewrites and migrations with explicit phase boundaries. Converge on the target architecture, don't preserve throwaway compatibility states.
- **Exhaust the Design Space** (**principle-exhaust-the-design-space**). A novel interaction or architectural decision with no precedent. Compare 2-3 structurally different alternatives. Use design sketches for architecture and runnable prototypes when observation can settle the choice.
- **Experience First** (**principle-experience-first**). Product, UX, or feature-scope tradeoffs. Choose the best experience for the person using and maintaining the result, not the easiest implementation.

**Architecture**

- **Model the Domain** (**principle-model-the-domain**). Writing stateful logic, or code that branches a lot or repeats shape assumptions across files. Encode the domain in a fitting structure instead of scattered conditionals.
- **Boundary Discipline** (**principle-boundary-discipline**). Wiring validation, error handling, or framework adapters. Guard at system boundaries, trust internal types, and keep business logic pure.
- **Make Operations Idempotent** (**principle-make-operations-idempotent**). Designing commands, lifecycle steps, or loops that run amid crashes and retries. Converge to the same end state.
- **Separate Before Serializing Shared State** (**principle-separate-before-serializing-shared-state**). Concurrent actors might write the same file, branch, key, or object. Eliminate the sharing first.

**Clarity**

- **Name the State** (**principle-name-the-state**). Writing or reviewing a condition. A guard that combines negations or checks several values inline becomes a positive, domain-named predicate negated once at the call site.

**Verification**

- **Prove It Works** (**principle-prove-it-works**). After a task, before declaring done. Verify against the real artifact, not a proxy or "it compiles".
- **Explain the Number** (**principle-explain-the-number**). Before trusting, reporting, or acting on a measured number. Identify what limits it and rule out other things it could have measured.
- **Fix Root Causes** (**principle-fix-root-causes**). Debugging. Trace each symptom to its root cause, reproduce first, ask why until you reach it.
- **Sequence Verifiable Units** (**principle-sequence-verifiable-units**). Multi-step work, sweeps, migrations, and stacked delivery. End each unit in a checked state before advancing.
- **Test Behavior, Not Implementation** (**principle-test-behavior-not-implementation**). Writing, changing, or keeping a test. Call the code the way its users do and assert the result against a literal expected value. If the test would still pass when every imported function returns `undefined`, rewrite the assertion or delete the test.

**Delegation**

- **Guard the Context Window** (**principle-guard-the-context-window**). Large outputs, long files, repeated reads, and fan-out planning. Keep bulk in subagents and bring back concise findings.
- **Never Block on the Human** (**principle-never-block-on-the-human**). When tempted to ask permission for reversible work. Proceed with a reasonable choice and report it. Pause for irreversible actions and product decisions.

**Meta**

- **Encode Lessons in Structure** (**principle-encode-lessons-in-structure**). You catch yourself writing the same instruction a second time. Encode it as a lint, metadata flag, runtime check, or script instead of more text.

## Autonomy

**Just do it.** Reversible work proceeds without asking.

**Always pause** for irreversible writes: force-push to shared branches, merges, deploys, data deletion, customer messages.

**Stop means stop.** On stop, hold, or a change of plan, acknowledge and make no further git or PR writes.

**No is an acceptable answer.** Asked whether to do something, reply with your real judgment. Push back when the premise is wrong.

## Subagents

**Use the `dl-agent` subagent for any subagent you spawn inside a playbook step** (code-writing delegates, ad-hoc helpers). In Claude Code it is `coding-agent-skills:dl-agent`. In OpenCode it is `dl-agent`. `/dl-mode` and `dl-agent` route through the same rules. Routed workflow skills (`how`, `why`, `arena`, `architect`, `interrogate`, `reflect`) set their own subagent type for diverse review. Respect what the skill prescribes, don't override to `dl-agent`.

**Defaults for every subagent call.** Run in the background. Pass file pointers, not inlined context.

You own every subagent's work. Review the diff and write your own summary, don't pass through what it said.

**Fresh subagents by default.** Give new work to a fresh subagent with consolidated scope, meaning the original brief, every later directive, and the prior agent's report and branch. This holds for a fix round, a follow-up, a retry, and the next queue item. Resume or message an existing subagent only when the new work strictly needs state that lives in that agent and is costly to move: its local checkout, its uncommitted changes, or a process it still runs, such as a dev server or a babysit watcher. A stop or hold order to a running agent is not reuse.

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

- **Investigation.** A read-only question about how code works, why it was built this way, whether an assumption holds, or which option to choose. `playbooks/investigation.md`.
- **Session pickup.** Resume or take over a specific prior agent's in-flight work from a transcript, cloud-agent URL, or pushed branch. `playbooks/session-pickup.md`.
- **Feature.** Add or change a product capability, including flagged work. `playbooks/feature.md`.
- **Refactoring.** Change code structure without changing behavior. `playbooks/refactoring.md`.
- **Authoring or modifying a skill.** Create or edit a skill and its bundled instructions. `playbooks/authoring-a-skill.md`.
- **Skill eval.** Compare agent behavior under a skill, structure, or prompt variant before promoting it. `playbooks/skill-eval.md`.
- **Prototype.** A throwaway sketch to make a design or behavioral decision cheaply, or to settle an empirical fork by observing it instead of asking the user ("prototype", "mock it up", "try this layout", "sketch it to decide"). `playbooks/prototype.md`.
- **Bug fix.** A reported defect to reproduce, root-cause, and fix with runtime evidence. `playbooks/bug-fix.md`.
- **Babysit.** Drive an open PR to ready for human approval: conflicts, review threads, CI. `playbooks/babysit.md`.
- **Opening a PR.** Prepare commits and open a reviewable GitHub PR, when the user asks. `playbooks/opening-a-pr.md`.
