
# Some CMakeLists techniques taken from the opencv project
# ---

# Disable in-source builds to prevent source tree corruption.
if(" ${CMAKE_SOURCE_DIR}" STREQUAL " ${CMAKE_BINARY_DIR}")
    message(FATAL_ERROR "
FATAL: In-source builds are not allowed.
       You should create a separate directory for build files.
")
endif()

find_package(Git)
if(NOT GIT_FOUND)
  message(FATAL_ERROR "Git is required to pull in submodules")
endif()

execute_process(
  COMMAND ${GIT_EXECUTABLE} submodule update --init
  WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)

cmake_minimum_required(VERSION 3.0)

include(${CMAKE_SOURCE_DIR}/cmake/ApacheAnt.cmake)

if(NOT ANT_EXECUTABLE)
  message(FATAL_ERROR "Ant is required to build chipKIT-core and Arduino.")
endif()

add_subdirectory(toolchain/chipkit)
add_subdirectory(toolchain/arduino)

#set(CHIPKIT_VERSION 2.0.3 CACHE STRING Version of chipKIT-core toolchain to build with)
#set(ARDUINO_CYTON_VERSION 1.8.5 CACHE STRING Version of Arduino to build Cyton firmware with)
#
#
#link_directories(${CMAKE_SOURCE_DIR}/submodules)
#
#set(ARDUINO_VERSION ${ARDUINO_CYTON_VERSION})
#
#include(cmake/chipkit-arduino.cmake)
#
#set(cytonboard_BOARD openbci)
#set(cytonboard_BOARD_CPU 32MX250F128B)
#set(cytonboard_LIBRARY OpenBCI_32bit_Library)
#set(cytonboard_EXAMPLE DefaultBoard)
#
#project(cytonboard C CXX ASM)
#generate_arduino_library_example(cytonboard)
