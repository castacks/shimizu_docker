# Author:
# Yaoyu Hu <yaoyuh@andrew.cmu.edu>
# Date:
# 2022-2-23

# FROM osrf/ros:melodic-desktop-full-stretch
# FROM ros:melodic-perception-stretch
FROM ros:melodic-perception-bionic

# This is found at
# https://askubuntu.com/questions/909277/avoiding-user-interaction-with-tzdata-when-installing-certbot-in-a-docker-contai
# and
# http://p.cweiske.de/582
#

# allow using GUI apps
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install -y tzdata \
 && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
 && dpkg-reconfigure --frontend noninteractive tzdata \
 && apt-get install -y --no-install-recommends software-properties-common lsb-release apt-utils \
 && apt-get clean

# useful tools
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
        build-essential sudo \
        cmake \
        cppcheck \
        gdb \
        git \
        vim \
        tmux \
        wget \
        curl \
        less \
        htop \
        locate \
        python-pip \
        python3-pip \
        python-tk \
        libsm6 libxext6 \
        libboost-all-dev zlib1g-dev \
        x11-xserver-utils \
        libv4l-dev \
        libeigen3-dev \
        ros-melodic-octomap \
        libflann-dev \
        libpng-dev libjpeg-dev libtiff-dev libxxf86vm1 libxxf86vm-dev libxi-dev libxrandr-dev graphviz \
 && apt-get clean

# catkin tools.
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' \
 && wget http://packages.ros.org/ros.key -O - | apt-key add - \
 && apt-get update \
 && apt-get install --no-install-recommends -y python-catkin-tools \
 && apt-get clean

# Python.
RUN pip install setuptools wheel scikit-build \
 && pip install --no-cache-dir \
    numpy==1.16.2 \
    scipy==1.2.1 \
    matplotlib==2.2.3 \
    pyquaternion \
    opencv-python==4.2.0.32 \
    msgpack-rpc-python \
    jgraph \
    python-igraph==0.7.1.post6 \
    ipdb \
    ipython==5.0.0

RUN pip3 install setuptools wheel scikit-build \
 && pip3 install --no-cache-dir \
    numpy \
    scipy \
    matplotlib \
    pyquaternion \
    opencv-python==4.2.0.32 \
    msgpack-rpc-python \
    ipdb \
    ipython

# entrypoint command
CMD /bin/bash

