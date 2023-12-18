# https://hub.docker.com/r/goetzc/kaniko-ci
# https://github.com/GoogleContainerTools/kaniko

FROM gcr.io/kaniko-project/executor:v1.19.1 as kaniko

FROM alpine:3.15

ENV DOCKER_CONFIG=/kaniko/.docker
ENV PATH=/kaniko:$PATH
ENV SSL_CERT_DIR=/kaniko/ssl/certs

# hadolint ignore=DL3018
RUN apk add --no-cache \
  bash \
  git \
  openssh-client

# hadolint ignore=DL3059
RUN mkdir -p $SSL_CERT_DIR ~/.ssh

COPY --from=kaniko /kaniko/executor /kaniko/
COPY --from=kaniko /kaniko/.docker/ /kaniko/.docker/
