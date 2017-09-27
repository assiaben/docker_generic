Collection of useful dokcer image to start with. 

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

    $ docker run -it <IMAGE NAME> bash
    # echo test_commit > test_commit.txt # Do some modifs
    # exit
    $ docker ps -a # Get <CONTAINER ID>
    $ docker commit <CONTAINER ID> <NEW IMAGE NAME>:tag_name(optional)
    $ docker images # Check that the new image exists
    $ docker run -it <NEW IMAGE NAME> bash
    $ cat test_commit.txt

## Error handling

Can't delete image because child images dependencies

    Error message: Error response from daemon: conflict: unable to delete 8b88f06b72d7 (cannot be forced) - image has dependent child images
    # Solution: Find the child image and delete them
    $ docker inspect --format='{{.Id}} {{.Parent}}' $(docker images --filter since=<IMAGE ID> -q)
    sha256:1d1f94c972fc8d75a34135f9ff551617680c508f7ad17efda09048b4e805g1w3
    # The first 12 characters are the child <IMAGE ID>: 1d1f94c972fc



