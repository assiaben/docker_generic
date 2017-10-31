############################################# Ubuntu 14.04, Cuda 7.5, Cudnn4
## WARNING: Stay with cudnn4 because deeplab does not 
## support any higher version

FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu14.04

LABEL MAINTAINER "Assia Benbihi <assia.benbihi@gmail.com>"

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

############################################# Dep install
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        git \
        wget \
        libatlas-base-dev \
        libboost1.55-all-dev \
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
        python-pip \
        python-scipy && \
    rm -rf /var/lib/apt/lists/*
    
WORKDIR /opt

# MATIO
RUN wget http://jaist.dl.sourceforge.net/project/matio/matio/1.5.2/matio-1.5.2.tar.gz && \
    tar -xvzf matio-1.5.2.tar.gz && \
    rm matio-1.5.2.tar.gz
    
WORKDIR /opt/matio-1.5.2

RUN ./configure && make -j8 && make install -j8

ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

ENV INCLUDE_DIRS=/opt/matio-1.5.2/src/:$INCLUDE_DIRS
ENV LIBRARY_DIRS=/opt/matio-1.5.2/src/:$LIBRARY_DIRS

# FIXME: clone a specific git tag and use ARG instead of ENV once DockerHub supports this.
ENV CLONE_TAG=master

ADD ./common.cuh /opt

RUN git clone -b ${CLONE_TAG} --depth 1 https://bitbucket.org/aquariusjay/deeplab-public-ver2.git . && \
    mv -f /opt/common.cuh include/caffe/ && \
    for req in $(cat python/requirements.txt) pydot; do pip install $req; done && \
    cp Makefile.config.example Makefile.config && \
    make all -j8 && \
    make pycaffe -j8

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

USER ${USER_ID}

ENV PYTHONPATH='/home/ws/'

WORKDIR /home/ws
