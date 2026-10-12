# Remaining pstack sync

What is still out of sync with pstack after the shared-skill alignment on this branch. Compared against pstack 0.15.20 (`~/agents/plugins/pstack`, commit `1b6d44f`) on 2026-10-13.

Standing exclusions: nothing Cursor-specific, no cloud agents, and no pstack playbooks that this repo lacks (own playbooks come later).

Only `dl-mode/SKILL.md` was diffed in full. The nine shared playbooks and `dl-agent` were compared by size and by references to excluded things, not line by line.

## 1. Decisions to confirm

Places where `dl-mode` is deliberately stricter than `poteto-mode`. A sync would loosen each one unless it is kept.

| Rule | dl-mode | poteto-mode | Keep dl-mode? |
|---|---|---|---|
| Opening a PR | Only when the user asks | At the end of every other playbook | [ ] |
| Merging | Only on an explicit ask in the current turn; merges are on the always-pause list | A Shipping playbook lands verified stacks | [ ] |
| External actions | Only reversible work proceeds without asking | Any MCP tool, team chat, ticket updates, and evals proceed without asking | [ ] |
| Stopping | "Stop means stop": no further git or PR writes | "Don't stop" / "going to bed" / "run until done" means keep going | [ ] |
| Worktrees | Every code change starts in a worktree | No such rule | [ ] |
| Babysit goal | Ready for human approval | Merge-ready | [ ] |

## 2. dl-mode/SKILL.md: pstack text worth taking

None of these is Cursor-specific. Each is quoted from pstack with `poteto` renamed to `dl`.

- [ ] **Comments section.** dl-mode has no equivalent.

  > ## Comments
  >
  > Comments follow the same rule as the reply. Write them clean as you go. Keep a comment only for a non-obvious *why* the code can't show. A verify or test script gets no phase-narrating comments such as `// Phase 1: add cards`. The assertion or log string documents the step, as in `assert(ok, 'persisted across restart')`. This applies to every file you produce, including the delegate's diff.

- [ ] **Fuller "No is an acceptable answer".** dl-mode has a two-sentence version.

  > **No is an acceptable answer.** Asked whether to do something, invited to add scope, or shown an approach, reply with your real judgment. Decline, push back, or say "this doesn't earn its place" when true. A recommendation is a judgment, not a validation. Agreement is not the default, candor over sycophancy.

- [ ] **Second opinion across models.** dl-mode stops after "don't pass through what it said".

  > You own every subagent's work. Review the diff and write your own summary, don't pass through what it said. A second opinion is the same prompt against a different model. Agreement is high-signal.

- [ ] **Tier code delegates by difficulty.** Possible now that `setup-models` exists. Needs two new role lines in `setup-models` (`hardest tasks`, `judgment and prose`) and the model names swapped for the OpenCode ones.

  > Code delegates tier by difficulty. The hardest changes (cross-cutting design, gnarly concurrency, subtle algorithms) go to your strongest judgment model, whether the task needs judgment on vague intent or is a precisely specified sequence of steps to execute to the letter. Trivial mechanical edits go to your fast code model.

- [ ] **Broken skill trigger.**

  > - Broken skill mid-task → fix it in its own PR. Don't block. Don't silently work around it.

- [ ] **Decision-trail trigger.** dl-mode folds this into the figure-it-out line. The "going to bed" wording conflicts with "Stop means stop" only in tone, not in effect.

  > - Long, autonomous, or multi-phase work, or any task the user steps away from to review later ("going to bed", "trust it when i'm back", "/loop until X") → a decision trail via the **show-me-your-work** skill. Commit it when stakes need an auditable record. Keep it local otherwise.

- [ ] **figure-it-out outranks a narrower playbook for large work.** dl-mode only uses it when no playbook matches. Drop the Orchestrate sentence.

  > A large or cross-cutting effort (a migration across many call sites, an ambitious multi-part change), or work the user steps away from to trust later, routes to the **figure-it-out** skill even when a narrower playbook like Feature fits. Use **figure-it-out** whenever no bundled playbook fits. It designs a bespoke, rigorous playbook for the task.

- [ ] **Ask-before-asking trigger, autonomy half.** dl-mode has the first half reworded. The second half covers what to do under a full-autonomy grant.

  > Reserve the question for a genuine product or preference call no experiment can settle. Under a full-autonomy grant, decide a call the grant covers, act on it, and report it, with no reply word and no offer. Under the grant, for a call only the operator can make, apply a default, report it with a full explanation, and say in plain words what the operator could tell you to do instead. The operator answers in their own words. Never give a shorthand token to type back. Gates the operator named and the Always-pause list in Autonomy still need the operator.

- [ ] **Fresh-subagent rule, tail.** dl-mode's paragraph is cut short. pstack continues:

  > A stop or hold order to a running agent is not reuse. A role such as a PR owner outlives its agent. Once that agent returns, a fresh agent takes the role's next round. Interrupt-chained resumes silently drop directives, so fire a fresh subagent with consolidated scope rather than trusting a "done" summary.

- [x] **Principle index wording.** Done. The Principles section is pstack's text, including its naming rule in place of per-entry skill names. Two local entries remain: the Clarity group with Name the State, and Show Me Your Work under Verification.

- [ ] **Todo-list rule.** pstack: "Open a todolist whose first items are the matched playbook's steps, copied in verbatim, before any task-specific todos." dl-mode says the same in fewer words. Low value.

## 3. dl-mode/SKILL.md: pstack text to leave out

- Frontmatter `mode`, `icon`, `color`, `reminder` (Cursor mode feature). dl-mode carries the reminder as a sentence instead.
- `AskQuestion`, `subagent_type`, `readonly`, `run_in_background`, the `Task` tool.
- `cursor-team-kit` plugin: `deslop`, `control-cli`, `control-ui`. dl-mode uses its own `deslop`.
- Cursor's built-in `create-skill` and babysit skill.
- Bugbot triage (`references/bugbot-triage.md`). dl-mode has `coderabbit-triage.md`.
- `benchmark-checklist` trigger (skill not ported).
- Routes to playbooks this repo lacks: Shipping, Orchestrate, Autopilot-full, Autopilot-stack, Hillclimb, Perf issue, Multi-phase plan, Worktree cleanup, Pause safely, Autonomous run, Runtime forensics, Trace forensics, Visual parity.

## 4. dl-mode additions a sync must keep

- Trigger routes pstack lacks: `using-git-worktrees`, Refactoring, Authoring a skill, Skill eval, `why`, `recall`, `teach`, `typescript-best-practices`, `blast-radius`, `correct`, the two verification skills, the merge rule.
- The Name the State principle entry (`principle-name-the-state`).
- The Skill eval playbook and `references/coderabbit-triage.md`.
- The OpenCode model-routing paragraph and the `dl-agent helpers` role.
- "Stop means stop" and merges on the always-pause list.

## 5. Shared playbooks: not yet reviewed

All nine differ. Word counts are dl-mode against poteto-mode.

| Playbook | dl-mode | poteto-mode | Excluded things pstack's version references |
|---|---|---|---|
| [ ] `authoring-a-skill` | 313 | 127 | Cursor's `create-skill` |
| [ ] `babysit` | 519 | 1,230 | `scripts/watch-pr`, Shipping, Autopilot, Bugbot, Cursor's babysit |
| [ ] `bug-fix` | 336 | 351 | a Cursor reference, Grok default model |
| [ ] `feature` | 393 | 382 | Shipping, Grok default model |
| [ ] `investigation` | 165 | 145 | none found |
| [ ] `opening-a-pr` | 587 | 922 | Autopilot, `cursor-team-kit`, `Task` |
| [ ] `prototype` | 361 | 334 | none found |
| [ ] `refactoring` | 360 | 460 | Grok default model |
| [ ] `session-pickup` | 221 | 257 | cloud-agent URL, `~/.cursor/projects` |

- [ ] `skill-eval` (dl-mode only, 318 words) against pstack's `eval` (390 words). Not compared.
- [ ] `agents/dl-agent.md` (99 words) against `poteto-agent.md` (131 words). Not compared.
- [ ] dl-mode's Session pickup description still says "cloud-agent URL". Remove it.

## 6. setup-models against setup-pstack

- [ ] **Budget tiers.** Three here (`large`/high, `medium`, `small`/low). pstack has four, adding `unlimited` (max reasoning) above `large`. Only useful if the OpenCode models offer a variant above `high`.
- [ ] **Role lines.** pstack has `judgment and prose` and `hardest tasks`, which go with the delegate-tiering item in section 2. `perf-issue` and `hillclimb` are left out on purpose until those playbooks exist.
- [ ] **Verification-skill offer.** pstack's last step checks whether the project has a `verify-*` skill and offers `/create-verification-skill` once.
- [ ] **Host coverage.** `setup-models` is OpenCode only. In Claude Code every role falls back to the parent or strongest model.

## 7. why source playbooks

Present: `code-archaeology.md` (git), `datadog.md`. The investigator roster still lists all seven categories, and a category with no playbook gets the prompt alone.

- [ ] Issue / ticket tracker (pstack: `linear.md`). Planned.
- [ ] Long-form documents (pstack: `notion.md`).
- [ ] Real-time team chat (pstack: `slack.md`).
- [ ] Error / exception tracking (pstack: `sentry.md`).
- [ ] Product analytics warehouse (pstack: `databricks.md`).
- [ ] When the issue tracker is added, restore its bullet in `incident-postmortem.md`.

## 8. Skills and agents not ported

- [ ] `benchmark-checklist`. `principle-explain-the-number` linked to it; the link is now a generic sentence.
- [ ] `automate-me`. `recall` routed to it; that route is removed.
- [ ] `poteto-help` (would become a `dl-help`).
- [ ] `make-bot-ui`. Not read.
- `poteto-mode/scripts/` (`watch-pr`, `orch`, `check-plan`, `worktree-audit.sh`): tied to the excluded playbooks.
- `automations/benny`: not read, not part of the skills.

## 9. Deviations made on this branch

Places where the aligned skills still differ from pstack on purpose.

- `no-comments`: only the spawn line differs, naming the Claude Code and OpenCode forms of the `comment-sicko` agent. Open question: `comment-sicko` runs `/how` or `/why`, which spawn their own subagents, and the Opening a PR playbook runs `no-comments` from a subagent. Whether Claude Code and OpenCode allow that nesting is unverified.
- `show-me-your-work`: the cross-model reviewer takes its model from the `arena cross-judge pool` line in OpenCode. pstack does not say how to pick it.
- `setup-models`: no model-detection step, so selectors are not validated. Every routed skill falls back to its default, then to the parent model, when a model is rejected.
- `swarm`: plain parallel subagents in place of cloud workers.
- `reflect`: "your agent's skill-authoring skill" in place of Cursor's `create-skill`; "the review bot" in place of Bugbot.
- `teach`: ASCII sketches in place of the image-generation tool.
- `ketchup`: no "generated image" in the visuals list.
