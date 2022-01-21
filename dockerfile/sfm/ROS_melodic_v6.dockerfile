# Author:
# Weikun Zhen
# Yaoyu Hu <yaoyuh@andrew.cmu.edu>

FROM ros:melodic

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    wget unzip libeigen3-dev libflann-dev libboost-all-dev libvtk7-dev \
 && apt-get clean

# install PCL 1.9
RUN wget https://github.com/PointCloudLibrary/pcl/archive/pcl-1.9.1.zip \
 && unzip pcl-1.9.1.zip \
 && rm pcl-1.9.1.zip \
 && mv pcl-pcl-1.9.1 pcl \
 && cd pcl \
 && mkdir release \
 && cd release \
 && cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DBUILD_GPU=ON \
    -DBUILD_apps=ON \
    -DBUILD_examples=ON \
    -DCMAKE_INSTALL_PREFIX=/usr \
    .. \
 && make -j4 \
 && make install \
 && cd ../.. \
 && rm -rf pcl
