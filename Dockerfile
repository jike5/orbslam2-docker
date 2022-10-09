# Image taken from ros: https://hub.docker.com/_/ros
FROM ros:melodic-ros-base

RUN apt-get update

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y gnupg2 curl lsb-core vim wget python-pip libpng16-16 libjpeg-turbo8 libtiff5

RUN apt-get install -y \
        # Base tools
        cmake \
        build-essential \
        git \
        unzip \
        pkg-config \
        python-dev \
        # OpenCV dependencies
        python-numpy \
        # Pangolin dependencies
        libgl1-mesa-dev \
        libglew-dev \
        libpython2.7-dev \
        libeigen3-dev \
        apt-transport-https \
        ca-certificates\
        software-properties-common

RUN apt-get update && apt-get install -y \
	# websocketpp dependencies
        libarmadillo-dev\
        libasio-dev\
        # network tools
        iputils-ping net-tools iproute2 telnet

RUN apt-get install -y \
	libeigen3-dev

# # Build Pangolin
RUN git clone https://github.com/stevenlovegrove/Pangolin.git \
  && cd Pangolin \
  && mkdir build \
  && cd build \
  && cmake .. \
  && make \
  && make install

# Install OpenCV
RUN curl -fsSL https://github.com/opencv/opencv/archive/3.4.5.zip -o opencv.zip \
  && unzip opencv.zip \
  && rm opencv.zip \
  && cd opencv-3.4.5 \
  && mkdir release \
  && cd release \
  && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. \
  && make \
  && make install

# # Config ROS
RUN echo "source /opt/ros/melodic/setup.bash" >> /root/.bashrc
RUN echo "export ROSLAUNCH_SSH_UNKNOWN=1" >> /root/.bashrc

COPY ros_entrypoint.sh /ros_entrypoint.sh
RUN chmod +x  /ros_entrypoint.sh
ENV ROS_DISTRO melodic
ENV LANG en_US.UTF-8

ENTRYPOINT ["/ros_entrypoint.sh"]

USER $USERNAME
# terminal colors with xterm
ENV TERM xterm
CMD ["bash"]
