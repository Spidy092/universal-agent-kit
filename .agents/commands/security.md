# Command: /security

Uses:
- `security-audit`
- Add `debugging`, `testing`, or `devops-deploy` when the task needs them.

Examples:

```txt
/security
```

```txt
/security review login, uploads, and API permissions
```

Workflow:
1. Identify trust boundaries and sensitive data.
2. Review auth, authorization, validation, secrets, and logging.
3. Fix high-risk issues before cosmetic work.
4. Verify without exposing secrets.
