#! /bin/sh

rosdep update
sudo apt update
rosdep install --from-paths src --ignore-src -r -y