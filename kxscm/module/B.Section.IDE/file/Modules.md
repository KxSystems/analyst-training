## Modules

- Modules can contain functions, data, files, inspections, transforms, and import configurations.
- Modules that do not start with a "." are within global 
- Modules that start with "." are in a namespace
- A namespace module can be accompanied by a ".test" module with the same prefix to enable "click-to-test"

## Repositories

- A repository is the top level for a group of version controlled entities
- A repository contains many modules and spreadsheets

## Loading on startup

A module can contain an "onLoad" function that will be run when the workspace loads.
See [automatic initialization](https://code.kx.com/analyst/faq/#automatic-initialization-when-loading-a-module)
for more information.
