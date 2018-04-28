#set(ARDUINO_SDK_PATH ${ARDUINO_SDK_DIR})

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_SOURCE_DIR}/cmake/arduino-cmake/cmake/ArduinoToolchain.cmake)

#set(PLATFORM_PATH ${CHIPKIT_PATH})
#set(PLATFORM_ARCHITECTURE ${CHIPKIT_ARCH})

project(cyton C CXX ASM)

print_board_list()

set(cyton_BOARD openbci)
set(cyton_BOARD_CPU 32MX250F128B)
set(cyton_LIBRARY ${CMAKE_CURRENT_SOURCE_DIR}/OpenBCI_32bit_Library)
set(cyton_EXAMPLE DefaultBoard)

generate_arduino_library_example(cyton)
