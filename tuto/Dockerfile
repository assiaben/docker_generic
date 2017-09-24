
############################################# Ubuntu 16.04, Cuda 8
# Use an official runtime as a parent image
FROM python:2.7-slim

LABEL maintainer "Toto <toto@titi.fr>"

############################################# Proxy definition
# Define environment variable
# This is necessary and specific to CentraleSupelec
ENV http_proxy ${http_proxy}
ENV https_proxy ${https_proxy}
ENV no_proxy ${no_proxy}

# Command to set package cache
RUN apt-get update && apt-get install -y --no-install-recommends \
 	sl && \
    rm -rf /var/lib/apt/lists/*

############################################# User definition

# Setup User to match Host User, and give superuser permissions
# 
ARG USER_ID=0
ARG GROUP_ID=0
RUN groupadd -g ${GROUP_ID} code_executor && useradd -m code_executor -u ${USER_ID} -g ${GROUP_ID}

# Set the working directory to /home/ws
WORKDIR /home/ws

# Copy the current directory content to /home/ws
ADD . /home/ws 

# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

############################################# Workspace and user login

USER ${USER_ID}

# Copy the file to /home/ws
ADD test_file.txt /home/ws/

ENV PYTHONPATH='/home/ws/:$PYTHONPATH'

# Run app.py when the container launches
CMD ["python", "app.py"]

ENV NAME World


