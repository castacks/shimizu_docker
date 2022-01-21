# Author:
# Yaoyu Hu <yaoyuh@andrew.cmu.edu>
# Date:
# 2021-12-28

FROM ros:noetic

# Useful tools
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
        build-essential \
        cmake \
        cppcheck \
        gdb \
        git \
        sudo \
        vim \
        wget \
        curl \
        less \
        htop \
        python3-pip \
        python-tk \
        libsm6 libxext6 \
        libboost-all-dev zlib1g-dev \
        lsb-release \
        libatlas-base-dev libflann-dev libmetis-dev doxygen libyaml-cpp-dev \
        libgl1-mesa-glx \
        ros-noetic-cv-bridge \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# allow using GUI apps
ARG TERM=xterm
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && -E apt-get install -y tzdata \
 && ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime \
 && dpkg-reconfigure --frontend noninteractive tzdata \
 && apt-get clean

WORKDIR /root

# Eigen3.
RUN cd /root \
&& mkdir eigen \
&& git clone https://github.com/eigenteam/eigen-git-mirror.git \
&& mv eigen-git-mirror/ Src \
&& mkdir Build \
&& cd Build \
&& cmake ../Src \
&& sudo make install \
&& cd ../.. \
&& rm -rf eigen/

# cnpy.
RUN cd /root \
&& mkdir cnpy \
&& cd cnpy \
&& git clone https://github.com/rogersce/cnpy.git \
&& mv cnpy/ Src \
&& mkdir Build \
&& cd Build \
&& cmake ../Src \
&& make -j2 \
&& sudo make install \
&& cd ../.. \
&& rm -rf cnpy/

# Python 3.
RUN pip3 install --no-cache-dir \
    numpy scipy \
    matplotlib pandas colorcet\
    ipython ipdb \
    plyfile \
    opencv-python opencv-contrib-python \
 && ln -s /usr/bin/python3 /usr/bin/python

# entrypoint command
CMD /bin/bash
