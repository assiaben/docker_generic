you want to use, check at the end of the file for ready-to-run images or create
your own Docker tools.

## How to create a docker image
Define 
- Dockerfile: image definition 
- requirements.txt: list python packages you want to install
- Makefile: to build the image 
- other: every data you want to go into the working directory of the machine

Then run 
    make root # builds and run the image as ROOT user

IMPORTANT: Always add the proxy environment variables in you Dockerfile. It is necessary to build the image.

NOTE: The project you are working on may have already defined a Dockerfile. Start
from it and complete it. 

## Usefule commands

Build image

    docker build -t <IMAGE NAME> .

Display images in the Docker Image registry

    docker images

Run the app (foreground)

    docker run -p <IMAGE NAME>

Run the image built with nvidia docker as root, mount a volume and get access to bash

    nvidia-docker run --volume=<LOCAL HOST PATH>:<DOCKER IMAGE PATH> -it -u root <IMAGE NAME> bash

Run the app (background) 

    docker run -d -p <IMAGE NAME>

Stop the background app: get the id and stop it

    docker container ls # get CONTAINER ID
    docker stop <CONTAINER ID>

Stop all containers

    docker stop $(docker ps -a -q)

Remove an image by its IMAGE ID

    docker container ls # get IMAGE ID
    docker rmi <IMAGE ID>

Remove dangling images (i.e. useless images)

    docker rmi $(docker images -f dangling=true -q)

Remove all images

    docker rmi $(docker images -a -q)

Remove container by CONTAINER ID

    docker ps -a # Get CONTAINER ID
    docker rm <CONTAINER ID>

Remove all containers

    docker rm $(docker ps -a -q)

Save change made in a container to a new image

    docker run -it <IMAGE NAME> bash
    # echo test_commit > test_commit.txt # Do some modifs
    # exit
    docker ps -a # Get <CONTAINER ID>
    docker commit <CONTAINER ID> <NEW IMAGE NAME>:tag_name(optional)
    docker images # Check that the new image exists
    docker run -it <NEW IMAGE NAME> bash
    cat test_commit.txt

Save your image on a remote repository
    
    # Tag your image 
    docker tag <IMAGE NAME>:<IMAGE TAG> <DOCKER USERNAME>/<REPO NAME>:<IMAGE TAG>
    docker push <DOCKER USERNAME>/<REPO NAME>:<IMAGE TAG>

Remove images with the same <IMAGE ID> but with different tags

    docker rmi <REPOSITORY NAME>:<TAG NAME>

## Error handling

Can't delete image because child images dependencies

    Error message: Error response from daemon: conflict: unable to delete 8b88f06b72d7 (cannot be forced) - image has dependent child images
    # Solution: Find the child image and delete them
    $ docker inspect --format='{{.Id}} {{.Parent}}' $(docker images --filter since=<IMAGE ID> -q)
    sha256:1d1f94c972fc8d75a34135f9ff551617680c508f7ad17efda09048b4e805g1w3
    # The first 12 characters are the child <IMAGE ID>: 1d1f94c972fc

## Ready-to-run images

[Tensorflow](https://hub.docker.com/r/tensorflow/tensorflow/)
    
    # For tensorflow 1.2.0 gpu support
    docker pull tensorflow/tensorflow:1.2.0-gpu

