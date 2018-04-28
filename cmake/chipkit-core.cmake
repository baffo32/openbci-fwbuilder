include(cmake/DetectApacheAnt.cmake)

if(NOT ANT_EXECUTABLE)
  message(FATAL_ERROR "Ant is required to build chipKIT-core.")
endif()

set(CHIPKIT_SOURCE_DIR ${CMAKE_SOURCE_DIR}/submodules/chipKIT-core)
set(CHIPKIT_ARCH pic32)

add_custom_command(
  OUTPUT chipKIT_core
  COMMAND ant -Dgit.present=1 build
  DEPENDS ${CHIPKIT_SOURCE_DIR}/version.properties ${CHIPKIT_SOURCE_DIR}/${CHIPKIT_ARCH}/cores/${CHIPKIT_ARCH}/chipKITVersion.h
  WORKING_DIRECTORY ${CHIPKIT_SOURCE_DIR}/
  COMMENT "Building chipKIT-core Arduino platform"
)
add_custom_target(chipKIT DEPENDS chipKIT_core)
