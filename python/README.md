# openral-py

This package contains reusable components to work with openRAL in python projects. 
For more informations about openRAL see: https://open-ral.io/

## Installation

Test-Version
```bash
pip install --upgrade -i https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple/ openral-py
```


```bash
pip install openral-py
```

## Building blocks

### openral_py.RalObject

The `RalObject` class is the base class for all openRAL objects.
For more informations see: https://open-ral.io/docs

This class contains two methods:

* `from_map` - creates a new object from a map that you can get from a JSON string
* `to_map` - creates a map from the object that you can convert to a JSON string

### openral_py.repository.RalRepository

The `RalRepository` class is the base class for all openRAL repositories.
It provides a common interface to work with databases and other data sources that contain openRAL objects.
It's abstract, you can either implement it yourself or search for a concrete implementation in other packages at PyPI: https://pypi.org/search/?q=openRAL

You can use the `MockRalRepository` class for testing purposes.

### openral_py.discovery.Discovery

The `Discovery` class is a helper class to discover openRAL objects in a repository starting with a given RalObject.
It can be used to find all objects that are connected to the given RALObject.