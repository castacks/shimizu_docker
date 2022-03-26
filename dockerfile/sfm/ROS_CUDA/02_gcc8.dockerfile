ARG base_image
FROM ${base_image}

RUN apt-get update \
 && add-apt-repository ppa:ubuntu-toolchain-r/test \
 && apt install -y --no-install-recommends gcc-8 g++-8 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 80 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8 \
 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7 --slave /usr/bin/gcov gcov /usr/bin/gcov-7

# Entrypoint command
CMD /bin/bash
