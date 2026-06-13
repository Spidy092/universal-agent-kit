# production mode

Session behavior:
- Use the safest practical path.
- Ask before destructive commands, migrations, production config changes, database changes, or force pushes.
- Include rollback steps for deploy or config changes.
- Include logs, health checks, monitoring, and environment risks.
- Prefer read-only inspection until the action is clearly safe.
- Production, security, and strict constraints override fast-mode brevity.
