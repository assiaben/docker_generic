
############################################# Ubuntu 16.04, Cuda 8

FROM nvidia/cuda:8.0-cudnn5-devel-ubuntu14.04

LABEL maintainer "Assia Benbihi <assia.benbihi@gmail.com>"

############################################# Proxy definition
# This is necessary and specific to CentraleSupelec
ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

############################################# User definition

# Setup User to match Host User, and give superuser permissions
# 
ARG USER_ID=0
ARG GROUP_ID=0
RUN groupadd -g ${GROUP_ID} code_executor && useradd -m code_executor -u ${USER_ID} -g ${GROUP_ID}

############################################# Dep install

RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  git \
  g++ \
  graphviz \
  wget \
  libatlas-base-dev \
  libboost-all-dev \
  libgflags-dev \
  libgoogle-glog-dev \
  libhdf5-serial-dev \
  libleveldb-dev \
  liblmdb-dev \
  libopencv-dev \
  libprotobuf-dev \
  libsnappy-dev \
  pkg-config \
  protobuf-compiler \
  python-dev \
  python-numpy \
  python-pip \
  python-setuptools \
  python-scipy && \
  rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip && pip install \
  numpy>=1.7.1 \
  protobuf>=2.5.0 \
  pytz==2017.2 \
  scikit-learn \
  scikit-image>=0.9.3 \
  sklearn==0.0 \
  progressbar2==3.12.0\
  tables==3.2.2


## Caffe install
#ENV CAFFE_ROOT=/opt/caffe
#WORKDIR $CAFFE_ROOT
#
#ENV CLONE_TAG=1.0
#
#RUN git clone 1 https://github.com/lmb-freiburg/flownet2.git . && \
#    pip install --upgrade pip && \
#    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
#    git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl && \
#    mkdir build && cd build && \
#    cmake -DUSE_CUDNN=1 -DUSE_NCCL=1 .. && \
#    make -j"$(nproc)"
#
#ENV PYCAFFE_ROOT $CAFFE_ROOT/python
#ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
#ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
#RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

WORKDIR /home/ws

############################################# Workspace and user login

USER ${USER_ID}

ENV PYTHONPATH='/home/ws/:$PYTHONPATH'

WORKDIR /home/ws


