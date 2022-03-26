ARG base_image
FROM ${base_image}

ARG build_threads=4

WORKDIR /LibraryBuild

# # ARG cmake_version=3.22.2
# ARG cmake_version=3.17.3
# RUN wget https://github.com/Kitware/CMake/releases/download/v${cmake_version}/cmake-${cmake_version}.tar.gz --output-document cmake-${cmake_version}.tar.gz \
#  && tar zxf cmake-${cmake_version}.tar.gz \
#  && cd cmake-${cmake_version} \
#  && ./bootstrap \
#  && make -j${build_threads} \
#  && make install \
#  && hash -r \
#  && cd .. \
#  && rm -rf cmake-${cmake_version}

# # https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line
# RUN apt-get update \
#  && wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
#  && apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" \
#  && apt-get update \
#  && apt-get install -y --no-install-recommends kitware-archive-keyring \
#  && rm /etc/apt/trusted.gpg.d/kitware.gpg \
#  && apt-get update \
#  && apt-get install -y --no-install-recommends cmake \
#  && apt-get clean \
#  && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    libgoogle-glog-dev libgflags-dev \
    libatlas-base-dev \
    libeigen3-dev \
    libsuitesparse-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN git clone -b 2.0.0 https://github.com/ceres-solver/ceres-solver.git \
 && mkdir ceres-build \
 && cd ceres-build \
 && cmake ../ceres-solver \
 && make -j${build_threads} \
 && make install \
 && cd .. \
 && rm -rf ceres-build \
 && rm -rf ceres-solver

# Entrypoint command
CMD /bin/bash
