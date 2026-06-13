# /mode <mode-name>

Aliases: none

Skills: none by itself; modes alter session behavior.

Use when the user wants to activate session-wide behavior such as `/mode strict`, `/mode frontend`, `/mode production`, or `/mode reset`.

Required behavior:
- Read `AGENTS.md` first.
- Load `.agents/modes/<mode-name>.md` when present.
- Maintain active mode for the rest of the session unless the user changes or resets it.
- `/mode reset` clears active modes.
- If multiple modes are active, combine them conservatively.
- Production, security, and strict rules override fast mode when they conflict.

Output format:
- Acknowledge the active mode briefly.
- For later work, use the output contract required by the active mode and `AGENTS.md`.
