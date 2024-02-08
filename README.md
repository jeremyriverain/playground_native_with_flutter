# Playground Native With Flutter

## Prerequisites

Flutter is correctly installed on your machine, and up to date.

Activate [melos](https://melos.invertase.dev/) globally, which manage the monorepo.

```bash
dart pub global activate melos
```

## Usage

There is several demos. Each one showcases differents mechanisms that allow Flutter to interact with native code.

### MethodChannel

| Directory           | Platform | Usage                                              |
| ------------------- | -------- | -------------------------------------------------- |
| `apps/batterylevel` | iOS      | `melos exec --scope="batterylevel" -- flutter run` |
