# ---
# Some CMakeLists techniques taken from the opencv project
# ---

# Disable in-source builds to prevent source tree corruption.
if(" ${CMAKE_SOURCE_DIR}" STREQUAL " ${CMAKE_BINARY_DIR}")
    message(FATAL_ERROR "
FATAL: In-source builds are not allowed.
       You should create a separate directory for build files.
")
endif()

cmake_minimum_required(VERSION 3.0)

include(cmake/chipkit-arduino.cmake)

link_directories(${CMAKE_SOURCE_DIR}/submodules)

set(cytonboard_BOARD OpenBCI 32)
set(cytonboard_LIBRARY OpenBCI_32bit_Library)
set(cytonboard_EXAMPLE DefaultBoard)

project(cytonboard C CXX ASM)
#generate_arduino_library_example(cytonboard)
