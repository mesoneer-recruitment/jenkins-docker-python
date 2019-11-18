# Jenkins Docker Python

A Python Docker image built to be used by Jenkins pipeline (for jobs requiring Python runtime).

## Build

Use https://jenkins.ubitec.io/view/docs/job/jenkins-docker-python to build Docker image, versioning by [SemVer](https://semver.org/).

## Why

The public Docker image `python:x.y.z` provided by Docker Hub cannot work well with ubitec's Jenkins Pipeline:

- Jenkins' automatically uses its users (as of now `jenkins:jenkins` or `3000:3000`) as the runtime user for the Docker container. This make some tasks like installing `pip` packages failed because of permissions.
- The user `jenkins` does not have a `home` also lead to failure to installing packages.

This Docker image address the issues by explictly create a user and a assign a home directory. So `pip` packages can be installed using `pip install --user` to work around permission issue.
