## Building

Set the volumes to mount in the Makefile
    
    EXTERNAL_PATH_TO_WS=external_ws # path to volume to mount on server
    LOCAL_PATH_TO_WS=local_ws # path the mounted volume on the image

Build
    
    make root
    
## Launch the image (assumed you have built the image)
--volume=external_path:local_path mounts external_path in local_path in the image
    
    # Example 
    nvidia-docker run --volume=/usr/users/ims/benbihi_ass/ws/abenbihi/ws:/home/ws -it -u root segnet bash

## Training for Antoine

caffe train --gpu=0 --solver=segnet_solver_all3_test.prototxt --weights=../VGG_ILSVRC_16_layers.caffemodel
