---
name: technical-writing
description: Write or review documentation, pull request titles and descriptions, and commit messages with clear structure, direct sentences, and unambiguous wording. Apply every layer except Diátaxis to PR and commit text.
---

# Technical writing

Write so a tired engineer can understand the text on the first read. Apply the sentence, instruction, and ambiguity rules below. For prose you edit, also run the `unslop` skill.

## Use clear sentences

- Cut words that do no work. Use short, everyday words when they keep the same meaning.
- Use real symbol, file, flag, and command names instead of vague descriptions.
- Speak to the reader in the present tense. Use active voice when the actor matters.
- Put the condition before the instruction. Put the common case before exceptions.
- Give each sentence one main thought. Split long sentences when readers must backtrack.
- Use direct commands for procedures. State facts plainly.
- Keep articles such as "a" and "the" when they make the meaning clear.
- Use one word for each action throughout the text. Prefer a plain verb over an "-ing" form when both are clear.
- Use serial commas. Use periods instead of semicolons or em dashes.
- Use sentence case for headings. Use numbered lists for steps and bullets for unordered items.
- Avoid buzzwords, idioms, metaphors, and jargon the reader does not need.

## Remove ambiguity

- Put words such as "only" and "not" next to the words they change.
- Break up long strings of nouns.
- Make every pronoun refer to one clear noun. Repeat the noun when needed.
- State what each side of "and" or "or" joins. Use "both ... and", "either ... or", or "if ... then" when they remove ambiguity.
- Name each concept the same way throughout the text.
- Do not trade clarity for fewer words.

## Write pull request and commit text

- A PR title says what changed and follows the repository's naming convention.
- A PR description briefs the reviewer on why the change exists, what it changes, and how you verified it. Keep it short enough to read in under a minute.
- A commit message describes one focused change. Do not repeat the subject in the body.
- Every technical-writing rule in this skill applies to PR titles, PR descriptions, and commit messages. Diátaxis does not apply to those formats.
- Link detailed evidence instead of pasting logs, long SHA lists, or metric tables.
- Make every count, path, symbol, and command accurate for the commit that contains the text.

## Review the text

Read the result once as the intended reader. Fix unclear references, missing context, inconsistent names, and sentences with more than one reading. Then run `unslop` on the text. Do not change product UI copy unless the task asks for it.
