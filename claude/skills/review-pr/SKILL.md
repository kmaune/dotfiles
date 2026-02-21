---
name: review-pr
description: Review a pull request or feature branch from another author. Automates diff and tree generation, then runs the structured three-phase pr-reviewer workflow.
disable-model-invocation: true
---

Conduct a full PR review of a feature branch. Takes a branch name as the argument.

Usage: `/review-pr <branch-name>`

## Phase 0: Automated Setup

1. **Verify the branch exists**
   ```bash
   git branch -a | grep <branch-name>
   ```
   If not found locally, fetch it:
   ```bash
   git fetch origin <branch-name>
   ```

2. **Identify the merge base**
   ```bash
   git merge-base main <branch-name>
   ```
   Use this to confirm the diff will capture everything on the feature branch since it diverged.

3. **Generate the diff**
   ```bash
   git diff main...<branch-name> > /tmp/pr_review_diff.diff
   ```
   Show the user the diff size (lines changed, files affected):
   ```bash
   git diff main...<branch-name> --stat
   ```

4. **Generate the directory tree**
   ```bash
   tree -I '.git|node_modules|build|__pycache__|*.pyc|target|.cache' > /tmp/pr_review_tree.txt
   ```
   If `tree` is not available, fall back to:
   ```bash
   find . -not -path './.git/*' -not -path '*/node_modules/*' -not -path '*/build/*' | sort > /tmp/pr_review_tree.txt
   ```

5. **Gather commit history for the branch**
   ```bash
   git log main...<branch-name> --oneline
   ```

## Phase 1–3: Review

Hand off to the pr-reviewer subagent with:
- The generated diff (`/tmp/pr_review_diff.diff`)
- The directory tree (`/tmp/pr_review_tree.txt`)
- The commit history

The pr-reviewer subagent will:
1. Gather additional context iteratively (asking for specific files as needed)
2. Produce an Executive Summary — wait for acknowledgment
3. Produce an Architecture Review — wait for acknowledgment
4. Produce a Detailed Review with severity-classified findings

Do not compress or skip phases. Each phase surfaces different concerns and the user may want to discuss before proceeding.
