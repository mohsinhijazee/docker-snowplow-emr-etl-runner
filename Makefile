SHELL = /bin/bash
IMAGE_NAME ?= dubizzledotcom/emr-etl-runner
IMAGE_VERSION ?= 0.0.1

.PHONY: docker

docker:
		docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .
