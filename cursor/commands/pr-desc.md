# Generate MR Description

Generate a GitLab Merge Request description from the attached diff.

## Setup
Attach the diff file generated with:
```bash
git diff main... > feature_to_review_mr.diff
```

## Output Format

Produce a GitLab MR description with the following sections:

### What
Brief description of what changed and why. One short paragraph — focus on intent, not implementation detail.

### Changes
Bullet list of the meaningful changes. Group related changes together. Skip mechanical changes (formatting, renames) unless they are the point of the MR.

### Testing
How the changes were verified:
- Which tests were run (`direnv exec . <test command>`)
- Any manual verification steps
- Known gaps in test coverage, if any

### Risk
Honest assessment of risk:
- Any changes to the critical path (Features → Model → Strategy → Execution)
- Any changes to risk management, position tracking, or perimeter limits
- Any changes that affect deterministic replay capability
- If low risk, say so and why

### Checklist
- [ ] Build passes (`direnv exec . <build command>`)
- [ ] Relevant tests pass
- [ ] No allocations or syscalls introduced on critical paths
- [ ] New components follow DI/factory pattern
- [ ] const correctness maintained
