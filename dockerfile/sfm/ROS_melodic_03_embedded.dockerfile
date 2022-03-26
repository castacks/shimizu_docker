ARG base_image
FROM ${base_image}

WORKDIR /LibraryBuild

# Backward.
RUN apt-get update \
 && apt install -y --no-install-recommends \
    binutils-dev libdw-dev libdwarf-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir backward-cpp \
 && cd backward-cpp \
 && git clone https://github.com/bombela/backward-cpp.git backward-cpp \
 && mkdir build \
 && cd build \
 && cmake ../backward-cpp \
 && make \
 && make install \
 && cd ../.. \
 && rm -rf backward-cpp

# openMVG.
RUN mkdir openMVG \
 && cd openMVG \
 && git clone -b v2.0 https://github.com/openMVG/openMVG.git openMVG \
 && cd openMVG \
 && git submodule update --init --recursive \
 && cd .. \
 && mkdir openMVG_build \
 && cd openMVG_build \
 && cmake -DCMAKE_BUILD_TYPE=RELEASE ../openMVG/src \
 && make -j8 \
 && make install \
 && cd ../.. \
 && rm -rf openMVG

# openMVS.
RUN apt-get update \
 && apt-get install --no-install-recommends -y \
    libpng-dev libjpeg-dev libtiff-dev libglu1-mesa-dev \
    libcgal-dev libcgal-qt5-dev \
    freeglut3-dev libglew-dev libglfw3-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir openMVS \
 && cd openMVS \
 && git clone -b v1.1.1 https://github.com/cdcseacave/openMVS.git openMVS \
 && git clone -b v1.0.1 https://github.com/cdcseacave/VCG.git vcglib \
 && mkdir build \
 && cd build \
 && cmake -DCMAKE_BUILD_TYPE=Release -DVCG_ROOT=/LibraryBuild/openMVS/vcglib ../openMVS \
 && make -j8 \
 && make install \
 && cd ../.. \
 && rm -rf openMVS

# Entrypoint command
CMD /bin/bash
