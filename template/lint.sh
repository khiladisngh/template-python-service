#!/bin/bash -e
if [[ "${CI:=}" == "true" ]]; then
  echo "Checking Python code formatting has been applied..."
  ruff format . --check --diff
else
  echo "Applying code formatting..."
  ruff format .
fi

echo "Running ruff linter across source..."
ruff check src

echo "Running ruff linter across tests..."
ruff check tests

echo "Checking Python types with mypy..."
mypy src