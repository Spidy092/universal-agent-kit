---
name: debugging
description: Disciplined root-cause debugging for bugs, failing commands, regressions, flaky tests, logs, and screenshots. Use when behavior is broken or unclear.
---


# Debugging Skill

## When to Use

Use when code fails, a command fails, app crashes, tests fail, a screenshot/log/error is provided, or behavior differs from expected.

## Inputs to Gather

- exact error message
- expected behavior
- actual behavior
- reproduction steps
- relevant files
- recent changes
- OS/runtime/framework versions if relevant
- commands already tried

## Workflow

1. Restate the bug as a clear problem.
2. Read the full error/log before guessing.
3. Identify the failing layer: frontend, backend, database, server, network, auth, dependency, or OS/config.
4. Find the owning file/function.
5. Create 2–4 hypotheses.
6. Eliminate hypotheses using evidence.
7. Apply the smallest safe fix.
8. Add/update regression test if useful.
9. Run verification command.
10. Report confirmed facts and remaining assumptions.

## Do Not

- rewrite unrelated code
- hide errors silently
- delete files
- reset database
- make broad changes before root cause is known

## Output

```md
## Root cause
## Evidence
## Fix
## Files to change
## Commands
## Verification
## Edge cases
```
