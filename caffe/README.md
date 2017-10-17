## Building

Modify the volume to mount in the makefile
    
    # Set the external volume you want to mount
    EXTERNAL_PATH_TO_WS=external_volume

    # Set the internal volume you want to mount
    LOCAL_PATH_TO_WS=internal_volume

    # Build and run 
    make root

## Set the caffe path in your docker image
    
    export PYTHONPATH=$PYTHONPATH:/opt/caffe/python

## Launch the image (assumed you have built the image)
--volume=external_path:local_path mounts external_path in local_path in the image
    
    nvidia-docker run --volume=/usr/users/ims/benbihi_ass/ws/abenbihi/ws:/home/ws -it -u root abenbihi/caffe:U14.04_Cuda8_Cudnn5 bash

## Caffe useful commands 

Finetuning: 
    
    caffe train -solver solver.prototxt -weights ../fcn8s-heavy-pascal.caffemodel
