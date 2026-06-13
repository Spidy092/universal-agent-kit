---
name: deploy
description: Route deploy, CI/CD, Docker, Nginx, PM2, SSL, VPS, AWS, and production tasks to devops-deploy.
---

Read `AGENTS.md` first, then use `.agents/commands/deploy.md` and `.agents/skills/devops-deploy/SKILL.md`.

Workflow:
- Prefer read-only inspection first.
- Ask before destructive or production-impacting actions.
- Include environment risks, logs, health checks, and rollback.
- Add `security-audit` when secrets or public exposure are involved.
