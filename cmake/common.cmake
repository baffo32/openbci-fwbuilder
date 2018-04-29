# disable in-source builds (from opencv)
if(" ${CMAKE_SOURCE_DIR}" STREQUAL " ${CMAKE_BINARY_DIR}")
  message(FATAL_ERROR "In-source builds are not allowed.  Make a separate directory.")
endif()

# path to this include file
set(LOCAL_CMAKE_DIR "${CMAKE_MODULE_PATH}")

# sets CMAKE_MINIMUM_REQUIRED_VERSION
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# set variable to a command-line that will build a subdirectory as a cmake tree
macro(cmake_subbuild_command variable dir)
  file(MAKE_DIRECTORY "${CMAKE_CURRENT_BUILD_DIR}/${dir}")
  set(${variable} "${CMAKE_COMMAND}" --build "${CMAKE_CURRENT_SOURCE_DIR}/${dir}")
endmacro()
