#!/bin/bash -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

echo_success() {
    echo -e "${GREEN}✓${NC} $1"
}

echo_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

echo_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if running in CI
if [[ "${CI:=}" == "true" ]]; then
    echo_info "Running in CI mode - checking code quality..."
    CHECK_MODE=true
else
    echo_info "Running in development mode - applying fixes..."
    CHECK_MODE=false
fi

# Run ruff format
echo_info "Checking Python code formatting..."
if [[ "$CHECK_MODE" == "true" ]]; then
    if uv run ruff format . --check --diff; then
        echo_success "Code formatting is correct"
    else
        echo_error "Code formatting issues found"
        exit 1
    fi
else
    echo_info "Applying code formatting..."
    uv run ruff format .
    echo_success "Code formatting applied"
fi

# Run ruff linter
echo_info "Running ruff linter..."
if uv run ruff check . --fix; then
    echo_success "Linting passed"
else
    echo_error "Linting issues found"
    exit 1
fi

# Run type checking
echo_info "Checking Python types with mypy..."
if uv run mypy src; then
    echo_success "Type checking passed"
else
    echo_error "Type checking failed"
    exit 1
fi

# Run security checks
echo_info "Running security checks with bandit..."
if uv run bandit -r src -f json -o bandit-report.json; then
    echo_success "Security checks passed"
else
    echo_warning "Security issues found - check bandit-report.json"
fi

echo_success "All linting checks completed!"