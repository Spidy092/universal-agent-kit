# Command: /deploy

Aliases:
- `/deploy`
- `/devops`

Uses:
- `devops-deploy`
- Add `security-audit` for production, secrets, TLS, auth, firewall, or permissions.

Examples:

```txt
/deploy
```

```txt
/devops check nginx, pm2, ssl, and rollback plan
```

Workflow:
1. Inspect environment, process manager, ports, logs, and health checks.
2. Avoid destructive production actions without approval.
3. Prefer rollback-safe changes.
4. Run verification commands where possible.
