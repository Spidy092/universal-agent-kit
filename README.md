# Universal Agent Kit v2.0.0

Reusable setup for Codex, OpenCode, Claude Code, Pi, Hermes, Gemini, Antigravity, and custom AI agents.

## Why?

Do not create separate workflow systems for every coding agent. Use one kit, one router, one set of skills, and the same commands everywhere.

## Effective Workflow

1. Install once per system:

```bash
git clone https://github.com/YOUR_USERNAME/universal-agent-kit.git ~/universal-agent-kit
cd ~/universal-agent-kit
bash install-global-agent-kit.sh
```

2. Run once per project:

```bash
cd /path/to/your/project
agent-init
```

3. Open any coding agent:

```bash
codex
claude
opencode
pi
hermes
gemini
antigravity
```

4. Inside the agent, use commands:

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

The user should not need to paste long setup prompts for normal work. If an agent does not natively support slash commands, `AGENTS.md` teaches it to treat `/bug`, `/ui`, `/mode frontend`, and similar inputs as workflow commands.

## How It Works

- `AGENTS.md` is the command router and source of truth for repo-wide behavior.
- `.agents/skills` contains reusable workflows such as debugging, frontend UI, security audit, testing, and deployment.
- `.agents/commands` contains command definitions for `/bug`, `/review`, `/fix`, `/ui`, `/security`, `/deploy`, `/docs`, `/refactor`, `/test`, `/use`, `/mode`, and `/help`.
- `.agents/modes` contains session-wide behavior such as `strict`, `frontend`, `security`, `production`, and `fast`.
- Agent adapters make the same router work across Codex, Claude Code, OpenCode, Pi, Hermes, Gemini, Antigravity, and custom agents.

## What's Included

### 14 Reusable Skills

| Skill | Purpose |
|-------|---------|
| `debugging` | Root-cause bug fixing with hypothesis elimination |
| `code-review` | PR/diff review with severity classification |
| `testing` | Test design, coverage, regression cases |
| `refactor` | Cleanup without behavior change |
| `devops-deploy` | Server, CI/CD, Docker, PM2, Nginx, SSL |
| `security-audit` | Auth, secrets, injection, CSRF, SSRF review |
| `frontend-ui` | Responsive UI, accessibility, states |
| `api-design` | REST/GraphQL API design and versioning |
| `database-migration` | Safe schema changes with rollback |
| `performance-optimization` | Profiling, bottlenecks, optimization |
| `docs-research` | Official docs verification |
| `rtk-prompting` | Structured Role-Task-Knowledge prompting |
| `caveman-fast-fix` | Quick fixes when speed matters |
| `find-skills` | Discover external skills when no local workflow matches |

### 12 In-Agent Commands

| Command | Purpose |
|---------|---------|
| `/bug`, `/debug` | Debug errors, logs, regressions, and failing builds |
| `/review` | Review diffs and PRs |
| `/fix <task>` | Make a structured fix with relevant skills auto-added |
| `/ui`, `/frontend` | UI, responsive layout, accessibility, and browser work |
| `/security` | Security audit and security-sensitive fixes |
| `/deploy`, `/devops` | Deployment, server, CI/CD, SSL, rollback |
| `/docs`, `/research` | Check current official docs and APIs |
| `/refactor` | Behavior-preserving cleanup |
| `/test` | Test strategy and regression coverage |
| `/use <skills>` | Combine named skills |
| `/mode <mode>` | Activate session-wide behavior |
| `/find-skill`, `/skills find` | Search for an external skill when the kit does not have one |
| `/help` | Show commands and modes |

### 8 Agent Adapters

- **Claude Code** - `CLAUDE.md` + `.claude/agents/*.md`
- **Codex** - `.codex/agents/*.toml` + configurable model
- **OpenCode** - `.opencode/agents/*.md`
- **Pi** - `.pi/APPEND_SYSTEM.md`
- **Hermes** - `~/.hermes/SOUL.md`
- **Gemini** - `.gemini/settings.json` + `GEMINI.md`
- **Antigravity** - `.antigravity/instructions.md` + `ANTIGRAVITY.md`
- **Custom** - `.agents/skills`, `.agents/commands`, and `.agents/modes`

### CLI Commands

```bash
agent-init              # Initialize project
agent-init --help       # Show help
agent-init --version    # Show version
agent-init --dry-run    # Preview changes
agent-init --rollback   # Undo initialization
agent-init --force      # Reinitialize (overwrite)

agent-kit-update /path  # Update global kit
```

### Makefile Targets

```bash
make help          # Show available targets
make test          # Run test suite
make validate      # Validate all files
make install       # Install globally
make install-force # Force reinstall
make uninstall     # Remove global installation
make version       # Show version
```

## Project Structure

```txt
universal-agent-kit/
├── AGENTS.md                    # Universal command router and rules
├── CLAUDE.md                    # Claude adapter
├── GEMINI.md                    # Gemini adapter
├── ANTIGRAVITY.md               # Antigravity adapter
├── README.md                    # This file
├── USAGE_GUIDE.md               # Detailed usage guide
├── install-global-agent-kit.sh  # Global installer
├── .agents/
│   ├── commands/                # In-agent command definitions
│   ├── modes/                   # Session-wide behavior modes
│   ├── skills/                  # Reusable workflows
│   └── prompt-packs/            # Prompt templates and fallbacks
├── .claude/agents/              # Claude subagents
├── .codex/                      # Codex config and agents
├── .opencode/agents/            # OpenCode agents
├── .pi/                         # Pi adapter
├── .gemini/                     # Gemini config
├── .antigravity/                # Antigravity adapter
├── templates/                   # Environment templates
├── scripts/                     # Sync and validation scripts
└── tests/                       # Test suite
```

## Missing Skill Fallback

If the local kit does not have the right skill, use:

```txt
/find-skill <topic>
```

The router uses `find-skills` to check local skills first, then search `skills.sh` or the Skills CLI. It should verify quality and ask before installing anything.

The public find-skills package can be installed with:

```bash
npx skills add https://github.com/vercel-labs/skills --skill find-skills
```

## Fallback Manual Prompt

Use this only when an agent ignores slash commands:

```txt
Treat /bug, /review, /fix, /ui, /security, /deploy, /docs, /refactor, /test, /use, /mode, and /help as workflow commands using the AGENTS.md command router.
```

## Configuration

### Codex Model Selection

Edit `.codex/config.toml`:

```toml
default_model = "gpt-5.5-thinking"
default_reasoning_effort = "high"
```

Override per-agent in `.codex/agents/*.toml`:

```toml
model = "gpt-4o"
```

### Custom Skills

Add your own:

```bash
mkdir -p .agents/skills/my-skill
cat > .agents/skills/my-skill/SKILL.md <<EOF
---
name: my-skill
version: 1.0.0
description: What this skill does.
---
# My Skill
...
EOF
```

## Testing

```bash
make test
bash tests/run-tests.sh
make validate
```

## Updating

```bash
cd ~/universal-agent-kit
git add . && git commit -m "Update" && git push

cd ~/universal-agent-kit
git pull
make install-force
```

## License

MIT

## Credits

Built by BhaivaTech for multi-agent AI workflows.
