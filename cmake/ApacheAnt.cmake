file(TO_CMAKE_PATH "$ENV{ANT_DIR}" ANT_DIR_ENV_PATH)
file(TO_CMAKE_PATH "$ENV{ProgramFiles}" ProgramFiles_ENV_PATH)

if(CMAKE_HOST_WIN32)
  set(ANT_NAME ant.bat)
else()
  set(ANT_NAME ant)
endif()

find_program(ANT_EXECUTABLE NAMES ${ANT_NAME}
  PATHS "${ANT_DIR_ENV_PATH}/bin" "${ProgramFiles_ENV_PATH}/apache-ant/bin"
  NO_DEFAULT_PATH
  )

find_program(ANT_EXECUTABLE NAMES ${ANT_NAME})

if(ANT_EXECUTABLE)
  execute_process(COMMAND ${ANT_EXECUTABLE} -version
    RESULT_VARIABLE ANT_ERROR_LEVEL
    OUTPUT_VARIABLE ANT_VERSION_FULL
    OUTPUT_STRIP_TRAILING_WHITESPACE)
  if (ANT_ERROR_LEVEL)
    unset(ANT_EXECUTABLE)
    unset(ANT_EXECUTABLE CACHE)
  else()
    string(REGEX MATCH "[0-9]+.[0-9]+.[0-9]+" ANT_VERSION "${ANT_VERSION_FULL}")
    set(ANT_VERSION "${ANT_VERSION}" CACHE INTERNAL "Detected ant vesion")

    message(STATUS "Found apache ant: ${ANT_EXECUTABLE} (${ANT_VERSION})")
  endif()
endif()

macro(ant_property output property path)
  set(buildfile ${CMAKE_CURRENT_BINARY_DIR}/ant-echo-property-${output}.xml)
  set(PROPERTY ${property})
  set(BUILD_DIR ${path})
  configure_file(${CMAKE_SOURCE_DIR}/cmake/ant-echo-property.xml.in ${buildfile} @ONLY)
  execute_process(
    COMMAND ${ANT_EXECUTABLE} ${ARGN} -quiet -silent -buildfile ${buildfile}
    OUTPUT_VARIABLE ${output}
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  message(STATUS "${output}: ${${output}}")
endmacro()
