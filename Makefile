.PHONY: test validate install help version

VERSION := $(shell cat VERSION 2>/dev/null || echo "unknown")

help: ## Show this help
	@echo "Universal Agent Kit v$(VERSION)"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

test: ## Run test suite
	bash tests/run-tests.sh

validate: ## Validate all agent files
	bash scripts/validate-agent-files.sh

install: ## Install globally
	bash install-global-agent-kit.sh

install-force: ## Force reinstall globally
	bash install-global-agent-kit.sh --force

uninstall: ## Uninstall globally
	bash install-global-agent-kit.sh --uninstall

version: ## Show version
	@echo "$(VERSION)"

init: ## Initialize current project (alias for agent-init)
	agent-init

sync: ## Sync agent context in current project
	bash scripts/sync-agent-context.sh .

clean: ## Remove test artifacts
	rm -rf /tmp/agent-kit-test-*
