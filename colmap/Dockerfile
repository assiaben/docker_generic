# Copied from colmap repo and adapted to supelec network settings.
#https://github.com/colmap/colmap/blob/dev/docker/Dockerfile (Johannes Schonberger)
FROM nvidia/cuda:10.1-devel-ubuntu18.04

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
    git \
    cmake \
    vim \
    build-essential \
    libboost-program-options-dev \
    libboost-filesystem-dev \
    libboost-graph-dev \
    libboost-regex-dev \
    libboost-system-dev \
    libboost-test-dev \
    libeigen3-dev \
    libsuitesparse-dev \
    libfreeimage-dev \
    libgoogle-glog-dev \
    libgflags-dev \
    libglew-dev \
    qtbase5-dev \
    libqt5opengl5-dev \
    libcgal-dev \
    libcgal-qt5-dev \
    python3-dev \
    python3-pip \
    vim \
    wget

# Clean up pycache and pyc files
ENV ROOT_DIR /
COPY . $ROOT_DIR
WORKDIR $ROOT_DIR
RUN rm -rf __pycache__ && \
    find . -name "*.pyc" -delete && \
    for req in $(cat requirements.txt) pydot; do pip3 install $req; done 


# Build and install ceres solver
RUN apt-get -y install \
    libatlas-base-dev \
    libsuitesparse-dev
RUN git clone https://github.com/ceres-solver/ceres-solver.git --branch 1.14.0
RUN cd ceres-solver && \
	mkdir build && \
	cd build && \
	cmake .. -DBUILD_TESTING=OFF -DBUILD_EXAMPLES=OFF && \
  make -j8 && \
	make install

# Build and install COLMAP

# Note: This Dockerfile has been tested using COLMAP pre-release 3.6-dev.3.
# Later versions of COLMAP (which will be automatically cloned as default) may
# have problems using the environment described thus far. If you encounter
# problems and want to install the tested release, then uncomment the branch
# specification in the line below
RUN git clone https://github.com/colmap/colmap.git #--branch 3.6-dev.3

RUN cd colmap && \
	git checkout dev && \
	mkdir build && \
	cd build && \
	cmake .. && \
  make -j8 && \
	make install

# set user workspace
USER ${USER_ID}
ENV PYTHONPATH='/home/ws/'
WORKDIR /home/ws
