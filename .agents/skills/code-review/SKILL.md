---
name: code-review
description: Reviews diffs, PRs, branches, or files for correctness, security, regressions, maintainability, and missing tests. Use before merge.
---


# Code Review Skill

## When to Use

Use when reviewing a PR, diff, branch, risky change, or merge readiness.

## Inputs to Gather

- changed files or diff
- intended behavior
- affected APIs/modules
- tests added/updated
- deployment/user impact

## Workflow

1. Summarize what the change attempts to do.
2. Inspect changed files first.
3. Inspect nearby related code if needed.
4. Look for correctness bugs, security issues, missing validation, missing error handling, performance regressions, breaking API changes, missing tests, and edge cases.
5. Prioritize real risks over style comments.
6. For each finding, include severity, file/location, problem, why it matters, and suggested fix.

## Severity

- Blocking: must fix before merge
- Important: should fix soon
- Minor: nice to improve

## Output

```md
## Overall assessment
## Blocking issues
## Important issues
## Minor issues
## Missing tests
## Merge readiness
```
