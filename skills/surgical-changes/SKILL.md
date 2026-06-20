---
name: surgical-changes
description: Make the smallest change that satisfies the task and nothing more. Use when implementing a feature, fixing a bug, or writing tests — any time you are editing an existing codebase.
---

## Overview

Surgical changes keep a diff small, reviewable, and reversible. The goal is that a
reviewer can see exactly what the task required and nothing else. Scope creep —
even well-intentioned cleanup — makes changes harder to review and to revert.

## When to use

- Implementing a feature or fixing a bug in an existing codebase.
- Writing tests that touch shared fixtures or helpers.
- Any edit where an unrelated "improvement" is tempting.

## Process

1. Write the minimum code that solves the stated problem. Nothing speculative.
2. Touch only what the task requires. Do not improve adjacent code, comments,
   naming, or formatting that the task did not ask you to change.
3. Add no abstraction, configurability, or error handling beyond what was asked.
4. Remove only imports/variables that YOUR change made unused — not pre-existing
   ones.
5. If you notice unrelated dead code or a real bug nearby, **mention it** in your
   summary; do not fix it inline.

## Common rationalizations (don't)

- "While I'm here, I'll just tidy this up." → No. Separate concern, separate change.
- "A small abstraction now saves time later." → Speculative. Add it when a second
  caller actually exists.
- "This formatting is inconsistent." → Out of scope unless the task is formatting.

## Red flags

- The diff touches files the task didn't mention.
- Renames or reformatting mixed in with logic changes.
- New config flags or layers with a single caller.

## Verification

- Every changed line traces directly to the task.
- Reverting the change cleanly removes the feature and nothing else.
- Unrelated observations are reported, not committed.
