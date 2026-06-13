# /use <skill1> <skill2> ...

Aliases: none

Skills: explicitly named by the user.

Use when the user wants to combine multiple skills, such as `/use debugging security` or `/use frontend-ui testing`.

Required behavior:
- Read `AGENTS.md` first.
- Load each requested `.agents/skills/<skill>/SKILL.md` that exists.
- If a requested skill is missing, say so and continue with available relevant skills.
- Combine instructions conservatively; safety, security, production, and strict requirements override speed.
- Explain which skills are active before acting.

Output format:
- Use the output format from `AGENTS.md`.
- If one active skill has a stricter output contract, use the stricter contract.
