---
name: caveman-fast-fix
description: Fast direct mode for simple bugs and small fixes. Use when speed matters and the user wants exact fix without long explanation.
---


# Caveman Fast Fix Skill

## When to Use

Use when the user wants a quick fix, error is clear, change is small, and no deep architecture decision is needed.

## Prompt Style

```txt
Fix this.
Read the error.
Find root cause.
Give exact code.
Give exact command to test.
Do not over-explain.
Do not rewrite unrelated code.
```

## Workflow

1. Read error.
2. Find direct cause.
3. Give smallest fix.
4. Give command to test.
5. Mention only important edge case.

## Output

```md
## Cause
## Fix
## Command to test
```
