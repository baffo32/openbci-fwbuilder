include(cmake/chipkit-core.cmake)

#set(PLATFORM_PATH ${CHIPKIT_SOURCE_DIR}/...)
#set(PLATFORM_ARCHITECTURE ${CHIPKIT_ARCH})

set(ARDUINO_SDK_PATH ${CMAKE_SOURCE_DIR}/submodules/Arduino/)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/submodules/arduino-cmake/cmake/ArduinoToolchain.cmake)
