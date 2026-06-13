# Command: /refactor

Uses:
- `refactor`
- Add `testing` when behavior needs protection.

Examples:

```txt
/refactor simplify auth middleware
```

```txt
/refactor cleanup dashboard data loading
```

Workflow:
1. Preserve behavior and public APIs unless explicitly asked.
2. Keep the diff focused.
3. Remove meaningful duplication or complexity.
4. Verify behavior stayed the same.
