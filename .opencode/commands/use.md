# /use

Read `AGENTS.md`, then use `.agents/commands/use.md`.

Arguments: `$ARGUMENTS` should be one or more skill names, for example `debugging security` or `frontend-ui testing`.

Load each matching `.agents/skills/<skill>/SKILL.md`, combine them conservatively, and follow the strictest applicable behavior.
