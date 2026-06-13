---
name: find-skills
version: 1.0.0
description: Discover and install specialized agent skills when the local kit does not already contain the right workflow.
---

# Find Skills

Use this workflow when the user asks for a capability that is not covered by the local skills, asks whether a skill exists, or wants to extend the agent.

## Primary Sources

- Browse skills at `https://skills.sh/`.
- Use the Skills CLI when available:

```bash
npx skills find [query]
npx skills add <package>
npx skills check
npx skills update
```

The public `find-skills` package is available at:

```bash
npx skills add https://github.com/vercel-labs/skills --skill find-skills
```

## Workflow

1. Identify the domain and exact task.
2. Check whether a local `.agents/skills/*/SKILL.md` already covers it.
3. If no local skill matches, search `skills.sh` or run `npx skills find [query]` when network/CLI access is available.
4. Prefer reputable skills with strong install count, known maintainers, and an active source repo.
5. Present the best options with the skill name, purpose, source, install command, and link.
6. Ask before installing a skill or running network install commands.
7. If no good skill exists, help directly and suggest creating one with `npx skills init`.

## Quality Rules

- Prefer official or reputable sources such as Vercel, Anthropic, Microsoft, or well-known project maintainers.
- Prefer skills with meaningful install counts and visible source repositories.
- Do not recommend unknown low-signal skills without warning the user.
- Do not install skills automatically without user approval.

## No Match Fallback

If no suitable skill is found, say so clearly, continue with general engineering ability, and offer to create a local skill for repeated use.
