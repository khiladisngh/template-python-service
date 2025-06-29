#!/bin/bash

set -e

echo "🚀 Setting up development environment..."

# Install Oh My Zsh non-interactively if it's not already installed.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh-autosuggestions plugin.
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin.
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

curl -sS https://starship.rs/install.sh | sh -s -- --yes

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