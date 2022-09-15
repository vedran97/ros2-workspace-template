#! /bin/sh

colcon build --cmake-target clean
rm -rf build* install* log* lcov*
py3clean .