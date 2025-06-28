## Python service repository template

[Copier](https://copier.readthedocs.io/en/stable/) template for Python services.

### Instantiating the template

To run this, you need to be an environment with the `copier` Python package
installed, for example through a virtualenv:
```bash
$ python -m venv .venv
$ source .venv/bin/activate
$ pip install copier
```

If you are running on a box with Rez installed and configured, you can initialise
an environment with copier with:
```bash
$ rez-env copier
```

Once you have copier installed, you can instantiate this template into a directory
with the following command. If the specified `output_dir` exists, it will apply
on to of the directory, creating any new files and updating any existing files.
If the folder doesn't yet exist it will be created.
```bash
$ copier copy git@github.com:redefineoriginals/rdo-template-python-service.git <output_dir>
```

For example, for a freshly created repository you would do:
```bash
$ cd <dev folder>/
$ git clone git@github.com:redefineoriginals/my-cool-new-repo.git
$ cd my-cool-new-repo/
$ rez-env copier -- copier copy git@github.com:redefineoriginals/rdo-template-python-service.git .
```

This will ask a series of questions that will be used to control the template
instantiation.

### Developer workflow: Dev Containers

The template is setup to support [Dev Containers](https://containers.dev/) in VS Code
out of the box.

To startup a configured VS Code instance within the development container, open the
folder in a regular instance, hit `CTRL + SHIFT + P` and search for the **"Dev Containers:
Rebuild and Reopen in Container"** command. This will build a container from the
`dev` stage in the Dockerfile, which will have the selected Python version, Poetry
installed, and all default dependencies installed into the environment with Poetry. The
container will have the local development folder mounted into the container, so you're
ready to start working!

### Installing dependencies

If your project requires an additional Python dependency, it can be installed for
the project with:
```bash
$ poetry add <package_requirement>
e.g
$ poetry add Jinja2
```
This will add the package requirement to the `pyproject.toml` file, and update the
`poetry.lock` to include the new resolved version. For more information on how to
specify the package requirement, please see:
https://python-poetry.org/docs/dependency-specification/


### Testing

To run the linting and unit tests, you can run:
```bash
$ poetry run ./lint.sh
$ poetry run ./test.sh
```
