---
name: feature-implementation
description: End-to-end feature implementation from requirements to working code with tests. Use for new features, user stories, or significant functionality additions.
---

# Feature Implementation Skill

## When to Use

Use when implementing new features, user stories, or significant functionality additions that don't exist yet.

## Goal Tracking

Before starting, define:
- **Feature Goal**: What specific functionality are we building?
- **User Story**: As a [user], I want [feature] so that [benefit]
- **Acceptance Criteria**: How will we know the feature is complete?
- **Scope**: What is in-scope and out-of-scope?

## Inputs to Gather

- requirements/user story
- affected files/modules
- existing patterns to follow
- dependencies needed
- test strategy
- deployment considerations

## Workflow

### Phase 1: Requirements Analysis (5 min)
- [ ] Clarify the requirements
- [ ] Identify edge cases
- [ ] Define success criteria
- [ ] Check for existing similar features

### Phase 2: Design Planning (5 min)
- [ ] Identify files to create/modify
- [ ] Plan the implementation approach
- [ ] Check for existing utilities to reuse
- [ ] Plan test strategy

### Phase 3: Implementation (15-30 min)
- [ ] Create/modify the feature code
- [ ] Follow existing code patterns
- [ ] Add error handling
- [ ] Add logging where needed
- [ ] Update documentation if needed

### Phase 4: Testing (10-15 min)
- [ ] Write unit tests for new logic
- [ ] Write integration tests if needed
- [ ] Test edge cases
- [ ] Test error scenarios

### Phase 5: Verification (5 min)
- [ ] Run all tests
- [ ] Run lint/typecheck
- [ ] Manual testing if applicable
- [ ] Verify no regressions

## Implementation Checklist

### Code Quality
- [ ] Follows existing code style
- [ ] Functions are appropriately sized
- [ ] Names are descriptive
- [ ] No unnecessary complexity
- [ ] Error handling is comprehensive

### Functionality
- [ ] Core feature works
- [ ] Edge cases handled
- [ ] Error scenarios handled
- [ ] Input validation added
- [ ] Output is correct

### Testing
- [ ] Unit tests written
- [ ] Integration tests written (if needed)
- [ ] Edge cases covered
- [ ] All tests pass

### Documentation
- [ ] Code comments where needed
- [ ] README updated (if needed)
- [ ] API documentation updated (if needed)

## Common Patterns

### New API Endpoint
1. Create route handler
2. Add validation
3. Add business logic
4. Add database queries
5. Add error handling
6. Add tests
7. Update API docs

### New UI Component
1. Create component file
2. Add props/types
3. Implement component logic
4. Add styling
5. Add states (loading, error, empty)
6. Add accessibility
7. Add tests

### New Business Logic
1. Create service/module
2. Implement core logic
3. Add validation
4. Add error handling
5. Add logging
6. Add tests

## Output Format

## Feature summary
## Implementation plan
## Files changed
## Test plan
## Verification
## Risks/limitations
