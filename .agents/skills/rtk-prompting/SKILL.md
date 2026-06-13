---
name: rtk-prompting
description: Structured Role-Task-Knowledge prompting for serious development tasks where quality, constraints, and output format matter.
---

# RTK Prompting Skill

RTK means Role, Task, Knowledge, Rules, Output.

## When to Use

Use when task is complex, output must be precise, multiple constraints exist, coding agent keeps giving wrong output, or you need high-quality implementation/review.

## Goal Tracking

Before starting, define:
- **Prompt Goal**: What specific output do we need?
- **Quality Criteria**: How will we know the output is good?
- **Constraints**: What limitations exist?

## Template

### Role
You are a senior [backend/frontend/devops/security/full-stack] developer.

### Task
[Exact task with specific requirements]

### Knowledge
[Project context, framework, files, existing behavior, error logs]

### Rules
- Read existing code first.
- Do not assume missing details.
- Make minimal safe changes.
- Preserve business logic unless required.
- Include edge cases.
- Give verification commands.

### Output
- Summary
- Root cause / plan
- Files to change
- Code/fix
- Commands
- Verification
- Edge cases

## Enhanced Template with Goal Tracking

### Role
You are a senior [role] developer.

### Task
[Exact task with specific requirements]

### Goal
- **What**: [Specific outcome]
- **Why**: [Business/technical reason]
- **Done Criteria**: [How we know it's complete]

### Knowledge
[Project context, framework, files, existing behavior, error logs]

### Constraints
- [Time constraints]
- [Technical constraints]
- [Dependency constraints]

### Rules
- Read existing code first.
- Do not assume missing details.
- Make minimal safe changes.
- Preserve business logic unless required.
- Include edge cases.
- Give verification commands.

### Output Format
```markdown
## Summary
## What I found
## Changes / Fix
## Files changed
## Commands to run
## Verification
## Risks / Edge cases
```

## Usage Examples

### For Bug Fix
```
Role: Senior backend developer
Task: Fix authentication error on login
Goal: Users can log in without errors
Knowledge: Using Express.js, JWT tokens, PostgreSQL
Rules: Minimal changes, preserve existing auth flow
Output: Fix with verification steps
```

### For New Feature
```
Role: Senior full-stack developer
Task: Add user profile page
Goal: Users can view and edit their profile
Knowledge: React frontend, Node.js backend, MongoDB
Rules: Follow existing patterns, add tests
Output: Implementation with test plan
```

### For Code Review
```
Role: Senior security engineer
Task: Review payment processing code
Goal: Ensure security and correctness
Knowledge: Stripe integration, PCI compliance requirements
Rules: Focus on security, data handling, error scenarios
Output: Security findings with severity levels
```

## Output Format

## Role assigned
## Task defined
## Goal specified
## Knowledge gathered
## Rules applied
## Output delivered
