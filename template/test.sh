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

# Default test options
FAST_MODE=false
COVERAGE_REPORT=true
VERBOSE=false
MARKERS=""
QUICK=false

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --fast)
            FAST_MODE=true
            shift
            ;;
        --no-cov)
            COVERAGE_REPORT=false
            shift
            ;;
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        -m|--markers)
            MARKERS="$2"
            shift 2
            ;;
        -q|--quick)
            QUICK=true
            MARKERS="smoke or unit"
            shift
            ;;
        --unit)
            MARKERS="unit"
            shift
            ;;
        --integration)
            MARKERS="integration"
            shift
            ;;
        --smoke)
            MARKERS="smoke"
            shift
            ;;
        --cli)
            MARKERS="cli"
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  --fast       Skip slow tests"
            echo "  --no-cov     Skip coverage reporting"
            echo "  -v, --verbose Verbose output"
            echo "  -m, --markers Run tests with specific markers"
            echo "  -q, --quick   Run only quick tests (smoke + unit)"
            echo "  --unit        Run only unit tests"
            echo "  --integration Run only integration tests"
            echo "  --smoke       Run only smoke tests"
            echo "  --cli         Run only CLI tests"
            echo "  -h, --help   Show this help message"
            echo ""
            echo "Examples:"
            echo "  $0                     # Run all tests"
            echo "  $0 --quick            # Run quick tests only"
            echo "  $0 --unit --verbose   # Run unit tests with verbose output"
            echo "  $0 -m 'not slow'      # Run all tests except slow ones"
            exit 0
            ;;
        *)
            echo_error "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Build pytest command
PYTEST_ARGS="tests"

if [[ "$VERBOSE" == "true" ]]; then
    PYTEST_ARGS="$PYTEST_ARGS -v"
fi

if [[ "$FAST_MODE" == "true" ]]; then
    PYTEST_ARGS="$PYTEST_ARGS -m 'not slow'"
    echo_info "Running tests in fast mode (skipping slow tests)..."
elif [[ -n "$MARKERS" ]]; then
    PYTEST_ARGS="$PYTEST_ARGS -m '$MARKERS'"
    echo_info "Running tests with markers: $MARKERS"
elif [[ "$QUICK" == "true" ]]; then
    echo_info "Running tests in quick mode (smoke + unit tests)..."
else
    echo_info "Running all tests..."
fi

if [[ "$COVERAGE_REPORT" == "false" ]]; then
    PYTEST_ARGS="$PYTEST_ARGS --no-cov"
fi

# Run tests
echo_info "Executing: uv run python -m pytest $PYTEST_ARGS"

if uv run python -m pytest $PYTEST_ARGS; then
    echo_success "All tests passed!"
else
    echo_error "Some tests failed!"
    exit 1
fi

# Show coverage report if generated
if [[ "$COVERAGE_REPORT" == "true" ]] && [[ -f "htmlcov/index.html" ]]; then
    echo_info "Coverage report generated: htmlcov/index.html"
fi