# Command: /find-skill

Aliases:
- `/find-skill`
- `/skills find`
- `/skill find`

Uses:
- `find-skills`

Examples:

```txt
/find-skill whatsapp automation
```

```txt
/skills find playwright visual testing
```

Workflow:
1. Check local `.agents/skills` first.
2. If no local skill matches, search `skills.sh` or use `npx skills find [query]` when available.
3. Verify quality before recommending a skill.
4. Ask before installing anything.
5. If no good skill exists, proceed directly and suggest creating a new skill.
