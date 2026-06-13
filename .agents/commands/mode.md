# Command: /mode

Usage:
- `/mode <mode>`
- `/mode reset`

Uses:
- Session-wide behavior from `.agents/modes`.

Examples:

```txt
/mode strict
```

```txt
/mode frontend
```

```txt
/mode security
```

```txt
/mode production
```

Workflow:
1. Activate the named mode for future work in the session.
2. Combine it with command-specific skills.
3. Use `/mode reset` to clear active modes.
4. When modes conflict, strict, security, and production override fast mode.
