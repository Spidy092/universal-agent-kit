---
name: caveman-fast-fix
description: Fast direct mode for simple bugs and small fixes. Use when speed matters and the user wants exact fix without long explanation.
---

# Caveman Fast Fix Skill

## When to Use

Use when the user wants a quick fix, error is clear, change is small, and no deep architecture decision is needed.

## Goal Tracking

Before starting, define:
- **Fix Goal**: What specific issue are we fixing?
- **Done Criteria**: How will we know it's fixed?
- **Risk Level**: Is this safe to fix quickly?

## Prompt Style

Fix this.
Read the error.
Find root cause.
Give exact code.
Give exact command to test.
Do not over-explain.
Do not rewrite unrelated code.

## Workflow

### Phase 1: Quick Assessment (1 min)
- [ ] Read the error
- [ ] Identify if this is a simple fix
- [ ] Confirm no deep architecture needed

### Phase 2: Root Cause (2 min)
- [ ] Find direct cause
- [ ] Identify the exact file/line
- [ ] Understand the context

### Phase 3: Fix (3 min)
- [ ] Give smallest fix
- [ ] Give exact code change
- [ ] Explain only if critical

### Phase 4: Verification Gate (2 min)
- [ ] Give command to test
- [ ] Wait for user confirmation
- [ ] Only then consider done

## Verification Gate

**CRITICAL**: Do NOT claim success until:

1. User runs the test command
2. User confirms it works
3. If user doesn't confirm, ask for error output

```
Fix applied.
Command to test: [exact command]
Run this and tell me if it works.
```

## Do Not

- rewrite unrelated code
- over-explain
- add unnecessary comments
- change more than needed
- claim success without verification

## Output

## Cause
## Fix
## Command to test
## Verification status (wait for user)
