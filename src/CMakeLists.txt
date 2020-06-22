cmake_minimum_required(VERSION 3.10)

file(GLOB C_SOURCES
        *.c
        )

add_executable(${PROJECT_NAME}.elf ${C_SOURCES})
target_link_libraries(${PROJECT_NAME}.elf opencm3_stm32f4)