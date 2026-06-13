# Gemini Project Instructions

Use `AGENTS.md` as the canonical command router and source of truth.

## Primary Workflow

Inside Gemini CLI, use short workflow commands:

```txt
/bug
/review
/fix add login validation
/ui fix mobile navbar
/security
/deploy
/docs check latest OpenWA docs
/refactor
/test
/mode frontend
/use debugging security
```

If Gemini does not natively recognize slash commands, still treat them as workflow commands using the `AGENTS.md` command router.

## Router Inputs

- `.agents/commands` defines in-agent command behavior.
- `.agents/modes` defines session-wide behavior.
- `.agents/skills` defines reusable workflows loaded by the router.

## Workflow

1. Interpret command-style requests through `AGENTS.md`.
2. Load the relevant command, mode, and skill files.
3. Make the smallest safe change.
4. Verify changes with commands where possible.

## Safety

- Do not delete files without asking.
- Do not reset database without asking.
- Do not run destructive terminal commands without asking.
- Do not expose .env, tokens, secrets, private keys, or credentials.
- Give exact verification commands.
