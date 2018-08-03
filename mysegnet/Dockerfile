
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
        python-setuptools \
        python-scipy && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# MATIO
RUN wget http://jaist.dl.sourceforge.net/project/matio/matio/1.5.2/matio-1.5.2.tar.gz && \
    tar -xvzf matio-1.5.2.tar.gz && \
    rm matio-1.5.2.tar.gz
    
WORKDIR /opt/matio-1.5.2

RUN ./configure && make -j8 && make install -j8

# Caffe install
ENV CAFFE_ROOT=/opt/
WORKDIR $CAFFE_ROOT

ENV INCLUDE_DIRS=/opt/matio-1.5.2/src/:$INCLUDE_DIRS
ENV LIBRARY_DIRS=/opt/matio-1.5.2/src/:$LIBRARY_DIRS

ENV CLONE_TAG=1.0


ADD segnet /opt

WORKDIR /opt

#ADD ./solver.cpp /opt
#ADD ./caffe.cpp /opt

#RUN git clone https://github.com/TimoSaemann/caffe-segnet-cudnn5.git . && \
#    pwd && \
#    ls && \
#    mv -f /opt/caffe.cpp tools/ && \
#    mv -f /opt/solver.cpp src/caffe/ && \
#    pip install --upgrade pip && \
#    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
#    git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl && \
#    mkdir build && cd build && \
#    cmake -DUSE_CUDNN=1 -DUSE_NCCL=1 .. 
#    # && \
#    #make -j"$(nproc)"

RUN pip install --upgrade pip && \
    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
    git clone https://github.com/NVIDIA/nccl.git && cd nccl && make -j install && cd .. && rm -rf nccl && \
     make all -j8 && \
     make pycaffe -j8

#    mkdir build && cd build && \
#    cmake -DUSE_CUDNN=1 -DUSE_NCCL=1 .. && \
#    make all -j8 && \
#    make pycaffe -j8


ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

############################################# Workspace and user login

USER ${USER_ID}

ENV PYTHONPATH='/home/ws/:$PYTHONPATH'

WORKDIR /home/ws


