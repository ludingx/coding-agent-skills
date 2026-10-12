---
name: reflect
description: Spawn three parallel review subagents over the active transcript, surface learnings, and route each to a concrete edit on an existing skill. Use when the user says reflect.
disable-model-invocation: true
---

# Reflect

Mine the current conversation for durable learnings, then route them into skill edits.

Invoke when the user says "reflect" or "/reflect". Skip when the conversation is trivial, off-topic, or already covered by an existing skill the parent followed correctly. One-offs are not learnings.

## 1. Locate the active transcript

Find the current conversation in the active workspace only. Do not search unrelated projects' private chats.

- **Claude Code.** Transcripts live in `~/.claude/projects/<project>/`, where `<project>` is the working directory with each `/` replaced by `-`. Match the opening user prompt against the first user event in candidate files. Subagent transcripts live in `<session-id>/subagents/`.
- **OpenCode.** Sessions live in a database. Run `opencode session list --format json -n <N>` from the active workspace, filter by its `directory`, and match the opening user prompt in `opencode session export <id>`. Keep the exported transcript in an isolated scratch path or pass a digest to reviewers. Do not export sessions from other workspaces.
- **Other agents.** Use the active workspace's documented transcript location.

For file-based transcripts, order candidates by modification time. For OpenCode, order by `updated`. If none matches, pass a tight digest of the session instead.

## 2. Spawn three reviewers in parallel

One message, three subagent calls: `general-purpose` in Claude Code (the `Agent` tool), `general` in OpenCode (the `task` tool), with full tool access. Reviewers need MCP access to look up the tickets, chat threads, and observability traces the transcript references, and some read-only agent types strip MCPs. Tell reviewers not to edit files.

Each reviewer and the synthesizer name a role line and a default. In OpenCode, read `~/.config/coding-agent-skills/models.md` if it exists and set `model` to that line's value under `## opencode`, or to the default if the file or the line is missing. Leave `model` unset when the value is `inherit-parent`. If the call rejects a model, use the default and say so. If it rejects the default too, omit `model` so the role runs on the parent model, and say so. On other agents, run every reviewer and the synthesizer on your strongest model, and put the Tooling lens on a different model family when one is offered.

| Lens | Role line | OpenCode default | Prompt template |
|---|---|---|---|
| Judgment | `reflect judgment, divergent, synthesizer` | `litellm/claude-opus-5-5#high` | `references/judgment-reviewer.md` |
| Tooling | `reflect tooling` | `litellm/openai.gpt-6-luna#high` | `references/tooling-reviewer.md` |
| Divergent | `reflect judgment, divergent, synthesizer` | `litellm/claude-opus-5-5#high` | `references/divergent-reviewer.md` |

Pass each template verbatim, substituting the transcript path or digest where marked. Reviewers return findings in their final response.

## 3. Synthesize

One general-purpose subagent with full tool access, `model` from the `reflect judgment, divergent, synthesizer` line (default `litellm/claude-opus-5-5#high`). It spot-verifies citations through MCP, so don't pick a read-only agent type that strips MCPs. Tell it not to edit files. Pass `references/synthesizer.md` verbatim, with each reviewer's full output inlined where marked. It returns an Accepted / Rejected / Backlog list.

## 4. Structural enforcement check

Move any Accepted item that a lint rule, script, metadata flag, or runtime check would enforce more reliably to Backlog. See the **encode-lessons-in-structure** principle skill.

## 5. Apply

Present the synthesizer's full Accepted / Rejected / Backlog output and wait for explicit approval before applying any Accepted edit. The user picks the subset and may redirect routings. Skill changes affect every future agent in the org. Do not auto-apply.

File each Backlog item to your team's devex or backlog tracker without waiting. Only the Accepted list waits for approval.

Follow each approved row's Routing exactly:

- Trivial existing-skill edit (a one-line bullet, a tightened sentence, a stale fact corrected): the parent does it directly.
- Substantive existing-skill edit (a new section, a new pattern table, more than ~10 lines): use your agent's skill-authoring skill, when available, and run its draft / test / iterate loop. Otherwise draft, test, and iterate directly.
- `tune description: <skill path>` (the skill exists but didn't trigger when it should have): use a skill-authoring skill's description-optimization loop when available. Otherwise test the trigger against representative prompts and revise it.
- `new skill: <kebab-name>`: use your agent's skill-authoring skill when available. Otherwise draft, test, and iterate directly. Do not invent the shape ad hoc.

If your environment ships a SKILL.md validator, run it on every touched skill before declaring done.

## 6. Summarize for the user

Short list, no preamble:

- Edits applied: `<skill path>`. What changed, one line each.
- New skills created: `<skill path>`. One line each (rare).
- Backlog filed to the devex tracker: `<issue title>` (`<tags>`). One line each.
- Dropped: one line per rejected finding + reason from the synthesizer.
