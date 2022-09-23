#! /bin/sh

sanatizer="$1"
build_type="$2"
package_name="$3"
package_select=""
sanitizer=""
sanitizer_args=""
cmake_args="-DOSRF_TESTING_TOOLS_CPP_DISABLE_MEMORY_TOOLS=ON -DINSTALL_EXAMPLES=OFF -DSECURITY=ON  --no-warn-unused-cli -DCMAKE_sanatizer=Debug"
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
    cmake_args="$cmake_args -DCMAKE_BUILD_TYPE=RelWithDebInfo"
else
    cmake_args="$cmake_args -DCMAKE_BUILD_TYPE=Debug"
fi

if [ "$sanatizer" = "Thread" ]
then
    sanitizer="tsan"
    sanitizer_args="--build-base=build --install-base=install"
else
    sanitizer="asan-gcc"
    sanitizer_args="--build-base=build --install-base=install"
fi

if [ "$build_type" = "Release" ]
then
    echo "Using Release Configuration"
else
    echo "Using Debug Configuration"
fi

colcon build \
    $sanitizer_args \
    --cmake-args $cmake_args \
    --mixin $sanitizer \
    $package_select\
    --symlink-install

if [ "$sanatizer" = "Thread" ]
then
    echo "Running Thread Sanatizer"
else
    echo "Running Address Sanatizer"
fi

colcon test $sanitizer_args \
    --event-handlers sanitizer_report+ $package_select 

cd ../log/latest_test
# Displays three lines after the beginning of a ASAN reported issue.
grep -R '==.*==ERROR: .*Sanitizer' -A 3