# Command: /review

Uses:
- `code-review`
- Add `security-audit` for auth, secrets, permissions, payments, uploads, or webhooks.
- Add `testing` when test coverage or regression risk is part of the review.

Examples:

```txt
/review
```

```txt
/review current diff against main
```

Workflow:
1. Inspect the diff and relevant surrounding code.
2. Lead with blocking and high-risk findings.
3. Include file and line references when possible.
4. Call out missing tests and residual risk.
