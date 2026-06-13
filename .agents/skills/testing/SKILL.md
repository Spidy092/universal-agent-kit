---
name: testing
description: Designs and writes focused tests for features, bugs, edge cases, and regressions. Use when adding coverage or verifying fixes.
---

# Testing Skill

## When to Use

Use when adding tests, fixing failing tests, turning a bug into a regression test, checking edge cases, or improving confidence before deployment.

## Goal Tracking

Before starting, define:
- **Test Goal**: What specific behavior are we proving?
- **Coverage Target**: What percentage of code/paths must be covered?
- **Done Criteria**: How will we know testing is complete?

## Inputs to Gather

- behavior to prove
- test framework
- existing test patterns
- command to run tests
- fixtures/mocks available
- exact failure mode

## Workflow

### Phase 1: Test Planning (5 min)
- [ ] Identify behavior that must be proven
- [ ] Read nearby tests to understand patterns
- [ ] Determine test level: unit, integration, component, or E2E
- [ ] Plan test cases before writing code

### Phase 2: Test Case Design (10 min)
- [ ] Happy path (expected behavior works)
- [ ] Empty input (nothing provided)
- [ ] Invalid input (wrong types, formats)
- [ ] Large input (performance, limits)
- [ ] Duplicate request (idempotency)
- [ ] Permission issue (unauthorized access)
- [ ] Network failure (timeouts, errors)
- [ ] Database failure (connection issues)
- [ ] Timezone/date edge cases
- [ ] Race conditions (concurrent access)

### Phase 3: Test Implementation (15 min)
- [ ] Write test setup (fixtures, mocks)
- [ ] Implement test cases
- [ ] Add meaningful assertions
- [ ] Clean up after tests

### Phase 4: Test Execution (5 min)
- [ ] Run the tests
- [ ] Verify all pass
- [ ] Check test isolation (no dependencies between tests)
- [ ] Verify test speed is reasonable

### Phase 5: Coverage Analysis (5 min)
- [ ] Check code coverage report
- [ ] Identify uncovered paths
- [ ] Decide if uncovered paths need tests
- [ ] Document coverage gaps

## Test Quality Checklist

### Structure
- [ ] Test name describes what is being tested
- [ ] Arrange-Act-Assert pattern is clear
- [ ] Tests are independent (no shared state)
- [ ] Tests are deterministic (no flakiness)

### Coverage
- [ ] Happy path is covered
- [ ] Error paths are covered
- [ ] Edge cases are covered
- [ ] Boundary conditions are covered

### Assertions
- [ ] Assertions are specific (not just "no error")
- [ ] Assertions test the right thing
- [ ] Assertions have meaningful failure messages

### Maintainability
- [ ] Tests are readable
- [ ] Tests don't test implementation details
- [ ] Tests are easy to update when behavior changes

## Test Types Decision Tree

```
What are you testing?
├── Single function/method → Unit test
├── Multiple components together → Integration test
├── UI component behavior → Component test
├── Full user workflow → E2E test
└── Performance → Load/stress test
```

## Coverage Targets

- **Critical paths**: 100% coverage
- **Business logic**: 90%+ coverage
- **Utility functions**: 80%+ coverage
- **UI components**: 70%+ coverage (focus on behavior)

## Output Format

## Test plan
## Test cases
## Test code
## Command to run
## Expected result
## Coverage report
## Gaps
