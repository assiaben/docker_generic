
.DEFAULT_GOAL := help

# TODO
IMAGE_NAME=baselines
## The following must be adapted depending on where you put your data.
EXTERNAL_PATH_TO_WS=/opt/BenbihiAssia/baselines/# path in your server
LOCAL_PATH_TO_WS=/root/code/baselines# Path in your image

GPU?=0
DOCKER_FILE=Dockerfile
DOCKER=GPU=$(GPU) nvidia-docker
CEI_DIR=$(shell dirname `pwd`)
USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)

build:
	docker build -t $(IMAGE_NAME) -f $(DOCKER_FILE) --build-arg http_proxy=$(http_proxy) --build-arg https_proxy=$(https_proxy) --build-arg no_proxy=$(no_proxy) --build-arg USER_ID=$(USER_ID) --build-arg GROUP_ID=$(GROUP_ID) .

bash: build
	$(DOCKER) run --volume="$(EXTERNAL_PATH_TO_WS)":""$(LOCAL_PATH_TO_WS) -u "$(USER_ID):$(GROUP_ID)" -it  $(IMAGE_NAME) bash

root: build
	$(DOCKER) run --volume="$(EXTERNAL_PATH_TO_WS)":"$(LOCAL_PATH_TO_WS)" -it -u root $(IMAGE_NAME) bash

help:
	@echo "make bash : builds and runs the docker image as normal user"
	@echo "make root : builds and runs the docker image as ROOT user"


