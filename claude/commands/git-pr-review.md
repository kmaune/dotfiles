---
name: git-pr-review
description: Automated PR review workflow with quality gates and team coordination
---

Perform a comprehensive pull request review workflow:

## Phase 1: PR Analysis
1. **Examine the diff** - Understand scope and impact of changes
2. **Review commit history** - Check for clean, atomic commits
3. **Validate branch strategy** - Ensure proper branching workflow
4. **Check PR description** - Verify completeness and clarity

## Phase 2: Automated Quality Gates

**Code Quality Checks:**
- Run static analysis tools (clang-tidy, pylint, ESLint)
- Check code formatting consistency
- Verify test coverage requirements
- Validate documentation updates

**Build and Test Verification:**
- Ensure all tests pass
- Run relevant benchmarks if performance-critical
- Check for compilation warnings
- Validate integration test results

**Security and Safety:**
- Scan for common security vulnerabilities
- Check for hardcoded secrets or credentials
- Verify input validation and error handling
- Review dependency changes for security issues

## Phase 3: Code Review

**Coordinate with specialist agents:**
- Use `principal-code-reviewer` for general review
- Escalate to `cpp-performance-expert` for performance-critical C++ code
- Involve `hft-systems-architect` for trading system changes
- Call `security-auditor` for security-sensitive modifications

**Review Focus Areas:**
1. **Correctness** - Logic errors and edge cases
2. **Performance** - Algorithmic efficiency and resource usage
3. **Maintainability** - Code clarity and documentation
4. **Security** - Vulnerability assessment
5. **Architecture** - Design consistency and patterns

## Phase 4: Feedback and Resolution

**Generate structured feedback:**
PR Review Summary
🚨 Blocking Issues (Must fix)

[List critical issues that prevent merge]

⚠️ Important Issues (Should fix)

[List significant issues for current PR]

📝 Suggestions (Future improvements)

[List minor improvements and refactoring opportunities]

✅ Positive Feedback

[Highlight good practices and improvements]

Overall Assessment: [APPROVE/CHANGES_REQUESTED/NEEDS_DISCUSSION]
**Coordination Actions:**
- Request changes through GitHub/GitLab API
- Assign specific reviewers for specialized areas
- Create follow-up issues for non-blocking improvements
- Update PR labels and project boards

## Phase 5: Merge Readiness

**Pre-merge checklist:**
- All blocking issues resolved
- Required approvals obtained
- CI/CD pipeline passing
- No merge conflicts
- Branch up-to-date with target

**Merge execution:**
- Select appropriate merge strategy (merge commit, squash, rebase)
- Generate comprehensive merge commit message
- Tag release if applicable
- Clean up feature branch
- Update related issues and project boards

## Configuration Options

Ask for:
- **Repository type** - GitHub, GitLab, Bitbucket
- **Team size and roles** - Review assignment strategy
- **Quality gates** - Required checks and thresholds
- **Merge strategy** - Team preferences for merge commits
- **Performance requirements** - Whether to run benchmarks
- **Security requirements** - Level of security review needed

Then execute the appropriate workflow with the configured quality gates and review processes.
