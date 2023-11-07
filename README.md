# kaniko image build on top of Alpine

<img src="https://raw.githubusercontent.com/GoogleContainerTools/kaniko/master/logo/Kaniko-Logo.png" alt="kaniko-logo" width="700"/>

**kaniko** is a tool to build container images from a `Dockerfile`, inside a container or Kubernetes cluster. _kaniko_ doesn't depend on a Docker daemon and executes each command within a _Dockerfile_ completely in userspace. This enables building container images in environments that can't easily or securely run a Docker daemon, such as a standard Kubernetes cluster.

This image is recommended for usage within a Continues Integration and Deployment (CI/CD) environment, to build container images without a Docker engine (non-root user).
Build on top of Alpine using the official [kaniko](https://github.com/GoogleContainerTools/kaniko) executor from `gcr.io/kaniko-project/executor`.

Minimal environment with Kaniko executor:

- Based on latest Alpine stable image
- Includes Bash, Git and OpenSSH client

## Table of contents

<!-- toc -->

- [Example usage](#example-usage)
  - [Build a container image](#build-a-container-image)
- [Inspect the image](#inspect-the-image)

<!-- tocstop -->

## Example usage

### Build a container image

From inside the running Kaniko container:

```sh
# Set the registry token for push access
DOCKER_AUTH_TOKEN=<YOUR TOKEN>
echo "{\"auths\": {\"https://index.docker.io/v1/\": {\"auth\": \"$DOCKER_AUTH_TOKEN\"}}}" > /kaniko/.docker/config.json

# Build and push the resulting image
executor --context /src/app/ --destination <container-registry>/<container-repository>:latest
```

## Inspect the image

```sh
$ docker run --rm -it goetzc/kaniko-ci sh
$ docker history goetzc/kaniko-ci
```
