# Jenkins Docker Python

A Python Docker image built to be used by Jenkins pipeline (for jobs requiring Python runtime).

This repository is the source of DockerHub's [ubitecag/jenkins-docker-python](https://hub.docker.com/r/ubitecag/jenkins-docker-python).

## Build

The repository builds Docker images via GitHub Actions. The `.github/workflows` defines all the workflows used for this repository.

## Versioning

Versioning by [SemVer](https://semver.org/). The version is put in the plain text file `VERSION`.

## Distros

This repository is also built into several Docker images distinguished by the `tag`.

### Base

The images tagged with `base-x.y.z` contains only the Python runtime.

### MkDocs

The images tagged with `mkdocs-x.y.z` has `mkdocs`, `mkdocs-material` and `pymdown-extensions` installed. The image is used for building documents.

## Why

The public Docker image `python:x.y.z` provided by Docker Hub cannot work well with ubitec's Jenkins Pipeline:

- Jenkins' automatically uses its users (as of now `jenkins:jenkins` or `3000:3000`) as the runtime user for the Docker container. This make some tasks like installing `pip` packages failed because of permissions.
- The user `jenkins` does not have a `home` also lead to failure to installing packages.

This Docker image address the issues by explictly create a user and a assign a home directory. So `pip` packages can be installed using `pip install --user` to work around permission issue.
