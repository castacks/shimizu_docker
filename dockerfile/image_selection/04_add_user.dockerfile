ARG base_image
FROM ${base_image}:latest

USER root

# Add a user with the same user_id as the user outside the container
ARG user_id
ARG user_name
ARG group_id
ARG group_name

# Add a group
RUN if [ $(getent group ${group_id}) ]; then groupadd -g ${group_id} ${group_name}; fi

ENV USERNAME ${user_name}
RUN useradd --uid ${user_id} --gid ${group_id} -ms /bin/bash $USERNAME \
 && echo "$USERNAME:$USERNAME" | chpasswd \
 && adduser $USERNAME sudo \
 && echo "$USERNAME ALL=NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME \
 && adduser $USERNAME audio \ 
 && adduser $USERNAME video

RUN chown -R ${user_id}:${group_id} /Libraries/

# run as the developer user
USER $USERNAME

# running container start dir
WORKDIR /home/$USERNAME

RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc \
 && echo "export ROS_PACKAGE_PATH=\${ROS_PACKAGE_PATH}:/Libraries/ORB_SLAM2/Examples/ROS" >> ~/.bashrc \
 && echo "set -g mouse on" >> ~/.tmux.conf

# entrypoint command
CMD /bin/bash
