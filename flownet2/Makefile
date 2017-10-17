
.DEFAULT_GOAL := help

## The following must be adapted depending on where you put your data.
PATH_TO_WS=/usr/users/ims/benbihi_ass/ws/abenbihi/ws

IMAGE_NAME=flownet2

GPU?=0
DOCKER_FILE=Dockerfile
DOCKER=GPU=$(GPU) nvidia-docker
CEI_DIR=$(shell dirname `pwd`)
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

build:
	docker build -t $(IMAGE_NAME) -f $(DOCKER_FILE) --build-arg http_proxy=$(http_proxy) --build-arg https_proxy=$(https_proxy) --build-arg no_proxy=$(no_proxy) --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) .

bash: build
	$(DOCKER) run --volume="$(PATH_TO_WS)":/home/ws -u "$(USER_ID):$(GROUP_ID)" -it  $(IMAGE_NAME) bash

root: build
	$(DOCKER) run --volume="$(PATH_TO_WS)":/home/ws -it -u root $(IMAGE_NAME) bash

help:
	@echo "make bash : builds and runs the docker image as normal user"
	@echo "make root : builds and runs the docker image as ROOT user"


