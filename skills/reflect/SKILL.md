---
name: reflect
description: Spawn three parallel review subagents over the active transcript, surface learnings, and route each to a concrete edit on an existing skill. Use when the user says reflect.
disable-model-invocation: true
---

# Reflect

Mine the current conversation for durable learnings, then route them into skill edits.

## When to invoke

Invoke when the user says "reflect" or "/reflect". Skip when the conversation is trivial, off-topic, or already covered by an existing skill the parent followed correctly. One-offs are not learnings.

## Process

### 1. Locate the active transcript

Find the current conversation in the active workspace only. Do not search unrelated projects' private chats.

- **Claude Code.** Transcripts live in `~/.claude/projects/<project>/`, where `<project>` is the working directory with each `/` replaced by `-`. Match the opening user prompt against the first user event in candidate files. Subagent transcripts live in `<session-id>/subagents/`.
- **OpenCode.** Sessions live in a database. Run `opencode session list --format json -n <N>` from the active workspace, filter by its `directory`, and match the opening user prompt in `opencode session export <id>`. Keep the exported transcript in an isolated scratch path or pass a digest to reviewers. Do not export sessions from other workspaces.
- **Other agents.** Use the active workspace's documented transcript location. If you cannot obtain a transcript, write a tight digest and pass that instead.

For file-based transcripts, order candidates by modification time. For OpenCode, order by `updated`. Read the relevant conversation, not a similarly named session. If matching fails, pass a digest rather than guessing.

### 2. Spawn three reviewers in parallel

Launch three general-purpose subagents in parallel (`Agent` in Claude Code, `task` in OpenCode) with full tool access. Reviewers need MCP access for context lookups referenced in the transcript. Some read-only agent types restrict MCPs. Tell reviewers not to edit files.

Run every reviewer and the synthesizer on your strongest model. When your agent offers models from more than one family, put the Tooling lens on a different family from the other two for diversity.

| Lens | Prompt template |
|---|---|
| Judgment | `references/judgment-reviewer.md` |
| Tooling | `references/tooling-reviewer.md` |
| Divergent | `references/divergent-reviewer.md` |

Pass each template verbatim, substituting the transcript path or digest where marked. Reviewers return findings in the subagent's final response.

### 3. Synthesize

Run one general-purpose subagent on your strongest model, with full tool access. The synthesizer spot-verifies citations, which can require MCP access. Use `references/synthesizer.md` verbatim, with each reviewer's full output inlined where marked. Tell the synthesizer not to edit files. It returns a structured Accepted / Rejected / Backlog list.

### 4. Structural enforcement check

Sanity-check the synthesizer's Accepted list. For any item that would be enforced more reliably by a lint rule, script, metadata flag, or runtime check, move it from Accepted to Backlog. See the **encode-lessons-in-structure** principle skill.

### 5. Apply

Before applying any Accepted edit, present the synthesizer's full Accepted/Rejected/Backlog output to the user and wait for explicit approval. The user picks which subset to apply and may redirect routings. Skill changes affect every future agent in the org. Do not auto-apply.

Backlog items file to whatever devex / backlog tracker your team uses automatically. Only the Accepted list waits for approval.

For each approved Accepted item, follow the Routing field exactly:

- Trivial existing-skill edit (a one-line bullet, a tightened sentence, a stale fact corrected): parent does directly.
- Substantive existing-skill edit (a new section, a new pattern table, more than ~10 lines): use your agent's skill-authoring skill, when available, and run its draft / test / iterate loop. Otherwise draft, test, and iterate directly.
- `tune description: <skill path>` (the skill exists but did not trigger): use a skill-authoring skill's description-optimization loop when available. Otherwise test the trigger against representative prompts and revise it.
- `new skill: <kebab-name>`: use your agent's skill-authoring skill when available. Otherwise draft, test, and iterate directly. Do not invent the shape without testing.

If your environment ships a SKILL.md validator, run it on every touched skill before declaring done. Skip this step if it doesn't.

### 6. Summarize for the user

Short list, no preamble:

- Edits applied: `<skill path>`. What changed, one line each.
- New skills created: `<skill path>`. One line each (rare).
- Backlog filed to the devex tracker: `<issue title>` (`<tags>`). One line each.
- Dropped: one line per rejected finding + reason from the synthesizer.
