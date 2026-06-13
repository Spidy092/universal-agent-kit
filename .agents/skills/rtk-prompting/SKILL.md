---
name: rtk-prompting
description: Structured Role-Task-Knowledge prompting for serious development tasks where quality, constraints, and output format matter.
---


# RTK Prompting Skill

RTK means Role, Task, Knowledge, Rules, Output.

## When to Use

Use when task is complex, output must be precise, multiple constraints exist, coding agent keeps giving wrong output, or you need high-quality implementation/review.

## Template

```txt
Role:
You are a senior [backend/frontend/devops/security/full-stack] developer.

Task:
[Exact task]

Knowledge:
[Project context, framework, files, existing behavior, error logs]

Rules:
- Read existing code first.
- Do not assume missing details.
- Make minimal safe changes.
- Preserve business logic unless required.
- Include edge cases.
- Give verification commands.

Output:
- Summary
- Root cause / plan
- Files to change
- Code/fix
- Commands
- Verification
- Edge cases
```
