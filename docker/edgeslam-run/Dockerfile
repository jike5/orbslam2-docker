# Image taken from 
FROM   jike5/orbslam2-dev:latest

LABEL maintainer="2719825969@qq.com"
USER root

# # Clone code
RUN mkdir -p /workspace && cd /workspace \
  && git clone https://gitee.com/jike5/edgeslam

# Build
RUN cd /workspace/edgeslam && chmod +x build.sh \
  && chmod +x build_ros.sh \
  && rm -rf ./build \
  && ./build.sh

RUN bash -i -c "echo 'ROS_PACKAGE_PATH=/opt/ros/melodic/share:/workspace/edgeslam/Examples/ROS'>>~/.bashrc"
RUN bash -c "echo $ROS_PACKAGE_PATH"
RUN cd /workspace/edgeslam/Examples/ROS/Edge_SLAM \
  && rm -rf build \
  && mkdir build

WORKDIR /workspace/edgeslam/Examples/ROS/Edge_SLAM/build
RUN bash -c "source /opt/ros/melodic/setup.bash && export ROS_PACKAGE_PATH=/opt/ros/melodic/share:/workspace/edgeslam/Examples/ROS && cmake .. -DROS_BUILD_TYPE=Release && make -j"

RUN echo "source /workspace/edgeslam/Examples/ROS/Edge_SLAM/build/devel/setup.bash" >> ~/.bashrc

WORKDIR /workspace/edgeslam/Examples
