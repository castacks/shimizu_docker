ARG base_image
FROM ${base_image}

RUN apt-get update \
 && apt install -y --no-install-recommends \
    ros-melodic-rviz \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN pip install pyquaternion plyfile future-fstrings

# Entrypoint command
CMD /bin/bash
