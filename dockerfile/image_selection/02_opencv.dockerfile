# Author:
# Yaoyu Hu <yaoyuh@andrew.cmu.edu>
# Date:
# 2021-12-28

# ARG base_image=yaoyuh/melodic_base:latest
ARG base_image
FROM ${base_image}:latest

RUN sudo apt-get update \
 && sudo apt-get install --no-install-recommends -y \
    python3-dev \
    python-dev \
    libeigen3-dev \
    libblas-dev liblapack-dev \
    unzip \
 && sudo apt-get clean

ARG opencv_version=3.2.0
WORKDIR /Libraries/OpenCV
COPY opencv-${opencv_version}.zip ./
COPY opencv_contrib-${opencv_version}.zip ./

RUN sudo chmod 777 /Libraries/OpenCV -R

RUN unzip opencv-${opencv_version}.zip \
 && unzip opencv_contrib-${opencv_version}.zip \
 && mkdir build \
 && mkdir install \
 && cd build \
 && cmake -DCMAKE_BUILD_TYPE=Release \
          -DOPENCV_EXTRA_MODULES_PATH=/Libraries/OpenCV/opencv_contrib-${opencv_version}/modules \
          -DOPENCV_ENABLE_NONFREE=ON \
          -DBUILD_opencv_python3=ON \
          -DBUILD_opencv_sfm=OFF \
          -DENABLE_PRECOMPILED_HEADERS=OFF \
          ../opencv-${opencv_version} \
 && make -j16 \
 && make install \
 && cd .. \
 && rm -rf opencv-${opencv_version} \
 && rm -rf opencv_contrib-${opencv_version} \
 && rm -rf opencv-${opencv_version}.zip \
 && rm -rf opencv_contrib-${opencv_version}.zip \
 && rm -rf build

         #  -DCMAKE_INSTALL_PREFIX=/Libraries/OpenCV/install \

CMD /bin/bash
