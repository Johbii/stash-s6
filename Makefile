user=stashapp
repo=stash
tag=latest
export DOCKER_BUILDKIT=1

.PHONY: build-info
build-info:
ifndef BUILD_DATE
	$(eval BUILD_DATE := $(shell go run scripts/getDate.go))
endif
ifndef GITHASH
	$(eval GITHASH := $(shell git rev-parse --short HEAD))
endif
ifndef STASH_VERSION
	$(echo "STASHVERS")
endif
ifndef OFFICIAL_BUILD
	$(eval OFFICIAL_BUILD := false)
endif
ifndef DOCKER_BUILD_ARGS
	DOCKER_BUILD_ARGS = --build-arg BUILD_DATE="$(BUILD_DATE)" --build-arg GITHASH="$(GITHASH)" --build-arg STASH_VERSION="$(STASH_VERSION)" --build-arg OFFICIAL_BUILD="$(OFFICIAL_BUILD)"
endif

.PHONY: docker-alpine
docker-alpine:
	docker build ${DOCKER_BUILD_ARGS} --tag ${repo}:${tag}-alpine --file dockerfile/alpine.Dockerfile .
