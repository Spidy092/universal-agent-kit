#!/usr/bin/env bash
set -euo pipefail

test -f AGENTS.md || { echo "Missing AGENTS.md"; exit 1; }
test -f CLAUDE.md || { echo "Missing CLAUDE.md"; exit 1; }
test -d .agents/skills || { echo "Missing .agents/skills"; exit 1; }

missing=0
while IFS= read -r f; do
  grep -q '^name:' "$f" || { echo "Missing name frontmatter in $f"; missing=1; }
  grep -q '^description:' "$f" || { echo "Missing description frontmatter in $f"; missing=1; }
done < <(find .agents/skills -mindepth 2 -maxdepth 2 -name SKILL.md | sort)

if [ "$missing" -ne 0 ]; then exit 1; fi

required=(debugging code-review testing refactor devops-deploy security-audit frontend-ui docs-research rtk-prompting caveman-fast-fix)
for s in "${required[@]}"; do
  test -f ".agents/skills/$s/SKILL.md" || { echo "Missing skill: $s"; exit 1; }
done

echo "Agent files valid."
