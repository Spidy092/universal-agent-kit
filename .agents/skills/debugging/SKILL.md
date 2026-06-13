---
name: debugging
description: Disciplined root-cause debugging for bugs, failing commands, regressions, flaky tests, logs, and screenshots. Use when behavior is broken or unclear.
---

# Debugging Skill

## When to Use

Use when code fails, a command fails, app crashes, tests fail, a screenshot/log/error is provided, or behavior differs from expected.

## Goal Tracking

Before starting, define:
- **Bug Goal**: What specific behavior is broken?
- **Expected Behavior**: What should happen?
- **Actual Behavior**: What is happening?
- **Done Criteria**: How will we know it's fixed?

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

### Phase 1: Problem Definition (2 min)
- [ ] Restate the bug as a clear problem statement
- [ ] Define expected vs actual behavior
- [ ] List reproduction steps (if known)

### Phase 2: Evidence Collection (5 min)
- [ ] Read the full error/log before guessing
- [ ] Identify the failing layer: frontend, backend, database, server, network, auth, dependency, or OS/config
- [ ] Find the owning file/function
- [ ] Check recent changes that might be related

### Phase 3: Hypothesis Formation (3 min)
- [ ] Create 2-4 hypotheses based on evidence
- [ ] Rank hypotheses by likelihood
- [ ] Plan how to test each hypothesis

### Phase 4: Hypothesis Testing (5-10 min)
- [ ] Test most likely hypothesis first
- [ ] Eliminate hypotheses using evidence
- [ ] Document what you've tried and ruled out
- [ ] Continue until root cause is confirmed

### Phase 5: Fix Implementation (5 min)
- [ ] Apply the smallest safe fix
- [ ] Add/update regression test if useful
- [ ] Run verification command

### Phase 6: Verification (3 min)
- [ ] Run the specific test case that was failing
- [ ] Run related tests to check for regressions
- [ ] Document the fix and verification

## Verification Commands

After fixing, always run:
```bash
# Run the specific failing test/command
[command that was failing]

# Run related tests
[related test command]

# Check for lint/type errors
[lint/typecheck command]
```

## Do Not

- rewrite unrelated code
- hide errors silently
- delete files
- reset database
- make broad changes before root cause is known

## Output Format

## Root cause
## Evidence
## Fix
## Files to change
## Commands
## Verification
## Edge cases
