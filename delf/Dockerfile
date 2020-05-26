#FROM ubuntu:16.04
#FROM nvidia/cuda:9.0-cudnn7.0-devel-ubuntu16.04
FROM nvidia/cuda:9.0-devel-ubuntu16.04
ENV CUDNN_VERSION 7.0.5.15
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

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
  build-essential \
  cmake \
  git \
  wget \
  libgoogle-glog-dev \
  libopencv-dev \
  protobuf-compiler \
  python3-dev \
  python-opencv \
  python3-pip \
  unzip \
  vim \
  wget \ 
  zlib1g-dev \
  libcudnn7=$CUDNN_VERSION-1+cuda9.0 \
  libcudnn7-dev=$CUDNN_VERSION-1+cuda9.0 \
  && \
  apt-mark hold libcudnn7 && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /opt
RUN wget https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip && \
  unzip protoc-3.3.0-linux-x86_64.zip && \
  PATH_TO_PROTOC=`pwd`

# Clean up pycache and pyc files

COPY requirements.txt /opt
ADD ./extractor.py /opt
ADD ./delf_config.proto /opt


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
  mv /opt/extractor.py delf/python/ && \
  mv /opt/delf_config.proto delf/protos/ && \
  /opt/bin/protoc delf/protos/*.proto --python_out=. && \
  pip3 install -e .
  
ENV WS /home/ws

ENV CUDA_VISIBLE_DEVICES 0
ENV PYTHONPATH $WS:/opt/models/research:/opt/models/research/slim:$PYTHONPATH
USER ${USER_ID}
WORKDIR /home/ws
#CMD /bin/bash
