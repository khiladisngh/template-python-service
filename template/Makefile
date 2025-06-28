.PHONY: help install test test-fast lint format type-check security clean build run docker-build docker-run

# Default target
help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

# Development setup
install: ## Install development dependencies
	uv sync --dev
	uv run pre-commit install
	uv run pre-commit install --hook-type commit-msg

# Testing
test: ## Run all tests with coverage
	./test.sh

test-fast: ## Run tests excluding slow ones
	./test.sh --fast

test-watch: ## Run tests in watch mode
	uv run pytest-watch

# Code quality
lint: ## Run all linting checks
	./lint.sh

format: ## Format code with ruff
	uv run ruff format .
	uv run ruff check . --fix

type-check: ## Run type checking with mypy
	uv run mypy src

security: ## Run security checks
	uv run bandit -r src
	uv run safety check

# Pre-commit
pre-commit: ## Run pre-commit hooks on all files
	uv run pre-commit run --all-files

pre-commit-update: ## Update pre-commit hooks
	uv run pre-commit autoupdate

# Build and package
clean: ## Clean build artifacts and cache
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf .pytest_cache/
	rm -rf .mypy_cache/
	rm -rf .ruff_cache/
	rm -rf htmlcov/
	rm -rf .coverage
	rm -rf coverage.xml
	find . -type d -name __pycache__ -delete
	find . -type f -name "*.pyc" -delete

build: clean ## Build distribution packages
	uv build

publish-test: build ## Publish to TestPyPI
	uv publish --repository testpypi

publish: build ## Publish to PyPI
	uv publish

# Running
run: ## Run the CLI application
	uv run {{ cli_name }} --help

run-dev: ## Run in development mode with verbose output
	uv run {{ cli_name }} -v hello --name "Developer"

# Docker
docker-build: ## Build Docker image
	docker build -t {{ project_name }}:latest .

docker-run: docker-build ## Run Docker container
	docker run --rm {{ project_name }}:latest

docker-dev: ## Start development environment with docker-compose
	docker-compose up -d

docker-dev-down: ## Stop development environment
	docker-compose down

# Version management
version-patch: ## Bump patch version
	uv run bumpversion patch

version-minor: ## Bump minor version
	uv run bumpversion minor

version-major: ## Bump major version
	uv run bumpversion major

# Documentation
docs-serve: ## Serve documentation locally
	@echo "📖 Future: Documentation server would start here"

# Development utilities
deps-update: ## Update dependencies
	uv lock --upgrade

deps-audit: ## Audit dependencies for security issues
	uv run safety check
	uv run pip-audit

check-all: lint type-check security test ## Run all quality checks

# CI/CD simulation
ci: clean install check-all build ## Simulate CI pipeline locally

# Environment info
info: ## Show environment information
	@echo "🐍 Python version: $(shell python --version)"
	@echo "📦 uv version: $(shell uv --version)"
	@echo "🔧 Project: {{ project_name }}"
	@echo "📍 Location: $(shell pwd)" 