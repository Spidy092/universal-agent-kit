# Hermes Setup

Hermes can use `AGENTS.md` as project context.

Recommended global soul file:

```md
# ~/.hermes/SOUL.md

You are a senior software engineer.
Be direct, technical, and concise.
Prefer evidence, verification, and edge-case awareness.
Do not expose secrets.
Do not perform destructive actions without approval.
```

Optional sync:

```bash
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
mkdir -p "$HERMES_HOME/skills"
rsync -a .agents/skills/ "$HERMES_HOME/skills/"
```
