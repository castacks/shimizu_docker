# Author:
# Yaoyu Hu <yaoyuh@andrew.cmu.edu>
# Date:
# 2021-12-28

ARG base_image
FROM ${base_image}:latest

RUN sudo apt-get update \
 && sudo apt-get install --no-install-recommends -y \
    pkg-config libavcodec-dev libavformat-dev libswscale-dev \
    libglew-dev libpython2.7-dev \
    libgl1-mesa-dev \
    libegl1-mesa-dev libwayland-dev \
    libxkbcommon-dev wayland-protocols \
    ffmpeg libavcodec-dev libavutil-dev libavformat-dev libswscale-dev libavdevice-dev \
    libjpeg-dev libpng-dev libtiff5-dev libopenexr-dev \
 && sudo apt-get clean

# Pangolin.
WORKDIR /Libraries/

RUN pip install --no-cache-dir pyopengl Pillow pybind11

RUN chmod 777 /Libraries/ -R \
 && git clone https://github.com/stevenlovegrove/Pangolin.git \
 && cd Pangolin \
 && git submodule init && git submodule update \
 && mkdir build \
 && cd build \
 && cmake -DCMAKE_BUILD_TYPE=Release .. \
 && make -j8 \
 && make install \
 && cd ../../ \
 && rm -rf ./Pangolin

# ORB SLAM.
COPY ORB_SLAM2.zip ./
RUN unzip ORB_SLAM2.zip \
 && mv ORB_SLAM2-master ORB_SLAM2 \
 && cd ORB_SLAM2 \
 && chmod +x build.sh \
 && ./build.sh

# ROS Node.
# RUN export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/Libraries/ORB_SLAM2/Examples/ROS \
#  && chmod +x build_ros.sh \
#  && ./build_ros.sh

CMD /bin/bash
