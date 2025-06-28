"""Pytest configuration and common fixtures."""

import pytest


@pytest.fixture
def sample_data():
    """Sample data for testing."""
    return {
        "numbers": [1.0, 2.0, 3.0, 4.0, 5.0],
        "names": ["Alice", "Bob", "Charlie"],
        "config": {"verbose": True, "debug": False},
    }


@pytest.fixture
def temp_file(tmp_path):
    """Create a temporary file for testing."""
    file_path = tmp_path / "test_file.txt"
    file_path.write_text("Hello, test!")
    return file_path
