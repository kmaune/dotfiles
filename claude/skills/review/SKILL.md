---
name: review
description: Review your own staged and unstaged code changes before committing or pushing. Invokes the code-reviewer subagent.
disable-model-invocation: true
---

Run a self-review of current local changes using the code-reviewer subagent.

## Steps

1. **Orient yourself**
   - Run `git worktree list` to understand the repo structure
   - Run `git status` to see what's staged, unstaged, and untracked
   - Run `git diff` for unstaged changes
   - Run `git diff --staged` for staged changes
   - If both are empty, check `git diff HEAD~1` in case everything is already committed but not yet pushed

2. **Gather context**
   - Read any files that are new (not just modified) in full — the diff won't show surrounding context for new files
   - If the change touches an interface or type used elsewhere, read the relevant callers to assess impact

3. **Invoke code-reviewer**
   - Hand off all gathered context to the code-reviewer subagent
   - The subagent will assess the diff and produce findings by severity

4. **Report findings**
   - Present findings as returned by code-reviewer
   - If there are CRITICAL findings, make them prominent — these block the push
   - If the overall call is LGTM or LGTM with minor fixes, confirm it's safe to push
