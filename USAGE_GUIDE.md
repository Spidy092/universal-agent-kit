# Universal Agent Kit — Usage Guide

## Mental model

Do not copy the full kit into every project manually.

Use this:

```txt
GitHub repo          = master copy of your agent kit
Each system/laptop   = clone once + install once
Each project         = run agent-init once
Each agent           = open project + say "Read AGENTS.md first"
```

## 1. Push the kit to GitHub

Create a private GitHub repo named:

```txt
universal-agent-kit
```

From your local kit folder:

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

## 2. Install on any system

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

## 3. Initialize any project

```bash
cd /path/to/project
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

Optional Antigravity setup:

```bash
cat > ANTIGRAVITY.md <<'EOF'
# Antigravity Project Instructions

Read AGENTS.md first.
Use shared skills from .agents/skills.

When a task matches a skill, use that skill:
- debugging
- code-review
- testing
- refactor
- devops-deploy
- security-audit
- frontend-ui
- docs-research
- rtk-prompting
- caveman-fast-fix

Safety:
- Do not delete files without asking.
- Do not reset database without asking.
- Do not run destructive terminal commands without asking.
- Do not expose .env, tokens, secrets, private keys, or credentials.
- Make the smallest safe change.
- Give exact verification commands.
EOF

mkdir -p .antigravity
cp ANTIGRAVITY.md .antigravity/instructions.md
```

## 4. Use with Codex

```bash
cd /path/to/project
codex
```

First message:

```txt
Read AGENTS.md first.
Use the matching skill from .agents/skills.
```

Debugging:

```txt
Read AGENTS.md.
Use debugging skill.

Error:
[paste error]

Find root cause, make smallest safe fix, and give verification commands.
```

Review:

```txt
Read AGENTS.md.
Use code-review skill.

Review the current diff.
Find blocking issues first.
```

## 5. Use with Claude Code

```bash
cd /path/to/project
claude
```

First message:

```txt
Read CLAUDE.md and AGENTS.md first.
Use the matching skill from .claude/skills or .agents/skills.
```

Debugging:

```txt
Use debugging skill.
Read the error fully.
Find root cause.
Make smallest safe fix.
Give exact command to test.

Error:
[paste error]
```

## 6. Use with OpenCode

```bash
cd /path/to/project
opencode
```

First message:

```txt
Read AGENTS.md first.
Use the matching skill from .agents/skills.
```

Serious task:

```txt
Read AGENTS.md.
Use rtk-prompting skill.

Role:
You are a senior full-stack developer.

Task:
[exact task]

Knowledge:
[project context]

Rules:
- Minimal safe change.
- Verify with commands.
- Mention edge cases.
```

## 7. Use with Pi

```bash
cd /path/to/project
pi
```

First message:

```txt
Read AGENTS.md.
Use .agents/skills.
If task matches a skill, load that skill before acting.
```

Force a skill:

```txt
/skill:debugging
[paste error]
```

## 8. Use with Hermes

```bash
cd /path/to/project
hermes
```

First message:

```txt
Read AGENTS.md first.
Use matching skills from .agents/skills.
```

Recommended:

```bash
mkdir -p ~/.hermes
cat > ~/.hermes/SOUL.md <<'EOF'
You are a senior software engineer.
Be direct, technical, and practical.
Prefer root-cause fixes, exact commands, and edge-case awareness.
Do not expose secrets.
Do not perform destructive actions without approval.
EOF
```

## 9. Use with Gemini CLI

Create settings:

```bash
mkdir -p .gemini

cat > .gemini/settings.json <<'EOF'
{
  "context": {
    "fileName": ["AGENTS.md", "GEMINI.md"]
  }
}
EOF
```

Run:

```bash
cd /path/to/project
gemini
```

First message:

```txt
Read AGENTS.md first.
Use .agents/skills when relevant.
```

## 10. Use with Antigravity

Open the project in Antigravity.

First message:

```txt
Read AGENTS.md and ANTIGRAVITY.md first.
Use the matching skill from .agents/skills.
Before editing, create a short plan.
Before destructive actions, ask me.
After changes, create verification artifacts.
```

Debugging:

```txt
Read AGENTS.md and ANTIGRAVITY.md.
Use debugging skill.

Error:
[paste error]

Find root cause, make smallest safe fix, run verification, and show artifacts.
```

UI/browser work:

```txt
Read AGENTS.md and ANTIGRAVITY.md.
Use frontend-ui skill.

Task:
[UI task]

Verify in browser and provide screenshot/artifact.
```

## 11. Daily prompts

Fast fix:

```txt
Read AGENTS.md.
Use caveman-fast-fix skill.

Fix this:
[paste error]

Give cause, fix, and command to test.
```

Serious implementation:

```txt
Read AGENTS.md.
Use rtk-prompting skill.

Role:
You are a senior backend developer.

Task:
[exact task]

Knowledge:
[stack, files, logs, constraints]

Rules:
- Read existing code first.
- Minimal safe change.
- No unrelated rewrite.
- Give commands to verify.

Output:
- Summary
- Files changed
- Commands
- Verification
- Edge cases
```

Deployment:

```txt
Read AGENTS.md.
Use devops-deploy skill.

Server:
[Ubuntu/AWS/VPS/etc.]

App:
[Node/PHP/Python/etc.]

Check:
env, ports, firewall, PM2/systemd/Docker, Nginx, SSL, logs, health check, rollback.
```

## 12. Update kit

Main system:

```bash
cd ~/universal-agent-kit
git add .
git commit -m "Improve agent skills"
git push
```

Other systems:

```bash
cd ~/universal-agent-kit
git pull
bash install-global-agent-kit.sh
```

## Final rule

```txt
Install once per system.
Run agent-init once per project.
Tell every agent: Read AGENTS.md first.
```
