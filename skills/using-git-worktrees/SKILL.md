---
name: using-git-worktrees
description: Use before the first code edit of a task, or when starting feature work that needs isolation from the current workspace - ensures an isolated worktree exists via native tools or git worktree fallback, and keeps every command inside it
---

# Using Git Worktrees

## Step 1: Check for existing isolation

Run `git rev-parse --git-dir` and `--git-common-dir`. If the results differ, you're already in a worktree — report the location and branch, skip to Step 4.

## Step 2: Pick the base

- **New work:** a new branch off the default branch, freshly fetched. Find it with `git symbolic-ref --short refs/remotes/origin/HEAD` (usually `origin/main`) and run `git fetch origin <default>`.
- **An existing PR or branch:** that branch. Get it with `gh pr view <pr> --json headRefName`, then `git fetch origin <branch>`.

## Step 3: Create and enter the worktree

First, from the main checkout, keep it clean of worktree folders. Run this once for each of `.worktrees` and `.claude/worktrees`:

```bash
git check-ignore -q <folder> || echo "<folder>/" >> "$(git rev-parse --git-common-dir)/info/exclude"
```

If `EnterWorktree` is available, use it — it switches the whole session into the worktree:
- New work: `EnterWorktree` with a `name`. It branches off the fetched default branch.
- Existing branch: `git worktree add .worktrees/<branch> <branch>`, then `EnterWorktree` with that `path`.

Otherwise:
- New work: `git worktree add .worktrees/<branch> -b <branch> origin/<default>`.
- Existing branch: `git worktree add .worktrees/<branch> <branch>`.
- A `cd` may not carry over to the next shell call. Run every command with the worktree as its working directory (the shell tool's `workdir` parameter, or `cd <path> && <command>` in the same call), and use absolute paths under the worktree for every file read and edit.

## Step 4: Confirm

Report: "Worktree ready at `<path>` on branch `<name>`." Pass the worktree path to every subagent you spawn.
