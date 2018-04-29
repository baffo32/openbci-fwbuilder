project(chipKIT-core)

set(CHIPKIT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/chipKIT-core")

# extract version and platform from ant build files
ant_property(CHIPKIT_VERSION git.revision "${CHIPKIT_SOURCE_DIR}" git.revision -Dgit.present=1)
ant_property(CHIPKIT_PLATFORM platform "${CHIPKIT_SOURCE_DIR}" -lib "${CHIPKIT_SOURCE_DIR}/antlib")

set(CHIPKIT_BINARY_DIR "${PROJECT_BINARY_DIR}/chipKIT-core-${CHIPKIT_VERSION}")

set(CHIPKIT_VERSION_FILE version.properties)

# copy over
git_submodule_to_build("chipKIT-core ${CHIPKIT_VERSION}" HEAD "${CHIPKIT_SOURCE_DIR}" "${CHIPKIT_BINARY_DIR}" "${CHIPKIT_VERSION_FILE}")

# set folders
set(CHIPKIT_BUILD_PATH "${CHIPKIT_BINARY_DIR}/dist/${CHIPKIT_PLATFORM}/chipkit-core/pic32")
set(CHIPKIT_INSTALL_PATH "${CMAKE_BINARY_DIR}/chipKIT-core-${CHIPKIT_VERSION}")

# assemble chipkit
add_custom_command(
  OUTPUT "${CHIPKIT_BUILD_PATH}"
  COMMAND "${ANT_EXECUTABLE}" build
  COMMAND "${CMAKE_COMMAND}" -E touch "${CHIPKIT_BUILD_PATH}"
  DEPENDS "${CHIPKIT_BINARY_DIR}/${CHIPKIT_VERSION_FILE}"
  WORKING_DIRECTORY "${CHIPKIT_BINARY_DIR}/"
  COMMENT "Building chipKIT-core ${CHIPKIT_PLATFORM} ${CHIPKIT_VERSION}"
)
add_custom_target(chipKIT ALL DEPENDS ${CHIPKIT_BUILD_PATH})
install(DIRECTORY "${CHIPKIT_BUILD_PATH}/" DESTINATION "${CHIPKIT_INSTALL_PATH}")

