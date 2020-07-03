cmake_minimum_required(VERSION 3.10)

project(PER_Bootloader
        VERSION 1.0)
enable_language(C ASM)

if(CMAKE_CROSSCOMPILING)
    message(STATUS "Crosscompiling with ${CMAKE_TOOLCHAIN_FILE}")
else()
    message(FATAL_ERROR "Please specify crosscompiling file with -DCMAKE_TOOLCHAIN_FILE=cmake/arm-toolchain.cmake")
endif()

# Common C compilation flags for all *.c files
set(COMMON_C_FLAGS "-lc -lgcc -Os -g \
-Wall -Werror -Wredundant-decls -Wstrict-prototypes \
-fsingle-precision-constant -Wdouble-promotion -Wfloat-conversion \
-fno-common -ffunction-sections -fdata-sections -MD -Wundef")

# Common compile warnings for all gcc compiles
set(COMMON_WARNINGS "-fsingle-precision-constant -Wdouble-promotion -Wfloat-conversion")

# Architecture flags for Cortex-M4 core with hardware FPU
set(CORE_FLAGS "-mthumb -mcpu=cortex-m4")
set(ARCH_FLAGS "${CORE_FLAGS} -mfloat-abi=hard -mfpu=fpv4-sp-d16")

# Common assembly compilation flags for all *.s files
set(CMAKE_ASM_FLAGS "-D__ASSEMBLY__ -g -Fdwarf ${CORE_FLAGS}")

# Global C compile flags
set(CMAKE_C_FLAGS " \
${COMMON_C_FLAGS} \
${COMMON_WARNINGS} \
${ARCH_FLAGS}")

# Setup linker script for our board as well as linker flags for arm-none-eabi-ld
set(CMAKE_EXE_LINKER_FLAGS " \
${ARCH_FLAGS} \
-nostartfiles \
--specs=nano.specs \
--specs=nosys.specs \
-Wl,--start-group -lc -lgcc -Wl,--end-group \
-Wl,--no-wchar-size-warning \
-Wl,--gc-sections")

# Build libraries
include(cmake/libopencm3.cmake)

# Build application source
add_subdirectory(src)







