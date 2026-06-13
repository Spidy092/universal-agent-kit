---
name: docs-research
description: Checks official docs, source repos, CLI help, issues, and alternatives before technical claims. Use for current APIs/tools or when something may be outdated.
---


# Docs Research Skill

## When to Use

Use when API behavior may have changed, library/framework details matter, the user asks “are you sure,” tool/CLI behavior is unclear, implementation depends on current docs, or before saying “not possible.”

## Inputs to Gather

- exact library/tool/framework
- version if known
- exact question
- local code path affected
- desired output: answer, implementation plan, workaround, source-code modification, or prototype/hack path

## Workflow

1. Define the exact question.
2. Check official docs first.
3. Check official GitHub repo/source.
4. Check CLI help if it is a CLI/tool.
5. Check issues/discussions if behavior is unclear.
6. Separate confirmed facts, assumptions, and guesses.
7. Provide all viable routes: official way, workaround, source-code modification, prototype/hack method.

## Output

```md
## Confirmed facts
## Assumptions
## Recommended route
## Official method
## Workaround
## Source-code modification route
## Prototype/hack route
## Risks
```
