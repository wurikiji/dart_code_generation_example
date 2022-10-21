> [ko](./README.md)

# Dart Code Generation

> Presented in devfest 2022, GDG Songdo

This repository contains examples of using Dart's build system to generate code.

## How to run examples

You need to install [melos](https://melos.invertase.dev/getting-started) first.

```bash
# You can skip the first command if you installed melos already
$> dart pub global activate melos # or follow the instructions from the link above
$> melos test
```

## Directory structure

- `packages`: all packages are located in this directory.
  - `packages/annotations`: contains annotations used in the examples.
  - `packages/generators`: contains code generators used in the examples.
