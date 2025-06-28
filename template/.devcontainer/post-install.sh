#!/bin/bash

set -e

echo "🚀 Setting up development environment..."

# Install dependencies with uv
echo "📦 Installing Python dependencies..."
uv sync --dev

# Install pre-commit hooks
echo "🪝 Installing pre-commit hooks..."
uv run pre-commit install
uv run pre-commit install --hook-type commit-msg

# Run initial setup
echo "🔧 Running initial setup..."
uv run pre-commit run --all-files || true

# Create .secrets.baseline for detect-secrets
echo "🔐 Setting up secrets detection baseline..."
uv run detect-secrets scan --baseline .secrets.baseline || true

echo "✅ Development environment setup complete!"
echo ""
echo "🎯 Quick commands:"
echo "  uv run {{ cli_name }} --help    # Run the CLI"
echo "  ./test.sh                       # Run tests"
echo "  ./lint.sh                       # Run linting"
echo "  uv run pre-commit run --all-files  # Run all pre-commit hooks"