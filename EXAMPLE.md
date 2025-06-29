# 🎨 Colorful Hello World Template

This is a comprehensive Python service template that creates a beautiful, colorful Hello World application with extensive testing, fixtures, and pytest configuration.

## 🌟 What This Template Creates

### ✨ Features

- **Colorful Hello World App**: 4 different greeting styles (Simple, Fancy, Rainbow, Box)
- **Rich CLI Interface**: Built with Click and Rich for beautiful terminal output
- **Comprehensive Testing**: 80%+ coverage with unit, integration, and smoke tests
- **Pytest Configuration**: Fixtures, markers, conftest, and parametrized tests
- **Statistics Tracking**: Track and analyze greeting patterns
- **Color Utilities**: Predefined color palettes and utilities
- **Performance Testing**: Benchmarking and optimization
- **Type Safety**: Full type hints and mypy checking
- **Code Quality**: Automated formatting with Ruff and linting

### 🧪 Test Categories

The template includes comprehensive test markers:

- `unit`: Fast, isolated unit tests
- `integration`: Component interaction tests  
- `smoke`: Basic functionality validation
- `slow`: Performance and long-running tests
- `cli`: Command-line interface tests
- `utils`: Utility function tests
- `greeting`: Greeting generation tests
- `stats`: Statistics tracking tests
- `config`: Configuration management tests

## 🚀 Usage

### 1. Generate Project

```bash
# Install copier if you haven't already
pip install copier

# Generate new project from template
copier copy . my-hello-world-app

# Or from GitHub (if published)
copier copy gh:yourusername/template-python-service my-hello-world-app
```

### 2. Project Setup

```bash
cd my-hello-world-app

# Install dependencies
uv sync --dev

# Install pre-commit hooks
uv run pre-commit install

# Run the demo
python demo.py
```

### 3. Run Tests

```bash
# Run all tests
make test

# Run specific test categories
make test-unit          # Unit tests only
make test-integration   # Integration tests only
make test-smoke         # Smoke tests only
make test-cli           # CLI tests only
make test-quick         # Quick tests (smoke + unit)

# Run with specific options
./test.sh --verbose     # Verbose output
./test.sh --no-cov      # Without coverage
./test.sh -m "not slow" # Exclude slow tests
```

### 4. Use the Application

```bash
# Install the application
uv run pip install -e .

# Basic usage
my-hello-world-app hello
my-hello-world-app hello --name "Alice" --style fancy
my-hello-world-app hello --times 3 --animate

# Explore colors
my-hello-world-app colors --count 8

# Get info
my-hello-world-app info
```

## 📁 Generated Project Structure

```
my-hello-world-app/
├── src/my_hello_world_app/
│   ├── __init__.py          # Package exports
│   ├── cli.py               # Rich CLI interface  
│   ├── hello_world.py       # Core greeting logic
│   └── utils.py             # Utility functions
├── tests/
│   ├── conftest.py          # Pytest fixtures & config
│   ├── test_hello_world.py  # Core functionality tests
│   ├── test_cli.py          # CLI interface tests
│   ├── test_utils.py        # Utility function tests
│   └── test_integration.py  # Integration tests
├── demo.py                  # Interactive demo script
├── test.sh                  # Enhanced test runner
├── pyproject.toml           # Project configuration
├── pytest.ini              # Pytest configuration
├── Makefile                 # Development commands
└── README.md                # Comprehensive documentation
```

## 🧪 Testing Features

### Fixtures Available

```python
# Core fixtures
hello_generator          # HelloWorldGenerator instance
greeting_stats          # GreetingStats instance
color_utils            # ColorUtils class

# Parametrized fixtures  
greeting_style         # All GreetingStyle values
sample_name           # Various test names
sample_names          # List of test names
sample_styles         # All greeting styles

# Utility fixtures
mock_console          # Mocked Rich console
temp_config_dir       # Temporary config directory
config_file           # Pre-configured test file
performance_timer     # Performance measurement
cli_runner           # Click CLI test runner

# Test data fixtures
invalid_names         # Invalid name test cases
valid_names          # Valid name test cases
expected_greeting_patterns  # Expected output patterns
```

### Test Examples

```python
# Parametrized test
@pytest.mark.parametrize("style", list(GreetingStyle))
def test_all_greeting_styles(hello_generator, style):
    greeting = hello_generator.generate_greeting("Test", style)
    assert greeting is not None

# Using fixtures
def test_stats_tracking(greeting_stats, sample_names):
    for name in sample_names:
        greeting_stats.record_greeting(name, GreetingStyle.SIMPLE)
    
    stats = greeting_stats.get_stats()
    assert stats["total_greetings"] == len(sample_names)

# CLI testing
def test_cli_command(cli_runner):
    result = cli_runner.invoke(cli, ['hello', '--name', 'Test'])
    assert result.exit_code == 0
    assert "Test" in result.output

# Performance testing
@pytest.mark.slow
def test_performance(hello_generator, performance_timer):
    performance_timer.start()
    for i in range(1000):
        hello_generator.generate_greeting(f"User{i}", GreetingStyle.SIMPLE)
    performance_timer.stop()
    assert performance_timer.elapsed < 5.0
```

### Running Test Categories

```bash
# Quick validation
./test.sh --smoke

# Development workflow
./test.sh --unit --verbose

# Pre-commit checks
./test.sh --quick

# Full test suite
./test.sh

# Performance testing
./test.sh -m slow

# Exclude slow tests
./test.sh -m "not slow"

# Custom combinations
./test.sh -m "unit and not cli"
./test.sh -m "integration or smoke"
```

## 🎨 Application Demo

The generated project includes a `demo.py` script that showcases all features:

```bash
python demo.py
```

This interactive demo shows:
- All greeting styles with examples
- Color palette utilities
- Statistics tracking in action
- Performance benchmarking
- CLI command examples
- Application information

## 📊 Code Quality

The template includes comprehensive code quality tools:

```bash
# Format code
make format

# Lint and check
make lint

# Type checking
make type-check

# Security scanning  
make security

# All quality checks
make pre-commit
```

## 🔧 Customization

The template prompts for:
- `project_name`: Snake_case project name
- `project_description`: Short description
- `author_name`: Your full name
- `author_email`: Your email address
- `cli_name`: CLI command name (defaults to project-name)
- `python_version`: Python version (3.10-3.13)
- `license`: License type (MIT, Apache-2.0, etc.)

## 💡 Why This Template?

This template demonstrates best practices for:

1. **Testing**: Comprehensive pytest setup with fixtures, markers, and parametrization
2. **CLI Development**: Rich, colorful command-line interfaces
3. **Project Structure**: Clean, maintainable Python project layout
4. **Code Quality**: Automated formatting, linting, and type checking
5. **Performance**: Benchmarking and optimization techniques
6. **Documentation**: Clear, comprehensive documentation
7. **Developer Experience**: Easy setup and development workflow

Perfect for learning pytest, building CLI tools, or starting new Python projects with solid foundations.

## 🤝 Contributing

Feel free to enhance this template:
- Add more greeting styles
- Improve test coverage
- Add new CLI commands
- Enhance documentation

The template is designed to be educational and extensible!
