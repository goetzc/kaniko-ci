VERSION = $(shell make version)
DOCKER_FILE = "Dockerfile.kaniko-ci"
DOCKER_REPOSITORY = "goetzc/kaniko-ci"
DOCKER_TAG_LATEST = ${DOCKER_REPOSITORY}:latest
DOCKER_TAG_VERSION = ${DOCKER_REPOSITORY}:${VERSION}

.PHONY: all
all: build git push

.PHONY: build
build:
	docker build . \
		--file ${DOCKER_FILE} \
		--tag ${DOCKER_TAG_LATEST} \
		--tag ${DOCKER_TAG_VERSION}

.PHONY: push
push:
	docker push . \
		--file ${DOCKER_FILE} \
		--tag ${DOCKER_TAG_LATEST} \
		--tag ${DOCKER_TAG_VERSION}

.PHONY: git
git: git_add git_commit

.PHONY: git_add
git_add:
	git add Makefile ${DOCKER_FILE}

.PHONY: git_commit
git_commit:
	git commit -m "Update to ${VERSION}"

.PHONY: version
version: VERSION = $(shell head -n 1 ${DOCKER_FILE} | cut -d ':' -f 2 | awk '{print $$1}' | tr -d 'v')
version:
	@echo ${VERSION}

