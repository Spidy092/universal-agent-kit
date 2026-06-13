#!/usr/bin/env bash
set -euo pipefail

if [ -x scripts/sync-agent-adapters.sh ]; then
  bash scripts/sync-agent-adapters.sh "$@"
else
  echo "ERROR: scripts/sync-agent-adapters.sh not found."
  exit 1
fi
