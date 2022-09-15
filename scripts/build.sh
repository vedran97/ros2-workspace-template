#! /bin/sh

build_type="$1"
package_name="$2"

cmake_args="-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"
compiler_warnings="-Wall -Wextra -Wpedantic"
package_select=""

if [ $# -eq 1 ]
then 
    echo "Building All Packages"
    package_select=""
else
    echo "Building Package [$package_name]"
    package_select="--packages-up-to $package_name"
fi

if [ "$build_type" = "Release" ]
then
    echo "Using Release Configuration"
    cmake_args="$cmake_args -DCMAKE_BUILD_TYPE=RelWithDebInfo"
else
    echo "Using Debug Configuration"
    cmake_args="$cmake_args -DCMAKE_BUILD_TYPE=Debug"
fi

colcon build --symlink-install $package_select --cmake-args $cmake_args $compiler_warnings