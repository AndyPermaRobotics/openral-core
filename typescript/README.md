# openRAL Core package

Javascript and Typescript package that contains the core functionality to work with the openRAL.

For more informations about the openRAL please visit the [openRAL website](https://open-ral.io).

## Installation

```bash
npm install @openral/core
```

## Notes about the architecture

### Why do you use classes instead of interfaces for the models?

The syntax for defining models with interfaces is lightweight, but it has some drawbacks. 
Instead of using interfaces, we use TypeScript classes to define our models. This is because our models not only represent data structures but may also contain some methods that work with the data.

Using classes allows us to validate the input data in the constructor beyond the type system. 
This validation can be done during runtime in the transpiled JavaScript code as well, which is crucial for parsing JSON data securly.
