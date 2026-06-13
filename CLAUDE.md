# Claude Project Rules

This file mirrors `AGENTS.md`. Treat `AGENTS.md` as the canonical command router and source of truth. Use `/bug`, `/review`, `/fix`, `/ui`, `/security`, `/deploy`, `/docs`, `/refactor`, `/test`, `/use`, `/mode`, and `/help` as workflow commands.

# Project Agent Rules

## Purpose

This repository uses a universal AI-agent workflow.

- `AGENTS.md` is the source of truth for repo-wide rules.
- Reusable procedures live in `.agents/skills/*/SKILL.md`.
- If a task clearly matches a skill, load and follow that skill before acting.
- Keep edits minimal, verifiable, and easy to review.

## Goal Tracking Framework

Every task MUST follow this goal-tracking process:

### 1. Define Success Criteria
Before starting work, explicitly define:
- **Goal**: What specific outcome are we trying to achieve?
- **Done Criteria**: How will we know the goal is achieved?
- **Scope**: What is in-scope and out-of-scope?
- **Constraints**: Time, dependencies, or limitations

### 2. Create Task Checklist
Break the goal into verifiable steps:
```markdown
- [ ] Step 1: [Specific action]
- [ ] Step 2: [Specific action]
- [ ] Step 3: [Verification]
```

### 3. Track Progress
After each significant change:
- Update the checklist
- Verify the change works
- Document any deviations from the plan

### 4. Verify Completion
Before finishing:
- Run all verification commands
- Confirm all checklist items are complete
- Document any remaining risks or follow-ups

## Operating Model

Before changing code:

1. Understand the user request.
2. Read relevant files fully.
3. Identify the smallest safe change.
4. Explain assumptions when something is unclear.
5. Prefer root-cause fixes over cosmetic changes.
6. Verify changes with commands, tests, logs, or manual checks.

Do not:

- guess when evidence is available
- change unrelated files
- rewrite large sections unless necessary
- remove existing behavior without explaining the impact
- claim success without verification

## Repository Context

Fill this per project:

- Main language:
- Framework/runtime:
- Package manager:
- Database:
- Test command:
- Lint command:
- Typecheck/build command:
- Dev command:
- Production/deploy target:
- Main app entry points:
- Sensitive directories/files:
- Generated files:
- Forbidden edits:

## Architecture Notes

Fill this per project:

- Main modules:
- Data flow:
- External integrations:
- Auth/security boundaries:
- Background jobs:
- API boundaries:
- Deployment flow:
- Subdirectory-specific rules:

## Coding Rules

- Follow existing style before adding new patterns.
- Prefer small diffs.
- Prefer explicit names over clever abstractions.
- Reuse existing utilities before adding new helpers.
- Keep new code testable.
- Do not introduce new dependencies unless justified.
- Preserve public APIs unless the task explicitly requires changing them.
- Keep logs, comments, and errors technically precise.

## Safety and Security

Never do these without explicit approval:

- delete files broadly
- reset or wipe databases
- run destructive migrations
- rotate or print secrets
- force-push or rewrite git history
- modify production configuration
- weaken authentication, authorization, validation, CSP, rate limits, or audit logging

Always:

- avoid printing secrets, tokens, private keys, or `.env` contents
- treat dependency and lockfile changes as reviewed code changes
- use least-privilege commands first
- prefer read-only inspection until write access is clearly needed

## Verification Rules

Before finishing code changes:

1. Run the narrowest relevant check first.
2. Run repo-standard checks when practical.
3. If a check cannot be run, say exactly why.
4. Report failures honestly with likely cause and next action.
5. Do not say “fixed” unless there is evidence.

Use this format:

```txt
Checks run:
- [command] -> [result]

Checks not run:
- [command] -> [reason]
```

## Git Rules

- Check current state before major edits.
- Stage only files changed for the current task.
- Do not use destructive git commands unless asked.
- Commit messages should be concise and explain intent.
- PR summaries should include:
  - what changed
  - why
  - risks
  - checks run

## Command Router

Inside any coding agent, treat slash commands as workflow commands even if the
agent does not natively implement slash-command plugins. Load the matching
skill instructions from `.agents/skills` and the command definition from
`.agents/commands` when present.

### Commands

- `/bug` or `/debug` - use `debugging`.
- `/review` - use `code-review`.
- `/fix <task>` - use `rtk-prompting` and auto-add relevant skills for the task.
- `/ui <task>` or `/frontend <task>` - use `frontend-ui`.
- `/security` - use `security-audit`.
- `/deploy` or `/devops` - use `devops-deploy`.
- `/docs` or `/research` - use `docs-research`.
- `/refactor` - use `refactor`.
- `/test` - use `testing`.
- `/use <skill1> <skill2>` - combine the named skills for the task.
- `/mode <mode>` - activate that session mode from `.agents/modes`.
- `/mode reset` - clear active modes and return to default behavior.
- `/help` - show available commands and modes.

### Auto-Detection

Use the command router even when the user does not type a slash command:

- errors, logs, stack traces, failing commands, or build failures -> `debugging`
- review, PR, diff, merge, or release readiness -> `code-review`
- UI, mobile, responsive, design, CSS, animation, or accessibility -> `frontend-ui`
- deploy, server, Nginx, PM2, Docker, AWS, VPS, SSL, CI/CD, or rollback -> `devops-deploy`
- auth, login, webhook, payment, token, secret, upload, permission, or policy -> `security-audit`
- test, coverage, regression, QA, or failing specs -> `testing`
- refactor, cleanup, structure, or simplification -> `refactor`
- latest docs, API behavior, library integration, CLI behavior, or official sources -> `docs-research`

### Conflict Handling

- `strict`, `security`, and `production` modes override fast mode.
- Security-sensitive tasks automatically add `security-audit`.
- Production and deploy tasks should consider both `devops-deploy` and `security-audit`.
- When `/use` combines skills, apply the highest-safety workflow first, then complete the requested task.
- If a command and auto-detection disagree, prefer the explicit command unless it would weaken safety.

## Skill Routing

Use these skills when the task matches:

- `feature-implementation` — new features, user stories, requirements
- `debugging` — bugs, failing commands, regressions, flaky tests, logs, screenshots
- `code-review` — PR review, diff review, merge readiness, risk analysis
- `testing` — tests, coverage, regression cases, test strategy
- `refactor` — cleanup without behavior change
- `devops-deploy` — server, CI/CD, Docker, PM2, Nginx, SSL, AWS/VPS, rollback
- `security-audit` — auth, secrets, uploads, webhooks, permissions, supply chain
- `frontend-ui` — UI, responsive layout, accessibility, states, animation integration
- `api-design` — REST/GraphQL API design, endpoint planning, versioning
- `database-migration` — safe schema changes, rollback planning, data migrations
- `performance-optimization` — profiling, bottleneck identification, frontend/backend/database optimization
- `docs-research` — current docs, official repo/source verification, API/CLI behavior
- `rtk-prompting` — serious structured prompts for high-quality outputs
- `caveman-fast-fix` — fast direct bug-fix mode when speed matters
- `performance` — profiling, optimization, memory leaks, load testing
- `database` — migrations, queries, schema design, optimization

## Skill Chaining

Many tasks require multiple skills. Use this decision tree:

```
User Request
├── New feature? → feature-implementation
│   ├── Need API? → api-design
│   └── Need UI? → frontend-ui
├── Bug/Broken? → debugging
│   └── Need tests? → testing
├── Review code? → code-review
├── Optimize? → performance-optimization
├── Database work? → database-migration
├── Deploy? → devops-deploy
└── Security concern? → security-audit
```

When chaining skills:
1. Complete one skill fully before starting the next
2. Verify completion before moving on
3. Update goal checklist at each skill transition

## Output Format

For non-trivial work, respond with:

```md
## Summary
## What I found
## Changes / Fix
## Files changed
## Commands to run
## Verification
## Risks / Edge cases
```

For code review, use:

```md
## Overall assessment
## Blocking issues
## Important issues
## Minor issues
## Missing tests
## Merge readiness
```

## Escalate / Ask Before Acting

Stop and ask before acting if:

- requirements conflict
- production data may be affected
- irreversible migrations are involved
- secrets exposure is possible
- the repo state is dirty in unrelated ways
- the requested change requires breaking an API
- the test/build workflow is unknown and risky
