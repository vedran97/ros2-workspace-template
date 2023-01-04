cmake_minimum_required(VERSION 3.5)
project(asan_test)

# Default to C11
if(NOT CMAKE_C_STANDARD)
  set(CMAKE_C_STANDARD 11)
endif()

# Default to C++14
if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  add_compile_options(-Wall -Wextra -Wpedantic -O3)
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")

option(
  BUILD_SHARED_LIBS
  OFF)

# include folder
include_directories(include)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)

install(
  DIRECTORY include/
  DESTINATION include
)

add_executable(asan_test_node src/main.cpp
)


install(TARGETS
asan_test_node
  DESTINATION lib/${PROJECT_NAME})

if(BUILD_TESTING)
  
  find_package(ament_lint_auto REQUIRED)
  find_package(ament_cmake_gtest)
  find_package(ament_cmake_cppcheck REQUIRED)
  # the following line skips the linter which checks for copyrights
  # uncomment the line when a copyright and license is not present in all source files
  set(ament_cmake_copyright_FOUND TRUE)
  # the following line skips cpplint (only works in a git repo)
  # uncomment the line when this package is not in a git repo
  set(ament_cmake_cpplint_FOUND TRUE)
  
  ament_lint_auto_find_test_dependencies()
  ament_add_gtest(test_node src/main.cpp)
endif()

ament_package()
