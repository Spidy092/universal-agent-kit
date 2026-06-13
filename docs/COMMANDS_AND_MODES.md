# Commands and Modes

The universal agent kit is an in-agent workflow router. Slash commands are instructions to the coding agent, even when the host tool does not support native slash commands.

## Commands

| Command | Aliases | Workflow |
| --- | --- | --- |
| `/bug` | `/debug` | Load `debugging` for bugs, logs, errors, failures, and regressions. |
| `/review` | | Load `code-review` for diffs, PRs, branches, and merge readiness. |
| `/fix <task>` | | Load `rtk-prompting`; add detected skills for bug, security, or UI work. |
| `/ui` | `/frontend` | Load `frontend-ui` for UI, responsive, accessibility, states, and styling. |
| `/security` | | Load `security-audit` for auth, secrets, webhooks, payments, and permissions. |
| `/deploy` | `/devops` | Load `devops-deploy` for CI/CD, servers, Docker, Nginx, PM2, SSL, and rollback. |
| `/docs` | `/research` | Load `docs-research` for current docs, APIs, packages, and integrations. |
| `/refactor` | | Load `refactor` for behavior-preserving cleanup. |
| `/test` | | Load `testing` for regression tests, QA, coverage, and verification. |
| `/use <skills>` | | Combine named skills, for example `/use debugging security`. |
| `/mode <mode>` | | Activate a session-wide behavior mode. |
| `/help` | | Show commands, modes, and examples. |

## Modes

| Mode | Behavior |
| --- | --- |
| `strict` | No unsupported assumptions, exact files changed, exact test commands. |
| `frontend` | Responsive/mobile, accessibility, existing styles, states, visual verification. |
| `backend` | Validation, error handling, logs, API compatibility, DB impact. |
| `security` | Auth, authz, secrets, injection, rate limits, CORS, uploads, webhooks. |
| `production` | Safest mode, rollback, health checks, logs, env/deploy risks. |
| `fast` | Cause, fix, test; minimal explanation. |
| `research` | Official docs/source when possible, confirmed facts vs assumptions. |
| `review` | Blocking issues first, important/minor findings, missing tests, readiness. |

Use `/mode reset` to clear active modes. If multiple modes are active, combine them conservatively. Production, security, and strict override fast when they conflict.

## Auto-Detection

The router can infer skills from the task:
- errors, stacktraces, failing builds, exceptions, logs -> `debugging`
- review, PR, diff, merge, code quality -> `code-review`
- UI, responsive, mobile, design, animation, CSS -> `frontend-ui`
- deploy, server, nginx, pm2, docker, aws, vps, ssl -> `devops-deploy`
- auth, login, webhook, payment, token, secret, permission -> `security-audit`
- test, coverage, regression, QA -> `testing`
- refactor, cleanup, structure -> `refactor`
- latest docs, API, package docs, integration -> `docs-research`

## Daily Examples

```txt
/bug
/review
/fix add login validation
/ui fix mobile navbar
/security audit upload permissions
/deploy check nginx and pm2 health
/docs check latest OpenWA docs
/mode strict
/mode frontend
/use debugging security
/use frontend-ui testing
```

## Agent Examples

Codex:
```txt
Read AGENTS.md first.
/bug
[paste error]
```

Claude Code:
```txt
/review current diff against main
```

OpenCode:
```txt
/fix add login validation
```

Pi:
```txt
/mode fast
/bug failing npm test
```

Hermes:
```txt
Read AGENTS.md and docs/hermes-setup.md first.
/use debugging testing
```

Gemini:
```txt
/docs check latest package API and cite official source
```

Antigravity:
```txt
/mode production
/deploy verify Docker, Nginx, SSL, logs, health check, rollback
```
