---
name: testing
description: Designs and writes focused tests for features, bugs, edge cases, and regressions. Use when adding coverage or verifying fixes.
---


# Testing Skill

## When to Use

Use when adding tests, fixing failing tests, turning a bug into a regression test, checking edge cases, or improving confidence before deployment.

## Inputs to Gather

- behavior to prove
- test framework
- existing test patterns
- command to run tests
- fixtures/mocks available
- exact failure mode

## Workflow

1. Identify behavior that must be proven.
2. Read nearby tests.
3. Pick the smallest useful test level: unit, integration, component, or E2E.
4. Cover happy path, empty input, invalid input, large input, duplicate request, permission issue, network failure, database failure, timezone/date edge, and race condition where relevant.
5. Use deterministic assertions.
6. Run tests.
7. Report gaps honestly.

## Output

```md
## Test plan
## Test cases
## Test code
## Command to run
## Expected result
## Gaps
```
