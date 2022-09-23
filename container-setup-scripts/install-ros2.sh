#! /bin/sh

apt-get update
apt-get install -y curl gnupg2 lsb-release
curl http://repo.ros2.org/repos.key | apt-key add - 
sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list' 
apt-get update
apt-get install -y ros-foxy-desktop python3-argcomplete
apt-get install -y python3-pip python3-rosdep

# change ros-foxy-desktop ros-foxy-ros-base to just install the base version , which you might run on a robot