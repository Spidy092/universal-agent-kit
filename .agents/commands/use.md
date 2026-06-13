# Command: /use

Usage:
- `/use <skill1> <skill2>`

Uses:
- The named skills from `.agents/skills`.

Examples:

```txt
/use debugging security
```

```txt
/use frontend-ui testing
```

Workflow:
1. Load each named skill.
2. Resolve conflicts with the safest applicable workflow.
3. Complete one workflow phase at a time.
4. Verify the combined result.
