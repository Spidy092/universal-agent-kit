---
name: devops-deploy
description: Deployment, CI/CD, VPS, AWS, Docker, Nginx, PM2, SSL, logs, health checks, rollback, and operational readiness.
---


# DevOps Deploy Skill

## When to Use

Use when deploying apps, configuring VPS/AWS, fixing PM2/systemd/Nginx, setting SSL, writing CI/CD, changing Docker, handling logs/health checks, or planning rollback.

## Inputs to Gather

- OS/server
- app stack
- process manager
- port
- domain
- reverse proxy
- env variables
- logs
- deployment target
- rollback path

## Workflow

1. Identify current runtime and deployment path.
2. Check environment variables.
3. Check ports and firewall.
4. Check process manager: PM2, systemd, Docker.
5. Check reverse proxy and SSL.
6. Add health check.
7. Add log commands.
8. Create rollback plan.
9. Give commands in safe order.

## Safety

Ask before editing production env, running migrations, restarting critical services, deleting logs/data, or changing DNS.

## Output

```md
## Current state
## Deployment/fix plan
## Commands
## Health check
## Logs to check
## Rollback
## Risks
```
