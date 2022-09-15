apt-get update
apt-get install -y bash-completion 
apt-get install -y git
apt-get install -y build-essential cmake gdb
apt-get install -y pylint3 python3-argcomplete
apt-get install -y python3-colcon-common-extensions
apt-get install -y python3-vcstool
apt-get install -y wget
apt-get install -y ros-foxy-ament-lint python3-autopep8
apt-get install -y ros-foxy-launch-testing ros-foxy-launch-testing-ament-cmake ros-foxy-launch-testing-ros
apt-get install -y nano
apt-get install -y htop

sudo apt-get install -y lcov
pip3 install colcon-mixin
pip3 install colcon-common-extensions
pip3 install colcon-lcov-result
pip3 install ipykernel
pip3 install matplotlib
rosdep init || echo "rosdep already initialized"