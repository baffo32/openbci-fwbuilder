set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/../cmake")
include(common)
cmake_minimum_required(VERSION ${CMAKE_MINIMUM_REQUIRED_VERSION})

include(GitUtils)
include(AntUtils)

add_subdirectory(arduino)
add_subdirectory(chipkit)
