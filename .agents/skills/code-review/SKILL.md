---
name: code-review
description: Reviews diffs, PRs, branches, or files for correctness, security, regressions, maintainability, and missing tests. Use before merge.
---

# Code Review Skill

## When to Use

Use when reviewing a PR, diff, branch, risky change, or merge readiness.

## Goal Tracking

Before starting, define:
- **Review Goal**: What specific risks are we looking for?
- **Scope**: Which files/changes are in scope?
- **Done Criteria**: How will we know the review is complete?

## Inputs to Gather

- changed files or diff
- intended behavior
- affected APIs/modules
- tests added/updated
- deployment/user impact

## Workflow

### Phase 1: Context Gathering (3 min)
- [ ] Summarize what the change attempts to do
- [ ] Identify the scope of changes
- [ ] Note any dependencies or side effects

### Phase 2: File Inspection (10 min)
- [ ] Read each changed file completely
- [ ] Understand the context around changes
- [ ] Check for related code that might be affected

### Phase 3: Risk Analysis (10 min)
- [ ] Check for correctness bugs
- [ ] Check for security issues (auth, injection, secrets)
- [ ] Check for missing validation/error handling
- [ ] Check for performance regressions
- [ ] Check for breaking API changes
- [ ] Check for edge cases

### Phase 4: Test Coverage (5 min)
- [ ] Verify tests cover new functionality
- [ ] Check for missing edge case tests
- [ ] Verify test quality (not just coverage)

### Phase 5: Documentation (3 min)
- [ ] Check if README/docs need updates
- [ ] Verify commit messages are clear
- [ ] Check for TODO/FIXME comments

## Review Checklist

### Correctness
- [ ] Does the code do what it claims?
- [ ] Are there off-by-one errors?
- [ ] Are null/undefined cases handled?
- [ ] Are async operations properly awaited?
- [ ] Are resources properly cleaned up?

### Security
- [ ] Is authentication/authorization correct?
- [ ] Is user input validated and sanitized?
- [ ] Are secrets/credentials not exposed?
- [ ] Is SQL/NoSQL injection prevented?
- [ ] Is XSS prevented?
- [ ] Are rate limits applied?

### Maintainability
- [ ] Is the code readable?
- [ ] Are functions appropriately sized?
- [ ] Is there unnecessary duplication?
- [ ] Are names descriptive and consistent?
- [ ] Is error handling comprehensive?

### Performance
- [ ] Are there unnecessary database queries?
- [ ] Are there memory leaks?
- [ ] Are expensive operations cached?
- [ ] Are async operations parallelized where possible?

### Testing
- [ ] Are new features tested?
- [ ] Are edge cases covered?
- [ ] Are error paths tested?
- [ ] Do tests have meaningful assertions?

## Severity Classification

- **Blocking**: Must fix before merge (bugs, security issues, data loss risks)
- **Important**: Should fix soon (performance issues, missing validation)
- **Minor**: Nice to improve (style, naming, documentation)

## Output Format

## Overall assessment
## Blocking issues
## Important issues
## Minor issues
## Missing tests
## Merge readiness
