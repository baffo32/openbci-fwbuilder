project(chipKIT-core)

set(CHIPKIT_ORIGIN_DIR ${CMAKE_CURRENT_SOURCE_DIR}/chipKIT-core)

# rerun cmake if chipkit submodule version changes
configure_file(${CHIPKIT_ORIGIN_DIR}/version.properties ${CMAKE_CURRENT_BINARY_DIR}/version.propertes)

# extract version and platform from ant build files
ant_property(CHIPKIT_VERSION git.revision ${CHIPKIT_ORIGIN_DIR} git.revision -Dgit.present=1)
ant_property(CHIPKIT_PLATFORM platform ${CHIPKIT_ORIGIN_DIR} -lib ${CHIPKIT_ORIGIN_DIR}/antlib)

# update dir building will take place in
set(CHIPKIT_BINARY_DIR ${PROJECT_BINARY_DIR}/chipKIT-core-${CHIPKIT_VERSION})
add_custom_command(
  OUTPUT ${CHIPKIT_BINARY_DIR}
  COMMAND ${GIT_EXECUTABLE} clone ${CHIPKIT_ORIGIN_DIR} ${CHIPKIT_BINARY_DIR}
  DEPENDS ${CHIPKIT_ORIGIN_DIR}
  COMMENT "Cloning chipKIT-core ${CHIPKIT_VERSION}"
)
add_custom_command(
  OUTPUT ${CHIPKIT_BINARY_DIR}/.git/FETCH_HEAD
  COMMAND ${GIT_EXECUTABLE} pull origin +HEAD
  WORKING_DIRECTORY ${CHIPKIT_BINARY_DIR}
  DEPENDS ${CHIPKIT_ORIGIN_DIR}/version.properties ${CHIPKIT_BINARY_DIR}
  COMMENT "Pulling chipKIT-core ${CHIPKIT_VERSION}"
)

# paths to pass to arduino
set(CHIPKIT_ARCH pic32 CACHE INTERNAL "chipKIT architecture")
set(CHIPKIT_PATH ${CHIPKIT_BINARY_DIR}/dist/${CHIPKIT_PLATFORM}/chipkit-core/${CHIPKIT_ARCH} CACHE STRING "Path to chipKIT-core")

add_custom_command(
  OUTPUT ${CHIPKIT_PATH}/cores/${CHIPKIT_ARCH}/chipKITVersion.h
  COMMAND ${ANT_EXECUTABLE} build
  DEPENDS ${CHIPKIT_BINARY_DIR}/.git/FETCH_HEAD
  WORKING_DIRECTORY ${CHIPKIT_BINARY_DIR}/
  COMMENT "Building chipKIT-core ${CHIPKIT_PLATFORM} ${CHIPKIT_VERSION}"
)
add_custom_target(chipKIT DEPENDS ${CHIPKIT_PATH}/cores/${CHIPKIT_ARCH}/chipKITVersion.h)

