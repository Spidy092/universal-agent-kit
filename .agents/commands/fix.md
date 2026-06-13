# Command: /fix

Usage:
- `/fix <task>`

Uses:
- `rtk-prompting`
- Auto-add relevant skills based on the task.

Examples:

```txt
/fix add login validation
```

```txt
/fix checkout fails when coupon is expired
```

Workflow:
1. Convert the request into clear success criteria.
2. Select the smallest relevant skill chain.
3. Read existing code before editing.
4. Implement a focused fix.
5. Verify with targeted commands.
