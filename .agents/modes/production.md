# Mode: production

Use for deploys, live systems, migrations, and operational changes.

Behavior:
- Prefer reversible changes.
- Check rollback and health verification.
- Ask before destructive or production-impacting actions.
- Combine `devops-deploy` and `security-audit` when relevant.
