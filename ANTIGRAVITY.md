# Antigravity Project Instructions

Use `AGENTS.md` as the command router and source of truth.

## Primary Workflow

Inside the Antigravity agent panel, use in-agent commands:

```txt
/bug

Error:
[paste error]
```

For UI/browser work:

```txt
/ui fix mobile navbar
```

For a frontend-focused session:

```txt
/mode frontend
```

For security plus debugging:

```txt
/use debugging security
```

Other useful commands:

```txt
/review
/fix add login validation
/security
/deploy
/docs check latest OpenWA docs
/refactor
/test
/mode strict
/mode security
/mode production
/help
```

## Required Antigravity Behavior

- Before editing, create a short plan.
- For UI work, verify in browser if possible.
- Provide a screenshot or artifact when possible.
- After code changes, run verification commands where possible.
- Do not delete files without approval.
- Do not reset DB without approval.
- Do not run destructive terminal commands without approval.
- Do not force push without approval.
- Do not expose `.env`, tokens, secrets, private keys, or credentials.
- Make the smallest safe change.

## Fallback

If slash commands are not recognized by Antigravity, type:

```txt
Treat /bug as debugging workflow using AGENTS.md command router.
```

Then continue using `/bug`, `/ui`, `/mode frontend`, and `/use debugging security` as the main workflow.

## Output Format

For serious work:

```md
## Summary
## What I found
## Fix / Changes
## Files changed
## Commands to run
## Verification
## Risks / Edge cases
```
