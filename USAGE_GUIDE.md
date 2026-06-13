# Universal Agent Kit Usage Guide

## Mental Model

Do not copy a full skill system into every project manually.

```txt
GitHub repo        = master copy of the kit
Each system        = clone once and install once
Each project       = run agent-init once
Each coding agent  = open project and use /bug, /ui, /mode, /use, etc.
```

## 1. Push the Kit to GitHub

Create a private GitHub repo named `universal-agent-kit`, then push this folder.

```bash
cd ~/Downloads/universal-agent-kit
git init
git add .
git commit -m "Initial universal agent kit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/universal-agent-kit.git
git push -u origin main
```

Never commit `.env`, API keys, tokens, private keys, client passwords, or service account JSON files.

## 2. Install on Any System

Linux/macOS/Git Bash:

```bash
git clone https://github.com/YOUR_USERNAME/universal-agent-kit.git ~/universal-agent-kit
cd ~/universal-agent-kit
bash install-global-agent-kit.sh
export PATH="$HOME/.local/bin:$PATH"
```

Check:

```bash
which agent-init
```

Expected:

```txt
/home/YOUR_USER/.local/bin/agent-init
```

Windows PowerShell:

```powershell
git clone https://github.com/YOUR_USERNAME/universal-agent-kit.git "$env:USERPROFILE\universal-agent-kit"
cd "$env:USERPROFILE\universal-agent-kit"
powershell -ExecutionPolicy Bypass -File .\install-global-agent-kit.ps1
```

Restart PowerShell, then check:

```powershell
Get-Command agent-init
```

Expected command location:

```txt
%LOCALAPPDATA%\Programs\UniversalAgentKit\agent-init.cmd
```

## 3. Initialize Any Project

```bash
cd /path/to/project
agent-init
```

Windows PowerShell:

```powershell
cd C:\path\to\project
agent-init
```

Expected output:

```txt
Created AGENTS.md
Linked .agents -> global skills
Created CLAUDE.md
Created .claude/skills
Linked .codex
Linked .opencode
Linked .pi
Done.
```

## 4. Effective In-Agent Workflow

Open any coding agent:

```bash
codex
claude
opencode
pi
hermes
gemini
antigravity
```

Then type workflow commands inside the agent:

```txt
/bug
/review
/fix add login validation
/ui fix mobile navbar
/security
/deploy
/docs check latest OpenWA docs
/refactor
/test
/mode strict
/mode frontend
/mode security
/mode production
/use debugging security
/use frontend-ui testing
/find-skill whatsapp automation
```

`AGENTS.md` is the router. It tells the agent how to interpret these commands even when the tool does not have native slash-command support.

## 5. What the Router Uses

| Path | Purpose |
|------|---------|
| `AGENTS.md` | Command router and repo-wide rules |
| `.agents/skills` | Reusable workflows |
| `.agents/commands` | Command definitions |
| `.agents/modes` | Session-wide behavior |
| `CLAUDE.md`, `GEMINI.md`, `ANTIGRAVITY.md`, `.codex`, `.opencode`, `.pi` | Agent adapters |

## 6. Available Skills

| Skill | Use When | Goal |
|-------|----------|------|
| `feature-implementation` | New features, user stories | End-to-end feature development |
| `debugging` | Bugs, errors, crashes | Root-cause analysis and fix |
| `code-review` | PR review, diff review | Find issues before merge |
| `testing` | Add tests, fix failing tests | Verify behavior works |
| `refactor` | Clean up code | Improve without changing behavior |
| `devops-deploy` | Server, CI/CD, Docker | Deploy and operationalize |
| `security-audit` | Auth, secrets, permissions | Find and fix security risks |
| `frontend-ui` | UI components, layout | Build responsive, accessible UI |
| `docs-research` | API docs, tool behavior | Find accurate information |
| `rtk-prompting` | Complex tasks, quality output | Structured high-quality prompts |
| `caveman-fast-fix` | Quick bugs, speed matters | Fast direct fix |
| `find-skills` | Missing local workflow, external capability | Discover installable skills |
| `performance-optimization` | Slow code, memory issues | Profile and optimize |
| `database-migration` | Schema, migrations, queries | Database changes and optimization |

## 7. Commands

### Bug or Debugging

```txt
/bug

Error:
[paste error]
```

```txt
/debug build fails after upgrading vite
```

### Code Review

```txt
/review current diff against main
```

### Structured Fix

```txt
/fix add login validation
```

### UI and Browser Work

```txt
/ui fix mobile navbar
```

```txt
/frontend improve checkout loading states
```

### Security

```txt
/security review auth, uploads, and API permissions
```

### Deployment

```txt
/deploy check nginx, pm2, ssl, health check, and rollback
```

### Docs and Research

```txt
/docs check latest OpenWA docs
```

### Refactor

```txt
/refactor simplify dashboard data loading
```

### Testing

```txt
/test add regression coverage for user registration
```

### Combine Skills

```txt
/use debugging security
```

```txt
/use frontend-ui testing
/find-skill whatsapp automation
```

### Missing Skill

```txt
/find-skill whatsapp automation
```

The router should check local skills first. If none match, use `find-skills` to search `https://skills.sh/` or run `npx skills find [query]` when available. Ask before installing external skills.

### Session Modes

```txt
/mode strict
/mode frontend
/mode security
/mode production
/mode reset
```

## 8. Antigravity

Open the project in Antigravity and type commands in the agent panel.

Debugging:

```txt
/bug

Error:
[paste error]
```

UI/browser work:

```txt
/ui fix mobile navbar
```

Frontend session:

```txt
/mode frontend
```

Security plus debugging:

```txt
/use debugging security
```

Antigravity should create a short plan before editing, verify UI work in browser when possible, provide screenshot/artifact when possible, run verification commands where possible, and ask before destructive actions.

## 9. Goal Tracking Framework

Before starting:
1. Define the goal.
2. Define done criteria.
3. Confirm scope.
4. Note constraints.

During work:
- Create a checklist for non-trivial tasks.
- Track progress.
- Verify each meaningful step when practical.

Before finishing:
- Run verification commands.
- Confirm checklist items are complete.
- Document remaining risks.

## 10. Skill Chaining

Many tasks require multiple skills:

```txt
New feature -> feature-implementation, plus frontend-ui or api-design when needed
Bug/broken -> debugging, plus testing when useful
Review code -> code-review
Optimize -> performance-optimization
Database work -> database-migration
Deploy -> devops-deploy, often plus security-audit
Security concern -> security-audit
Current docs/API/library behavior -> docs-research
Missing skill or installable workflow -> find-skills
```

Command examples:

```txt
/fix add user authentication
/use frontend-ui testing
/find-skill whatsapp automation
/use devops-deploy security-audit
```

## 11. Fallback Manual Instruction

Use this only when an agent ignores slash commands:

```txt
Treat /bug, /review, /fix, /ui, /security, /deploy, /docs, /refactor, /test, /use, /mode, and /help as workflow commands using the AGENTS.md command router.
```

Then continue with short commands like:

```txt
/bug
/ui fix mobile navbar
/mode frontend
/use debugging security
```

## 12. Update Kit

Main system:

```bash
cd ~/universal-agent-kit
git add .
git commit -m "Improve command router"
git push
```

Other systems:

```bash
cd ~/universal-agent-kit
git pull
bash install-global-agent-kit.sh
```

## Final Rule

```txt
Install once per system.
Run agent-init once per project.
Inside the agent, use /bug, /ui, /mode, /use, and the rest of the command router.
```
