# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
#                    ★ CUSTOM ALIASES ★
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# --------------------------------------------------------------
# ► Shell & Convenience
# --------------------------------------------------------------
# Quick way to edit this file or the main zsh config
alias aliases="nano ~/.zsh_aliases"
alias zshconfig="nano ~/.zshrc"
# Reload the shell configuration
alias reload="source ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
# Clear the screen
alias c="clear"
# Shorter way to exit
alias q="exit"
# Show shell history with Atuin's powerful search
alias h="atuin search"


# --------------------------------------------------------------
# ► File & Directory Management (The "Beautiful" Aliases)
# --------------------------------------------------------------
# Replace 'ls' with 'eza' for modern, colorful, icon-rich output
alias ls='eza --icons --color=always --group-directories-first' # Basic ls
alias l='eza --icons --color=always --group-directories-first --all --header --long --git' # Detailed list (ls -la)
alias ll='eza --icons --color=always --group-directories-first --all --header --long --git' # ll is a common alternative for detailed list
alias la='eza --icons --color=always --group-directories-first --all' # List all files including hidden (ls -a)
alias l.='eza --icons --all --long --header --git --ignore-glob=".git" --color=always' # List everything in current dir, ignoring .git
# Sort by...
alias lt='l --sort=modified' # Sort by modification time (newest first)
alias lS='l --sort=size'    # Sort by size (largest first)
# Tree view
alias tree='eza --tree --level=2'
alias ltree='eza --tree --level=3'

# Replace 'cat' with 'bat' for syntax highlighting and Git gutter
alias cat='bat -p --theme="Dracula"' # Use '-p' to disable paging like original cat

# Replace 'find' with 'fd' for a faster, more user-friendly search
alias find='fd'

# Safer and more informative file operations
alias mv='mv -iv'      # Verbose and interactive move
alias cp='cp -iv'      # Verbose and interactive copy
alias rm='rm -I'       # Interactive delete for more than 3 files (safer!)

# Directory navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
# 'z' is already your 'smarter cd' via zoxide

# Create parent directories if they don't exist
alias mkdir='mkdir -p'


# --------------------------------------------------------------
# ► System & Package Management
# --------------------------------------------------------------
# System monitoring with btm (the modern htop)
alias top='btm'
alias htop='btm'
# Check disk space, human-readable
alias df='df -h'
# Check memory usage, human-readable
alias free='free -h'
# Get process list and grep it
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
# Make a file executable
alias mx='chmod +x'
# DNF aliases for faster package management
alias dnfi='sudo dnf install'
alias dnfs='sudo dnf search'
alias dnfr='sudo dnf remove'
alias dnfu='sudo dnf upgrade --refresh'


# --------------------------------------------------------------
# ► Git Aliases (Your Superpower)
# --------------------------------------------------------------
alias g='git'
# Status
alias gs='git status'
alias gss='git status -s' # Short status
# Logging - The "beautiful" history
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glog="git log --oneline --decorate --graph --all" # Another beautiful graph log
# Branching
alias gb='git branch'
alias gba='git branch -a'
alias gco='git checkout'
alias gcb='git checkout -b' # Create and checkout new branch
alias gsw='git switch' # Modern alternative to checkout
alias gsc='git switch -c' # Modern alternative to checkout -b
# Adding & Committing
alias ga='git add'
alias gaa='git add -A' # Add all changes
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit --amend'
# Pushing, Pulling, Fetching
alias gp='git push'
alias gpf='git push --force-with-lease' # Safer force push
alias gpl='git pull'
alias gf='git fetch'
# Stashing
alias gsta='git stash'
alias gstp='git stash pop'
alias gstd='git stash drop'
# Remotes
alias gr='git remote -v'


# --------------------------------------------------------------
# ► Networking
# --------------------------------------------------------------
# Get local and public IP addresses
alias myip="echo 'Local IP:'; ip a | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}'; echo 'Public IP:'; curl -s ifconfig.me"
# Ping with a limited count
alias ping='ping -c 5'


# --------------------------------------------------------------
# ► Development & Docker
# --------------------------------------------------------------
# Docker
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dstopall='docker stop $(docker ps -aq)'
alias drmall='docker rm $(docker ps -aq)'
alias diprune='docker image prune -a'
# Docker Compose
alias dc='docker-compose'
alias dcu='docker-compose up -d'
alias dcd='docker-compose down'
alias dcr='docker-compose restart'
alias dcl='docker-compose logs -f'