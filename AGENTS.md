# Project Agent Rules

## Purpose

This repository uses a universal AI-agent workflow.

- `AGENTS.md` is the source of truth for repo-wide rules.
- Reusable procedures live in `.agents/skills/*/SKILL.md`.
- If a task clearly matches a skill, load and follow that skill before acting.
- Keep edits minimal, verifiable, and easy to review.

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

## Skill Routing

Use these skills when the task matches:

- `debugging` — bugs, failing commands, regressions, flaky tests, logs, screenshots
- `code-review` — PR review, diff review, merge readiness, risk analysis
- `testing` — tests, coverage, regression cases, test strategy
- `refactor` — cleanup without behavior change
- `devops-deploy` — server, CI/CD, Docker, PM2, Nginx, SSL, AWS/VPS, rollback
- `security-audit` — auth, secrets, uploads, webhooks, permissions, supply chain
- `frontend-ui` — UI, responsive layout, accessibility, states, animation integration
- `docs-research` — current docs, official repo/source verification, API/CLI behavior
- `rtk-prompting` — serious structured prompts for high-quality outputs
- `caveman-fast-fix` — fast direct bug-fix mode when speed matters

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
