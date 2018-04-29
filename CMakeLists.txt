set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
include(common)
cmake_minimum_required(VERSION ${CMAKE_MINIMUM_REQUIRED_VERSION})

file(MAKE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/toolchain")
add_custom_target(
  Toolchain ALL
  COMMAND "${CMAKE_COMMAND}" "${CMAKE_CURRENT_SOURCE_DIR}/toolchain"
  COMMAND "${CMAKE_COMMAND}" --build . --target install
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/toolchain"
)
# 
# if(NOT ARDUINO18_SDK_PATH)
#   message("ARDUINO18_SDK_PATH not set; Arduino will be assembled from git submodule")
#   add_subdirectory(toolchain/arduino)
# endif()
# 
# if(NOT CHIPKIT_PATH)
#   message("CHIPKIT_PATH not set; chipKIT will be assembled from git submodule")
#   message(AUTHOR_WARNING "TODO: search for chipkit in arduino folder")
#   add_subdirectory(toolchain/chipkit)
# endif()
# 
# add_custom_command(
#   OUTPUT ${
# # arduino-cmake seems to need these two lines set in the top-level CMakeLists.txt
# set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/cmake/arduino-cmake/cmake/ArduinoToolchain.cmake)
# project(dummy)
# 
# add_subdirectory(firmware/cyton)
# # 
# # #set(CHIPKIT_VERSION 2.0.3 CACHE STRING Version of chipKIT-core toolchain to build with)
# # #set(ARDUINO_CYTON_VERSION 1.8.5 CACHE STRING Version of Arduino to build Cyton firmware with)
# # #
# # #
# # #link_directories(${CMAKE_SOURCE_DIR}/submodules)
# # #
# # #set(ARDUINO_VERSION ${ARDUINO_CYTON_VERSION})
# # #
# # #include(cmake/chipkit-arduino.cmake)
# # #
# # #set(cytonboard_BOARD openbci)
# # #set(cytonboard_BOARD_CPU 32MX250F128B)
# # #set(cytonboard_LIBRARY OpenBCI_32bit_Library)
# # #set(cytonboard_EXAMPLE DefaultBoard)
# # #
# # #set(CMAKE_TOOLCHAIN_FILE cmake/arduino-cmake/cmake/ArduinoToolchain.cmake)
# # #project(cytonboard C CXX ASM)
# # #print_board_list()
# # #generate_arduino_library_example(cytonboard)
