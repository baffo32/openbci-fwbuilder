project(chipKIT-core)

set(CHIPKIT_ORIGIN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/chipKIT-core)

# rerun cmake if chipkit submodule version changes
configure_file(${CHIPKIT_ORIGIN_DIR}/version.properties ${CMAKE_CURRENT_BINARY_DIR}/version.propertes)

# extract version and platform from ant build files
ant_property(CHIPKIT_VERSION git.revision ${CHIPKIT_ORIGIN_DIR} git.revision -Dgit.present=1)
ant_property(CHIPKIT_PLATFORM platform ${CHIPKIT_ORIGIN_DIR} -lib ${CHIPKIT_ORIGIN_DIR}/antlib)

# clone dir building will take place in
set(CHIPKIT_BINARY_DIR ${PROJECT_BINARY_DIR}/chipKIT-core-${CHIPKIT_VERSION})
add_custom_command(
  OUTPUT ${CHIPKIT_BINARY_DIR}/version.properties
  COMMAND ${GIT_EXECUTABLE} clone ${CHIPKIT_ORIGIN_DIR} ${CHIPKIT_BINARY_DIR}
  DEPENDS ${CHIPKIT_ORIGIN_DIR}/version.properties
  COMMENT "Cloning chipKIT-core ${CHIPKIT_VERSION}"
)

# paths to pass to arduino
set(CHIPKIT_ARCH pic32)
set(CHIPKIT_PATH ${CHIPKIT_SOURCE_DIR}/dist/${CHIPKIT_PLATFORM}/chipkit-core/${CHIPKIT_ARCH})

add_custom_command(
  OUTPUT ${CHIPKIT_PATH}
  COMMAND ${ANT_EXECUTABLE} build
  DEPENDS ${CHIPKIT_BINARY_DIR}/version.properties
  WORKING_DIRECTORY ${CHIPKIT_BINARY_DIR}/
  COMMENT "Building chipKIT-core ${CHIPKIT_PLATFORM} ${CHIPKIT_VERSION}"
)
add_custom_target(chipKIT DEPENDS ${CHIPKIT_PATH})

