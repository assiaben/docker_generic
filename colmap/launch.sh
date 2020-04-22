#!/bin/sh
nvidia-docker run --volume="/usr/users/ims/benbihi_ass/ws/":"/home/ws" -it -u root colmap bash
