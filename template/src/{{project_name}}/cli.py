"""Command line interface for {{ project_name }}."""

import sys
from typing import Optional

import click
from rich.console import Console
from rich.traceback import install

from . import __version__
from .core import main_logic

# Install rich traceback handler for better error formatting
install(show_locals=True)

# Create console for rich output
console = Console()


@click.group(
    invoke_without_command=True,
    context_settings={"help_option_names": ["-h", "--help"]},
)
@click.version_option(
    version=__version__,
    prog_name="{{ project_name }}",
    message="%(prog)s %(version)s",
)
@click.option(
    "-v",
    "--verbose",
    count=True,
    help="Increase verbosity (can be used multiple times)",
)
@click.pass_context
def cli(ctx: click.Context, verbose: int) -> None:
    """{{ project_description }}

    Run '{{ cli_name }} --help' to see available commands.
    """
    # Ensure that ctx.obj exists and is a dict
    ctx.ensure_object(dict)
    ctx.obj["verbose"] = verbose

    # If no subcommand is provided, show help
    if ctx.invoked_subcommand is None:
        click.echo(ctx.get_help())


@cli.command()
@click.option(
    "--name",
    "-n",
    default="World",
    help="Name to greet",
    show_default=True,
)
@click.option(
    "--count",
    "-c",
    default=1,
    help="Number of greetings",
    show_default=True,
)
@click.pass_context
def hello(ctx: click.Context, name: str, count: int) -> None:
    """Greet someone with a friendly message."""
    verbose = ctx.obj.get("verbose", 0)

    if verbose > 0:
        console.print(f"[dim]Verbose mode: {verbose}[/dim]")

    try:
        result = main_logic(name, count)
        console.print(f"[green]{result}[/green]")
    except Exception as e:
        console.print(f"[red]Error: {e}[/red]")
        if verbose > 0:
            console.print_exception()
        sys.exit(1)


@cli.command()
@click.pass_context
def version(ctx: click.Context) -> None:
    """Show version information."""
    console.print(f"[bold]{{ project_name }}[/bold] version [cyan]{__version__}[/cyan]")


def main() -> None:
    """Main entry point for the CLI application."""
    try:
        cli()
    except KeyboardInterrupt:
        console.print("\n[yellow]Interrupted by user[/yellow]")
        sys.exit(130)
    except Exception as e:
        console.print(f"[red]Unexpected error: {e}[/red]")
        sys.exit(1)


if __name__ == "__main__":
    main()
