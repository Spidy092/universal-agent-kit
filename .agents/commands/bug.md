# Command: /bug

Aliases:
- `/bug`
- `/debug`

Uses:
- `debugging`
- Add `testing` when a regression test is practical.
- Add `security-audit` when the bug touches auth, tokens, secrets, permissions, payments, or webhooks.

Examples:

```txt
/bug

Error:
[paste error]
```

```txt
/debug build fails after upgrading vite
```

Workflow:
1. Read the full error, logs, and relevant code.
2. Reproduce or narrow the failure when possible.
3. Find the root cause.
4. Make the smallest safe fix.
5. Run targeted verification and report results.
