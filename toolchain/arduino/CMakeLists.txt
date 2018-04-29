project(Arduino)

macro(build_arduino rev)
  
  set(ARDUINO_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Arduino")
  set(ARDUINO_BINARY_DIR "${PROJECT_BINARY_DIR}/Arduino")
  
  set(ARDUINO_VERSIONFILE build/shared/revisions.txt)
  
  # extract staging folder from ant build file 
  ant_property(ARDUINO_STAGING_FOLDER staging_folder "${ARDUINO_SOURCE_DIR}/build")

  # set version
  set(ARDUINO_VERSION "${rev}")
  message(STATUS "Generating target for Arduino ${ARDUINO_STAGING_FOLDER} ${ARDUINO_VERSION}")
  
  # copy over
  git_submodule_to_build("Arduino" "${ARDUINO_VERSION}" "${ARDUINO_SOURCE_DIR}" "${ARDUINO_BINARY_DIR}" "${ARDUINO_VERSIONFILE}")
  
  # set folders
  set(ARDUINO_BUILD_PATH "${ARDUINO_BINARY_DIR}/build/${ARDUINO_STAGING_FOLDER}/work")
  set(ARDUINO_INSTALL_PATH "${CMAKE_BINARY_DIR}/Arduino-${ARDUINO_STAGING_FOLDER}-${ARDUINO_VERSION}")
  
  # assemble sdk
  add_custom_target(
    OUTPUT "${ARDUINO_BUILD_PATH}"
    COMMAND "${CMAKE_COMMAND}" -E copy "${CMAKE_CURRENT_SOURCE_DIR}/quick-build.xml" .
    COMMAND "${ANT_EXECUTABLE}" -buildfile quick-build.xml
    COMMAND "${CMAKE_COMMAND}" -E touch "${ARDUINO_BUILD_PATH}"
    DEPENDS "${ARDUINO_BINARY_DIR}/${ARDUINO_VERSIONFILE}"
    WORKING_DIRECTORY "${ARDUINO_BINARY_DIR}/build"
    COMMENT "Building Arduino environment ${ARDUINO_VERSION}"
  )
  add_custom_target("Arduino-${ARDUINO_VERSION}" ALL DEPENDS "${ARDUINO_BUILD_PATH}")
  install(DIRECTORY "${ARDUINO_BUILD_PATH}/" DESTINATION "${ARDUINO_INSTALL_PATH}")
endmacro()

build_arduino(1.8.5-0-g433fbeb29)
