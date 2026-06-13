Use `AGENTS.md` as the canonical command router and source of truth.

Treat `/bug`, `/review`, `/fix`, `/ui`, `/security`, `/deploy`, `/docs`, `/refactor`, `/test`, `/use`, `/mode`, and `/help` as workflow commands.

Load command definitions from `.agents/commands`, session behavior from `.agents/modes`, and reusable workflows from `.agents/skills`.

Keep changes minimal and verifiable. Do not perform destructive actions without approval. Do not expose secrets.
