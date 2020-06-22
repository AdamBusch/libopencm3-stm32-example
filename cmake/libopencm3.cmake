cmake_minimum_required(VERSION 3.10)

add_definitions(-DSTM32F4)

set(LIBOPENCM3_DIR "${CMAKE_SOURCE_DIR}/libopencm3")

include_directories(${LIBOPENCM3_DIR}/include)

link_directories(${LIBOPENCM3_DIR}/lib)

add_custom_target(libopencm3 make TARGETS=stm32/f4
        WORKING_DIRECTORY ${LIBOPENCM3_DIR})