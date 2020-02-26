# elm-test-docker

Docker image for Elm Test.

## Requirements

- Docker
- Docker Compose (optional)

## Installation

```console
$ docker pull aminnairi/elm-test
```

## Uninstallation

```console
$ docker rmi aminnairi/elm-test
```

## Usage

```console
$ docker run aminnairi/elm-test --version
```

## Examples

### Create the tests folder

```console
$ docker run --volume "$(pwd)":/home/elm/app aminnairi/elm-test init
```

### Run the test files

```console
$ docker run --volume "$(pwd)":/home/elm/app aminnairi/elm-test tests/**/*.elm
```

### More options

```console
$ docker run aminnairi/elm-test --help
```
