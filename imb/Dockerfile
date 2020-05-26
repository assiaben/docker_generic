# Copied from colmap repo and adapted to supelec network settings.
#https://github.com/colmap/colmap/blob/dev/docker/Dockerfile (Johannes Schonberger)
FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

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

# Prepare and empty machine for building
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    vim \
    libavcodec-dev \
    libavformat-dev \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libcgal-dev \
    libcgal-qt5-dev \
    libdc1394-22-dev \
    libeigen3-dev \
    libfreeimage-dev \
    libgflags-dev \
    libglew-dev \
    libgoogle-glog-dev \
    libgtk2.0-dev \
    libjasper-dev \
    libjpeg-dev \
    libsuitesparse-dev \
    libswscale-dev \
    libtbb2 \
    libtbb-dev \
    libtiff-dev \
    libqt5opengl5-dev \
    pkg-config \
    python3-dev \
    python3-numpy \
    python3-dev \
    python3-numpy \
    python3-pip \
    qtbase5-dev \
    unzip \
    vim \
    wget


ENV INSTALL_DIR /home/ws/install

# Nabo
WORKDIR $INSTALL_DIR
RUN git clone https://github.com/ethz-asl/libnabo.git libnabo && \
  cd libnabo && \
  mkdir build && \
  cd build && \
  cmake .. -DUSE_OPEN_MP=False && \
  make && \
  make install 


# Eigen
WORKDIR $INSTALL_DIR
RUN wget https://gitlab.com/libeigen/eigen/-/archive/3.3.3/eigen-3.3.3.zip && \
  unzip eigen-3.3.3.zip && \
  cd eigen-3.3.3 && \
  mkdir build && \
  cd build && \
  cmake .. && \
  make install

# opencv
WORKDIR $INSTALL_DIR
RUN wget https://github.com/opencv/opencv/archive/3.4.2.zip && \
  unzip 3.4.2.zip && \
  cd opencv-3.4.2 && \
	mkdir build && \
	cd build && \
  cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
  make -j8 && \
	make install

ENV ROOT_DIR /
COPY . $ROOT_DIR
WORKDIR $ROOT_DIR
RUN rm -rf __pycache__ && \
    find . -name "*.pyc" -delete && \
    for req in $(cat requirements.txt) pydot; do pip3 install $req; done 


# set user workspace
USER ${USER_ID}
ENV PYTHONPATH='/home/ws/'
WORKDIR /home/ws
