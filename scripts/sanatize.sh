#! /bin/sh

sanatizer="$1"
package_name="$2"
package_select=""
sanitizer=""

if [ $# -eq 1 ]
then 
    echo "Building All Packages"
    package_select=""
else
    echo "Building Package [$package_name]"
    package_select="--packages-up-to $package_name"
fi

if [ "$sanatizer" = "Thread" ]
then
    echo "Running Thread Sanatizer"
    sanitizer="tsan"
else
    echo "Running Address Sanatizer"
    sanitizer="asan-gcc"
fi

colcon build \
    --cmake-args    \
        -DOSRF_TESTING_TOOLS_CPP_DISABLE_MEMORY_TOOLS=ON \
        -DINSTALL_EXAMPLES=OFF \
        -DSECURITY=ON  --no-warn-unused-cli \
        -DCMAKE_sanatizer=Debug \
    --mixin $sanitizer $package_select --symlink-install

colcon test $package_select

cd log/latest_test
grep -R '==.*==ERROR: .*Sanitizer' -A 10