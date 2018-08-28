#FROM ubuntu:16.04
#FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

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

RUN apt-get -y update && apt-get -y install git wget python-dev python3-dev libopenmpi-dev python-pip zlib1g-dev cmake python-opencv vim
ENV CODE_DIR /root/code
ENV VENV /root/venv

RUN \
    pip install virtualenv && \
    virtualenv $VENV --python=python3 && \
    . $VENV/bin/activate && \
    pip install --upgrade pip

ENV PATH=$VENV/bin:$PATH

COPY . $CODE_DIR/baselines
WORKDIR $CODE_DIR/baselines

# Clean up pycache and pyc files
RUN rm -rf __pycache__ && \
    find . -name "*.pyc" -delete && \
    for req in $(cat requirements.txt) pydot; do pip install $req; done 
#&& \
#    pip install -e .[test]

ENV CUDA_VISIBLE_DEVICES 0
ENV PYTHONPATH /root/code/baselines:$PYTHONPATH
CMD /bin/bash
