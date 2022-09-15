#! /bin/sh

package_name="$1"
package_select=""

if [ $# -eq 0 ]
then 
    echo "Building All Packages"
    package_select=""
else
    echo "Building Package [$package_name]"
    package_select="--packages-up-to $package_name"
fi

colcon build --symlink-install --mixin coverage-gcc $package_select
colcon lcov-result --zero-counters
colcon lcov-result --initial
colcon test $package_select
colcon lcov-result --filter "*/test/*" "*/build/* */app/*" $package_select
