## Modern Python CLI Application Template

A [Copier](https://copier.readthedocs.io/en/stable/) template for creating modern, production-ready Python CLI applications.

### ✨ Features

- 🎨 **Rich CLI Application**: Beautiful, colorful Hello World app with 4 greeting styles
- 🧪 **Comprehensive Testing**: 80%+ coverage with unit, integration, smoke tests
- 📋 **Pytest Excellence**: Fixtures, markers, conftest, parametrized tests
- ⚡ **Modern Tooling**: Uses [uv](https://docs.astral.sh/uv/) for blazing-fast dependency management
- 🎨 **Code Quality**: Comprehensive setup with ruff, mypy, and pre-commit hooks
- 🔒 **Security**: Built-in security scanning with bandit and safety
- 🐳 **Containerization**: Docker support with optimized multi-stage builds
- 🚀 **CI/CD**: GitHub Actions workflows for comprehensive testing and deployment
- 📦 **Modern Python**: Support for Python 3.10+ with modern packaging standards
- 🪝 **Developer Experience**: Pre-commit hooks, dev containers, and comprehensive documentation

### 🏗️ What You Get

The template generates a complete project structure with:

```
your-hello-world-app/
├── src/your_app/           # Colorful Hello World application
│   ├── cli.py             # Rich CLI with 4 greeting styles
│   ├── hello_world.py     # Core greeting logic & statistics
│   └── utils.py           # Color utilities & config management
├── tests/                  # Comprehensive test suite (80%+ coverage)
│   ├── conftest.py        # Pytest fixtures & markers
│   ├── test_hello_world.py # Core functionality tests
│   ├── test_cli.py        # CLI interface tests
│   ├── test_utils.py      # Utility function tests
│   └── test_integration.py # Integration tests
├── demo.py                # Interactive demo script
├── .github/workflows/      # CI/CD pipelines
├── .devcontainer/          # Dev container configuration
├── Configuration files:
│   ├── pyproject.toml      # Project metadata with rich/click deps
│   ├── ruff.toml          # Linting and formatting
│   ├── pytest.ini        # Test configuration with markers
│   ├── mypy.ini           # Type checking
│   ├── .coveragerc        # Coverage settings
│   └── .pre-commit-config.yaml  # Git hooks
├── test.sh               # Enhanced test runner with categories
├── Dockerfile             # Production container
├── docker-compose.yml     # Development environment
├── Makefile              # Development commands
└── README.md             # Comprehensive documentation
```

### 🎨 Example Application

The template creates a beautiful, colorful Hello World application featuring:

- **4 Greeting Styles**: Simple, Fancy, Rainbow, and Box styles
- **Color Utilities**: Rich color palettes and utilities
- **Statistics Tracking**: Track and analyze greeting patterns
- **Performance Testing**: Benchmarking and optimization
- **Interactive Demo**: Run `python demo.py` to see all features

See [EXAMPLE.md](EXAMPLE.md) for detailed information about the generated application.

### 🚀 Quick Start

#### Prerequisites

- Python 3.10+
- [uv](https://docs.astral.sh/uv/) for dependency management
- [Copier](https://copier.readthedocs.io/en/stable/) for template instantiation

#### Installation

1. **Install Copier:**
   ```bash
   # Using uv (recommended)
   uv tool install copier

   # Or using pip
   pip install copier
   ```

2. **Create a new project:**
   ```bash
   copier copy https://github.com/your-username/template-python-service.git my-awesome-cli
   cd my-awesome-cli
   ```

3. **Set up the development environment:**
   ```bash
   make install
   ```

4. **Run your CLI application:**
   ```bash
   uv run my-awesome-cli --help
   ```

### 📝 Template Questions

The template will ask you several questions to customize your project:

- **Project name**: Snake_case name for your package
- **Project description**: Brief description of your CLI application
- **Author information**: Your name and email
- **CLI name**: The command name (defaults to kebab-case of project name)
- **Python version**: Choose from 3.10, 3.11, 3.12, or 3.13
- **License**: MIT, Apache-2.0, GPL-3.0, BSD-3-Clause, or None

### 🛠️ Development Workflow

Once your project is created, you'll have access to these commands:

```bash
# Development setup
make install              # Install all dependencies and hooks

# Code quality
make lint                 # Run all linting checks
make format               # Auto-format code
make type-check           # Run type checking
make security             # Run security scans

# Testing
make test                 # Run all tests with coverage
make test-fast            # Skip slow tests
./test.sh --help          # See all test options

# Building and deployment
make build                # Build distribution packages
make docker-build         # Build Docker image
make ci                   # Simulate full CI pipeline

# Version management
make version-patch        # Bump patch version
make version-minor        # Bump minor version
make version-major        # Bump major version
```

### 🔧 Key Technologies

- **[uv](https://docs.astral.sh/uv/)**: Ultra-fast Python package manager
- **[Click](https://click.palletsprojects.com/)**: Python CLI framework
- **[Rich](https://rich.readthedocs.io/)**: Beautiful terminal formatting
- **[Ruff](https://docs.astral.sh/ruff/)**: Extremely fast Python linter and formatter
- **[pytest](https://pytest.org/)**: Testing framework with comprehensive plugins
- **[mypy](https://mypy-lang.org/)**: Static type checking
- **[pre-commit](https://pre-commit.com/)**: Git hook framework
- **[GitHub Actions](https://github.com/features/actions)**: CI/CD pipelines

### 🐳 Container Support

The template includes optimized Docker support:

- **Multi-stage builds**: Efficient production images
- **Non-root user**: Security best practices
- **Health checks**: Container monitoring
- **Dev containers**: VS Code development environment

### 🤝 Contributing

This template is designed to be flexible and extensible. To contribute:

1. Fork the repository
2. Make your improvements
3. Test with `copier copy . test-output --data project_name=test`
4. Submit a pull request

### 📖 Documentation

Each generated project includes:

- Comprehensive README with usage examples
- API documentation setup
- Contributing guidelines
- Development workflow documentation
- Docker usage instructions

### 🔄 Template Updates

To update an existing project with template changes:

```bash
copier update
```

This will apply any template improvements while preserving your customizations.

### 📄 License

This template is released under the MIT License. Generated projects can use any license you choose during template instantiation.
