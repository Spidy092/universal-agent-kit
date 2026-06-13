---
name: refactor
description: Behavior-preserving cleanup to improve structure, naming, duplication, and maintainability. Use when code should be cleaner without changing behavior.
---


# Refactor Skill

## When to Use

Use when code is duplicated, functions are too large, names are confusing, module boundaries are unclear, and behavior must stay the same.

## Inputs to Gather

- target file/module
- current pain point
- public API that must stay stable
- existing tests
- verification command

## Workflow

1. Define what must not change.
2. Read call sites.
3. Make the smallest useful structural improvement.
4. Preserve behavior.
5. Avoid mixing feature work with refactor.
6. Run tests/checks.
7. Explain behavior-preservation evidence.

## Do Not

- change business logic silently
- rename public APIs without approval
- do large rewrite when small cleanup works
- move files without clear benefit

## Output

```md
## Refactor goal
## What changed
## What did not change
## Files changed
## Verification
## Remaining risks
```
