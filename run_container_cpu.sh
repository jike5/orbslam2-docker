# UI permisions
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

xhost +local:docker

docker pull jike5/orbslam2-dev:latest

# Remove existing container
docker rm -f /orbslam2 &>/dev/null

# Create a new container
docker run -td --privileged --net=host --ipc=host \
    --name="orbslam2" \
    -e "DISPLAY=$DISPLAY" \
    -e "QT_X11_NO_MITSHM=1" \
    -v "/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -e "XAUTHORITY=$XAUTH" \
    -e ROS_IP=127.0.0.1 \
    --cap-add=SYS_PTRACE \
    -v `pwd`/workspace:/workspace \
    -v /etc/group:/etc/group:ro \
    jike5/orbslam2-dev:latest bash
    
