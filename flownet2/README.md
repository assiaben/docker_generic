## Building

Assumes you have the flownet2 git in this repository. If not, clone it
    
    git clone https://github.com/lmb-freiburg/flownet2.git

Set the volumes to mount in the Makefile
    
    EXTERNAL_PATH_TO_WS=external_ws # path to volume to mount on server
    LOCAL_PATH_TO_WS=local_ws # path the mounted volume on the image

Build
    
    make root
    
## Launch the image (assumed you have built the image)
--volume=external_path:local_path mounts external_path in local_path in the image
    
    nvidia-docker run --volume=/usr/users/ims/benbihi_ass/ws/abenbihi/ws:/home/ws -it -u root abenbihi/caffe:U14.04_Cuda8_Cudnn5 bash

