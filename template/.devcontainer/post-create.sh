#!/bin/bash

set -e

echo "[*] Setting up development environment..."
echo "[*] Current directory: $(pwd)"
echo "[*] Current user: $(whoami)"
echo "[*] Git version: $(git --version)"
echo "[*] UV version: $(/usr/local/bin/uv --version)"

# Ensure we're in the workspace directory - use the passed argument if available
if [ "$1" != "" ]; then
    WORKSPACE_DIR="$1"
elif [ "$VSCODE_WORKSPACE_FOLDER" != "" ]; then
    WORKSPACE_DIR="$VSCODE_WORKSPACE_FOLDER"
else
    # Stay in current directory if no workspace is specified
    WORKSPACE_DIR="$(pwd)"
fi

echo "[*] Target workspace directory: $WORKSPACE_DIR"
if [ -d "$WORKSPACE_DIR" ]; then
    cd "$WORKSPACE_DIR"
    echo "[*] Working in directory: $(pwd)"
else
    echo "[!] Workspace directory does not exist, staying in current directory: $(pwd)"
fi

# Install Oh My Zsh non-interactively if it's not already installed.
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "[*] Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh-autosuggestions plugin.
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "[*] Installing zsh-autosuggestions plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin.
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "[*] Installing zsh-syntax-highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

# Set up shell configuration for the vscode user (Starship is already installed in Dockerfile)
echo "[*] Setting up shell configuration..."
if ! grep -q "starship init bash" ~/.bashrc; then
    echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

if ! grep -q "starship init zsh" ~/.zshrc; then
    echo 'eval "$(starship init zsh)"' >> ~/.zshrc
fi

if ! grep -q "zoxide init bash" ~/.bashrc; then
    echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
fi

if ! grep -q "zoxide init zsh" ~/.zshrc; then
    echo 'eval "$(zoxide init zsh)"' >> ~/.zshrc
fi

# Install dependencies with uv (using full path since it may not be in PATH for vscode user)
echo "[*] Installing Python dependencies..."
export UV_LINK_MODE=copy
# Use cache mount optimization
export UV_CACHE_DIR=/home/vscode/.cache/uv
/usr/local/bin/uv sync --dev --locked

# Install pre-commit as a tool if not already available
echo "[*] Installing pre-commit tool..."
/usr/local/bin/uv tool install pre-commit --force || echo "pre-commit tool installation attempted"

# Verify uv installation worked
echo "[*] Verifying Python environment..."
/usr/local/bin/uv run python --version
/usr/local/bin/uv pip list | head -10

# Initialize git repository if not already initialized
if [ ! -d ".git" ]; then
    echo "[*] Initializing Git repository..."
    git init --initial-branch=main
    # Configure git user (needs to be done after git init)
    git config user.name "Gishant Singh"
    git config user.email "khiladisngh@hotmail.com"
    # Add initial commit to have a proper git repository
    touch .gitkeep
    git add .gitkeep
    git commit -m "Initial commit" || true
else
    echo "[*] Git repository already exists"
fi

# Verify git is working and we're in a git repository
echo "[*] Verifying git setup..."
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "[+] Git repository confirmed"
    git status --porcelain || echo "Git status check completed"
else
    echo "[!] Git repository verification failed"
    echo "Current directory: $(pwd)"
    echo "Directory contents:"
    ls -la
    echo "Git version: $(git --version)"
fi

# Install pre-commit hooks (only if we have a git repository)
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "[*] Installing pre-commit hooks..."
    
    # Try different approaches to install pre-commit hooks
    if /usr/local/bin/uv run pre-commit install; then
        echo "[+] Pre-commit hooks installed successfully with uv run"
    elif /usr/local/bin/uv tool run pre-commit install; then
        echo "[+] Pre-commit hooks installed successfully with uv tool run"
    else
        echo "[!] Failed to install pre-commit hooks"
        echo "Checking pre-commit availability:"
        /usr/local/bin/uv run which pre-commit || echo "pre-commit not found in uv run"
        /usr/local/bin/uv tool run which pre-commit || echo "pre-commit not found in uv tool run"
    fi
    
    # Install commit-msg hooks
    if /usr/local/bin/uv run pre-commit install --hook-type commit-msg; then
        echo "[+] Commit-msg hooks installed successfully with uv run"
    elif /usr/local/bin/uv tool run pre-commit install --hook-type commit-msg; then
        echo "[+] Commit-msg hooks installed successfully with uv tool run"
    else
        echo "[!] Failed to install commit-msg hooks"
    fi
    
    # Run initial setup
    echo "[*] Running initial setup..."
    if /usr/local/bin/uv run pre-commit run --all-files; then
        echo "[+] Initial pre-commit run completed successfully"
    elif /usr/local/bin/uv tool run pre-commit run --all-files; then
        echo "[+] Initial pre-commit run completed successfully with tool run"
    else
        echo "[!] Initial pre-commit run failed (this is normal for first run)"
    fi
else
    echo "[!] Skipping pre-commit setup - no Git repository found"
    echo "Current directory: $(pwd)"
    echo "Checking for .git directory: $(ls -la | grep git || echo 'No .git found')"
fi

# Create .secrets.baseline for detect-secrets
echo "[*] Setting up secrets detection baseline..."
if /usr/local/bin/uv run detect-secrets scan --baseline .secrets.baseline; then
    echo "[+] Secrets baseline created successfully"
else
    echo "[!] Failed to create secrets baseline"
    echo "Checking if detect-secrets is available:"
    /usr/local/bin/uv run python -c "import detect_secrets; print('detect-secrets is available')" || echo "detect-secrets is not installed or not available"
    echo "Available packages:"
    /usr/local/bin/uv pip list | grep -i detect || echo "detect-secrets not found in pip list"
fi

echo "[+] Development environment setup complete!"
echo ""
echo "[*] Quick commands:"
echo "  uv run my-cli-app --help        # Run the CLI"
echo "  ./test.sh                       # Run tests"
echo "  ./lint.sh                       # Run linting"
echo "  uv run pre-commit run --all-files  # Run all pre-commit hooks"