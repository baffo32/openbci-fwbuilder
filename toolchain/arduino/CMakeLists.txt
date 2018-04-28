project(Arduino)

set(ARDUINO_ORIGIN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/Arduino)

# rerun cmake if chipkit submodule version changes
configure_file(${ARDUINO_ORIGIN_DIR}/build/shared/revisions.txt ${CMAKE_CURRENT_BINARY_DIR}/revisions.txt)

# extract staging folder from ant build file; the sdk will be there
ant_property(ARDUINO_STAGING_FOLDER staging_folder ${ARDUINO_ORIGIN_DIR}/build)

# clone dir building will take place in
set(ARDUINO_BINARY_DIR ${PROJECT_BINARY_DIR}/Arduino)
add_custom_command(
  OUTPUT ${ARDUINO_BINARY_DIR}/build/shared/revisions.txt
  COMMAND ${GIT_EXECUTABLE} clone ${ARDUINO_ORIGIN_DIR} ${ARDUINO_BINARY_DIR}
  DEPENDS ${ARDUINO_ORIGIN_DIR}/build/shared/revisions.txt
  COMMENT "Cloning Arduino"
)

# set sdk folder and build it
set(ARDUINO_SDK_DIR ${ARDUINO_BINARY_DIR}/build/${ARDUINO_STAGING_FOLDER}/work)
add_custom_command(
  OUTPUT ${ARDUINO_SDK_DIR}
  COMMAND cp ${CMAKE_CURRENT_SOURCE_DIR}/quick-build.xml .
  COMMAND ${ANT_EXECUTABLE} -buildfile quick-build.xml
  DEPENDS ${ARDUINO_BINARY_DIR}/build/shared/revisions.txt
  WORKING_DIRECTORY ${ARDUINO_BINARY_DIR}/build
  COMMENT "Building Arduino environment"
)
add_custom_target(Arduino DEPENDS ${ARDUINO_SDK_DIR})
