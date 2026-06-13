# Antigravity Project Instructions

Read `AGENTS.md` first. Treat it as the project contract.

Support `/bug`, `/review`, `/fix`, `/ui`, `/security`, `/deploy`, `/docs`, `/refactor`, `/test`, `/use`, `/mode`, and `/help` as in-agent workflow commands. Route them through `.agents/commands` and the relevant `.agents/skills`.

Before editing, give a short plan. After editing, verify with terminal commands, browser checks, or artifacts when possible.

Safety:
- Ask before destructive actions.
- Do not expose secrets, tokens, private keys, or `.env` contents.
- Do not delete files broadly, reset databases, or force-push without approval.
- Keep changes minimal and report files changed.
