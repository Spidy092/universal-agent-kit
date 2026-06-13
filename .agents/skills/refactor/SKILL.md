---
name: refactor
description: Behavior-preserving cleanup to improve structure, naming, duplication, and maintainability. Use when code should be cleaner without changing behavior.
---

# Refactor Skill

## When to Use

Use when code is duplicated, functions are too large, names are confusing, module boundaries are unclear, and behavior must stay the same.

## Goal Tracking

Before starting, define:
- **Refactor Goal**: What specific improvement are we making?
- **Behavior Preservation**: How will we ensure behavior doesn't change?
- **Done Criteria**: How will we know the refactor is complete?

## Inputs to Gather

- target file/module
- current pain point
- public API that must stay stable
- existing tests
- verification command

## Workflow

### Phase 1: Analysis (5 min)
- [ ] Define what must not change
- [ ] Read call sites
- [ ] Understand current behavior
- [ ] Identify the smallest useful improvement

### Phase 2: Planning (5 min)
- [ ] Plan the refactoring steps
- [ ] Identify risks
- [ ] Plan verification strategy
- [ ] Create checklist

### Phase 3: Implementation (10-20 min)
- [ ] Make the smallest useful structural improvement
- [ ] Preserve behavior
- [ ] Avoid mixing feature work with refactor
- [ ] Follow existing patterns

### Phase 4: Verification (10 min)
- [ ] Run tests/checks
- [ ] Verify behavior preserved
- [ ] Check for regressions
- [ ] Document changes

## Refactoring Techniques

### Code Structure
- Extract function/method
- Extract class/module
- Inline function/method
- Move function/method
- Rename variable/function/class

### Code Simplification
- Replace conditional with polymorphism
- Replace nested conditionals with guard clauses
- Replace magic numbers with named constants
- Remove dead code
- Simplify conditional expressions

### Code Organization
- Group related functions
- Separate concerns
- Create proper modules
- Establish clear interfaces

## Behavior Preservation Checklist

### Before Refactoring
- [ ] Existing tests pass
- [ ] Current behavior documented
- [ ] Public API identified
- [ ] Call sites mapped

### During Refactoring
- [ ] Make one change at a time
- [ ] Run tests after each change
- [ ] Don't change behavior accidentally
- [ ] Keep public API stable

### After Refactoring
- [ ] All tests still pass
- [ ] No new bugs introduced
- [ ] Code is cleaner/more readable
- [ ] No performance regression

## Do Not

- change business logic silently
- rename public APIs without approval
- do large rewrite when small cleanup works
- move files without clear benefit
- mix feature work with refactor

## Output Format

## Refactor goal
## What changed
## What did not change
## Files changed
## Verification
## Remaining risks
