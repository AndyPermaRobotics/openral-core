# How to deploy the package to PyPI

## Tipp: Use VS-Code Tasks

There are 2 tasks defined in `.vscode/tasks.json` to build and publish the package for test/production.

## Build package

Create a source distribution package with:
```bash
python setup.py sdist bdist_wheel
```

### Install package from local source distribution

```bash
pip install ./dist/open_ral_python-{current-version}.tar.gz
```

### Publish package to PyPI (https://pypi.org/)

```bash
twine upload ./dist/*
```

### Publish package to TestPyPI (https://test.pypi.org/)

```bash
twine upload --repository-url https://test.pypi.org/legacy/ dist/*
```

```bash
twine upload testpypi dist/*
```
-> if you configured a testpypi repository in your .pypirc file

### Install package from TestPyPI

```bash
python3 -m pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ openral-py  
```

`--extra-index-url https://pypi.org/simple/` is needed for dependencies that are not available on PyPI.