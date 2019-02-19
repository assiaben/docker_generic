############################################# Ubuntu 16.04, Cuda 8, Cudnn6
## WARNING: Stay with cudnn4 because deeplab does not 
## support any higher version

FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04
#FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu14.04

LABEL MAINTAINER "Assia Benbihi <assia.benbihi@gmail.com>"

############################################# Proxy definition
# This is necessary and specific to CentraleSupelec
#ENV http_proxy ${http_proxy}
#ENV https_proxy ${https_proxy}
#ENV no_proxy ${no_proxy}

# Setup User to match Host User, and give superuser permissions
# 
ARG USER_ID=0
ARG GROUP_ID=0
RUN groupadd -g ${GROUP_ID} code_executor && useradd -m code_executor -u ${USER_ID} -g ${GROUP_ID}

############################################# Dep install
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        libatlas-base-dev \
        libboost1.58-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libopencv-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-opencv \
        python-pip \
        python-scipy \
        vim && \
    rm -rf /var/lib/apt/lists/*
    
ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

# FIXME: clone a specific git tag and use ARG instead of ENV once DockerHub supports this.
ENV CLONE_TAG=master

ADD caffe /opt/caffe
WORKDIR $CAFFE_ROOT

RUN echo $CAFFE_ROOT
RUN pwd
RUN ls

#RUN  for req in $(cat python/requirements.txt) pydot; do pip install $req; done
RUN pip install --upgrade pip==9.0.1 && \
    for req in $(cat python/requirements.txt) pydot; do pip install $req; done && \
    git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl && \
    mkdir build && cd build && \
    cmake -DUSE_CUDNN=1 -DUSE_NCCL=1 .. && \
    make -j"$(nproc)" all tools pycaffe

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

USER ${USER_ID}

ENV PYTHONPATH='/home/ws/:$PYTHONPATH'

WORKDIR /home/ws
