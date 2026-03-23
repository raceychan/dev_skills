SHELL := /bin/bash

.PHONY: skills skills-dry-run help

help:
	@echo "Available targets:"
	@echo "  make skills         Migrate repo skills into the detected OpenClaw install"
	@echo "  make skills-dry-run Preview migration without changing files"

skills:
	./scripts/migrate-skills.sh

skills-dry-run:
	./scripts/migrate-skills.sh --dry-run
