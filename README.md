# orbslam2-docker

> Ref: https://github.com/proudh/docker-orb-slam2-build/blob/master/Dockerfile
>
> https://github.com/jahaniam/orbslam3_docker

## How to use

The image was upload to docker hub: https://hub.docker.com/repository/docker/jike5/orbslam2

```
docker image pull jike5/orbslam2
```

To use the image with display window, you use the script:

```
sudo ./run_container_cpu.sh
```

Or you can modify the Dockerfile and build it for you own requirement:

```
docker image build -t [name]:[version] .
```

