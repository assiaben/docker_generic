
############################################# Ubuntu 16.04, Cuda 8

FROM nvidia/cuda:8.0-devel-ubuntu16.04

LABEL maintainer "Jeremy Fix <jeremy.fix@centralesupelec.fr>"

############################################# Proxy definition
# This is necessary and specific to CentraleSupelec
ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

#############################################  Cudnn 5

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

ENV CUDNN_VERSION 5.1.10
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
            libcudnn5=$CUDNN_VERSION-1+cuda8.0 \
            libcudnn5-dev=$CUDNN_VERSION-1+cuda8.0 && \
    rm -rf /var/lib/apt/lists/*

############################################# User definition

# Setup User to match Host User, and give superuser permissions
# 
ARG USER_ID=0
ARG GROUP_ID=0
RUN groupadd -g ${GROUP_ID} code_executor && useradd -m code_executor -u ${USER_ID} -g ${GROUP_ID}

############################################# Keras and dep install

RUN apt-get update && \
	apt-get install -y libhdf5-dev g++ graphviz python3-pip python3-dev pkg-config vim bzip2 libbz2-dev libhdf5-dev 

RUN pip3 install --upgrade pip && \
    pip3 install pyyaml==3.12 \
    	 	 pytz==2017.2 \
		 python-dateutil==2.6.0 \
		 six==1.10.0 \
		 h5py==2.6.0 \
		 protobuf==3.2.0 \
		 pandas==0.19.2 \
		 scikit-learn==0.18.1 \
		 sklearn==0.0 \
		 numpy==1.12.1 \
		 scipy==0.18.1 \
		 theano==0.8.2 \
		 tensorflow-gpu==1.0.0 \
		 keras==1.2.2  \
		 matplotlib==2.0.1\
		 progressbar2==3.12.0\
		 tables==3.2.2

############################################# Workspace and user login

USER ${USER_ID}

ADD keras.json /home/code_executor/.keras/keras.json
ADD nilmann.tar.bz2 /home/code_executor/

ENV PYTHONPATH='/home/code_executor/:$PYTHONPATH'

WORKDIR /home/code_executor


