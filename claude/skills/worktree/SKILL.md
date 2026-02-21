---
name: worktree
description: Manage git worktrees — list, add, switch, or clean up worktrees for the current repository.
disable-model-invocation: true
---

Git worktree management helper. Supports listing, adding, switching to, and cleaning up worktrees.

Usage: `/worktree <subcommand> [args]`

Subcommands: `list`, `add <branch>`, `clean`, `help`

---

## list

Show all worktrees for this repo with their branch and status.

```bash
git worktree list
```

Display in a readable format: path, branch, HEAD commit. Flag any worktrees with uncommitted changes or detached HEAD state.

---

## add

Create a new worktree for a branch.

Usage: `/worktree add <branch-name>`

1. Check if the branch already exists locally or remotely:
   ```bash
   git branch -a | grep <branch-name>
   ```

2. Determine a sensible path for the new worktree. Convention: sibling directory to the main worktree using the branch name. For example, if the main worktree is at `~/repos/myproject` and the branch is `feat/auth`, suggest `~/repos/myproject-feat-auth`.

3. If branch exists locally:
   ```bash
   git worktree add <path> <branch-name>
   ```

4. If branch doesn't exist yet (new feature branch):
   ```bash
   git worktree add -b <branch-name> <path> main
   ```

5. Show the user the path to the new worktree and remind them to `cd` into it.

---

## clean

Remove worktrees that are no longer needed and prune stale references.

1. List all worktrees:
   ```bash
   git worktree list
   ```

2. Identify candidates for removal:
   - Branches that have been merged into main
   - Worktrees with no uncommitted changes

3. For each candidate, show the user:
   - The worktree path and branch
   - Whether the branch has been merged
   - Whether there are any uncommitted changes

4. Ask for confirmation before removing each one (don't bulk-remove without approval).

5. For confirmed removals:
   ```bash
   git worktree remove <path>
   ```

6. Prune any stale administrative files:
   ```bash
   git worktree prune
   ```

---

## help

Show this subcommand reference.
