# Code Review

Perform a structured code review of the attached diff.

## Setup
Attach the diff file generated with:
```bash
git diff main... > feature_to_review_mr.diff
```
This represents the MR diff as shown in GitLab — changes on the feature branch relative to the common ancestor with `main`.

## Instructions
Apply @code-review.mdc and review the attached diff in full before commenting on individual hunks.

Do not assume context outside the diff unless you can see it in the current worktree. If critical context is missing (e.g. an interface definition, a header file for a changed `.cpp`), say so explicitly and ask for it before proceeding.

Produce the review using the severity tiers and output format defined in @code-review.mdc.
