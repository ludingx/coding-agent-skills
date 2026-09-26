---
name: using-git-worktrees
description: Use when starting feature work that needs isolation from current workspace or before executing implementation plans - ensures an isolated workspace exists via native tools or git worktree fallback
---

# Using Git Worktrees

## Step 1: Check for existing isolation

Run `git rev-parse --git-dir` and `--git-common-dir`. If the results differ, you're already in a worktree — report the location and branch, skip to Step 3.

## Step 2: Create and enter worktree

If `EnterWorktree` or `WorktreeCreate` is available, use it — it handles everything automatically.

Otherwise:
- Run `git worktree add .worktrees/<branch-name> -b <branch-name>`
- `cd` into the worktree for all subsequent commands

## Step 3: Confirm

Report: "Worktree ready at `<path>` on branch `<name>`."
