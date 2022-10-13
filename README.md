# orbslam2-docker

> Ref: https://github.com/proudh/docker-orb-slam2-build/blob/master/Dockerfile
>
> https://github.com/jahaniam/orbslam3_docker

## How to use

We provide three images:

| Image Name            | Descriptions                                                 |
| --------------------- | ------------------------------------------------------------ |
| jike5/ros-melodic:cpu | Providing ros-full and opencv, supporting X11 to achieve display window |
| orbslam2-dev          | Providing basic environment to build orbslam2                |
| orbslam2-run          | You can run orbslam2 dirctly                                 |

The image was upload to docker hub: https://hub.docker.com/repository/docker/jike5/orbslam2

```
docker image pull jike5/orbslam2-dev
```

For origin orbslam2 has some bugs, we recommend download our modified code:

```bash
mkdir -p workspace/data 
cd workspace
git clone https://github.com/jike5/ORB_SLAM2
```

To use the image with display window, you use the sript:

```
sudo ./run_container_cpu.sh
```

Now you have a container running on your computer

```
docker ps -a | grep orbslam
# you will find you container ID
docker exec -it orbslam3[or container ID] bash
```

In the container bash:

```
cd /workspace/ORB_SLAM2
./build.sh
./build_ros.sh
```

To run rgbd mode:

run fr2_desk:

```
./Examples/RGB-D/rgbd_tum /workspace/ORB_SLAM2/Vocabulary/ORBvoc.txt /workspace/ORB_SLAM2/Examples/RGB-D/TUM2.yaml /workspace/data/rgbd_dataset_freiburg2_desk /workspace/ORB_SLAM2/Examples/RGB-D/associations/fr2_desk.txt
```

run fr3_office:

```
./Examples/RGB-D/rgbd_tum /workspace/ORB_SLAM2/Vocabulary/ORBvoc.txt /workspace/ORB_SLAM2/Examples/RGB-D/TUM3.yaml /workspace/data/rgbd_dataset_freiburg3_long_office_household /workspace/ORB_SLAM2/Examples/RGB-D/associations/fr3_office.txt
```



## Build your own image

Firstly, to use the image base, you can pull it form dockerhub:

```
docker image pull jike5/ros-melodic:cpu
```

or you can build the ros image on your own computer. We use [this repo](https://github.com/turlucode/ros-docker-gui)

```
git clone https://github.com/turlucode/ros-docker-gui
cd https://github.com/turlucode/ros-docker-gui
# you can choose you own platform, as in Makefile
make cpu_ros_melodic
```

> If your network has porblem to achieve github, we recommend to use proxy when build the image:
>
> ```
> # remeber replace you own proxy ports
> docker build . -t jike5/ros-melodic:cpu -f docker/ros-melodic/Dockerfile --build-arg HTTP_PROXY=http://127.0.0.1:58591 --build-arg HTTPS_PROXY=http://127.0.0.1:58591 --build-arg ALL_PROXY=socks5://127.0.0.1:51837 --network host
> ```

Then, you can modify the Dockerfile(in this repo) and build it for you own requirement:

```
docker image build -t [name]:[version] .
```

> Just as above, if your network has porblem to achieve github, use following:
>
> ```
> # remeber replace you own proxy ports
> docker build . -t jike5/orbslam2-dev -f docker/orbslam2-dev/Dockerfile --build-arg HTTP_PROXY=http://127.0.0.1:58591 --build-arg HTTPS_PROXY=http://127.0.0.1:58591 --build-arg ALL_PROXY=socks5://127.0.0.1:51837 --network host
> ```

Build the edgeslam image:

```
docker build . -t jike5/edgeslam-run -f docker/edgeslam-run/Dockerfile --network host
```

