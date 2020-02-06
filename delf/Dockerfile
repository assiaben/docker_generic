#FROM ubuntu:16.04
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

############################################# Proxy definition
# This is necessary and specific to CentraleSupelec
ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

# Setup User to match Host User, and give superuser permissions
# 
ARG USER_ID=0
ARG GROUP_ID=0
RUN groupadd -g ${GROUP_ID} code_executor && useradd -m code_executor -u ${USER_ID} -g ${GROUP_ID}
###########################

RUN apt-get -y update && apt-get -y install \
  cmake \
  git \
  protobuf-compiler \
  python3-dev \
  python3-pip \
  unzip \
  vim \
  wget \ 
  zlib1g-dev  && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip && \
  unzip protoc-3.3.0-linux-x86_64.zip && \
  PATH_TO_PROTOC=`pwd`

# Clean up pycache and pyc files

COPY requirements.txt /opt

RUN rm -rf __pycache__ && \
    find . -name "*.pyc" -delete && \
    for req in $(cat requirements.txt) pydot; do pip3 install $req; done 
    #&& \
    #pip install -e .[test]

ENV CLONE_TAG=v1.13.0

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/tensorflow/models.git && \ 
  cd models/research/slim/ && \
  pip3 install -e . && \
  cd /opt/models/research/delf && \
  /opt/bin/protoc delf/protos/*.proto --python_out=. && \
  pip3 install -e .
  

ENV CUDA_VISIBLE_DEVICES 0
ENV PYTHONPATH /opt/models/research:/opt/models/research/slim
USER ${USER_ID}
WORKDIR /home/ws
#CMD /bin/bash
