#/bin/bash

source /opt/ros/melodic/setup.bash && \
export ROS_PACKAGE_PATH=${ROS_PACKAGE_PATH}:/Libraries/ORB_SLAM2/Examples/ROS && \
sudo rm /etc/ros/rosdep/sources.list.d/20-default.list && \
sudo rosdep init && rosdep update && \
cd /Libraries/ORB_SLAM2 && \
./build_ros.sh && \
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc && \
echo "export ROS_PACKAGE_PATH=\${ROS_PACKAGE_PATH}:/Libraries/ORB_SLAM2/Examples/ROS" >> ~/.bashrc
