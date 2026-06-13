# Hermes Setup

Hermes can use the universal kit through plain project instructions.

Recommended setup:

```bash
mkdir -p .hermes
cp ~/.ai-agents/.hermes/SOUL.md .hermes/SOUL.md
```

If a project does not use `.hermes`, keep these instructions in `docs/hermes-setup.md` and tell Hermes:

```txt
Read AGENTS.md and docs/hermes-setup.md first.
```

Hermes should treat these as workflow commands even if slash commands are not native:
- `/bug`
- `/review`
- `/fix add login validation`
- `/ui fix mobile navbar`
- `/security`
- `/deploy`
- `/docs check latest OpenWA docs`
- `/use debugging security`
- `/mode strict`

Route commands through `.agents/commands`, load workflows from `.agents/skills`, and keep active modes from `.agents/modes` for the session.
