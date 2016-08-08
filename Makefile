include settings.mk

DOCKER=docker
SHELL=/bin/bash

LIST_FILTER=-f "label=owner=${CONTAINER_OWNER}" \
	-f "label=project=${CONTAINER_PROJECT}"
LIST_CONTAINER_CMD=${DOCKER} ps ${LIST_FILTER} -a
LIST_IMG_CMD=${DOCKER} images ${LIST_FILTER} -a

LIST_CONTAINER_IDS_CMD=${LIST_CONTAINER_CMD} -q
LIST_IMG_IDS_CMD=${LIST_IMG_CMD} -q

LIST_IMG_REPTAG_CMD=${LIST_IMG_CMD} --format {{.Repository}}:{{.Tag}}

build: Dockerfile settings.mk
	${DOCKER} build \
		-t "${CONTAINER_OWNER}/${CONTAINER_PROJECT}:${CONTAINER_VERSION}" \
		-t "${CONTAINER_OWNER}/${CONTAINER_PROJECT}:latest" \
		--label "owner=${CONTAINER_OWNER}" --label "project=${CONTAINER_PROJECT}" \
		.

clean-containers: settings.mk
	$(eval CONTAINERS=$(shell ${LIST_CONTAINER_IDS_CMD}))
	if [ -n "${CONTAINERS}" ]; then ${DOCKER} rm ${CONTAINERS}; \
	else echo "No containers to cleanup"; \
	fi

clean-images: settings.mk
	$(eval IMAGES=$(shell ${LIST_IMG_REPTAG_CMD}))
	if [ -n "${IMAGES}" ]; then ${DOCKER} rmi ${IMAGES}; \
	else echo "No images to cleanup"; \
	fi

clean: clean-containers clean-images

list: settings.mk
	$(LIST_IMG_CMD)

run: settings.mk
	${DOCKER} \
		run \
		-v ${CONTAINER_WORKDIR}:/home/research \
		-it ${CONTAINER_OWNER}/${CONTAINER_PROJECT}:latest \
		${SHELL}

tag: VERSION
	git tag $(shell cat VERSION)

.PHONY: build run
