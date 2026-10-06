---
name: no-comments
description: Review comments and lint suppressions in the current diff. Remove narration and unsupported explanations, keep only comments that document a real external constraint or public contract, and report larger code changes separately.
---

# Review comments

Review comments and lint suppressions in the caller's files or the current diff against the PR base. Include staged and unstaged changes. Do not review unrelated code or silently broaden the scope.

## Classify each comment

Remove comments that:

- Restate what the code directly shows.
- Describe a temporary workaround without a current, verifiable reason.
- Explain internal behavior that clearer names, types, or structure can express.
- Are commented-out code, banners, or stale instructions.
- Use words such as "IMPORTANT" or "do not remove" without evidence for an exception.

Keep a comment only when it records:

- A legal or license requirement.
- A non-obvious constraint imposed by an external dependency, platform, vendor, or protocol that the project cannot change.
- A public API contract that the code cannot express.
- A concrete issue or design reference that explains a constraint the code cannot express.
- A formatter directive required by the configured tooling.

Treat `eslint-disable`, `@ts-ignore`, `@ts-expect-error`, and similar suppressions as comments that need proof. Check the named rule and determine whether it protects correctness or safety. Flag unsupported suppressions; do not delete them when doing so requires an application-code change outside the comment-only scope.

## Apply the review

Delete clear narration and stale comments in scope. Do not rewrite application logic as part of this review. If a comment reveals that names, types, or structure should change, report the exact symbol and the smallest structural fix that could remove the comment. Do not invent a constraint or keep a comment because it might be useful later.

If an independent reviewer is available, ask it to inspect the same scoped diff for missed or misclassified comments before applying non-trivial deletions. Do not require a particular agent, tool, or slash command. Without an independent reviewer, inspect each comment's surrounding code and state that the review was not independent.

After edits, inspect the comment diff again. Report files reviewed, comments deleted, comments kept with their evidence, unsupported suppressions, suggested structural changes, and any limits on the review. Do not claim a fresh independent review if you performed the review yourself.
