"""Core business logic for {{ project_name }}."""

from typing import List


def main_logic(name: str, count: int = 1) -> str:
    """Main logic function that can be tested independently.

    Args:
        name: The name to greet
        count: Number of times to greet

    Returns:
        A greeting message

    Raises:
        ValueError: If count is negative
    """
    if count < 0:
        raise ValueError("Count must be non-negative")

    if count == 0:
        return "No greetings requested"

    greetings = [f"Hello, {name}!" for _ in range(count)]
    return " ".join(greetings)


def calculate_something(numbers: List[float]) -> float:
    """Example function that calculates the average of a list of numbers.

    Args:
        numbers: List of numbers to calculate average for

    Returns:
        The average of the numbers

    Raises:
        ValueError: If the list is empty
    """
    if not numbers:
        raise ValueError("Cannot calculate average of empty list")

    return sum(numbers) / len(numbers)
