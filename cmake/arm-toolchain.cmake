set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(ARM_NONE_EABI_TOOLCHAIN_PATH "C:/Program Files (x86)/GNU Arm Embedded Toolchain/9 2020-q2-update/bin")

set(CMAKE_C_COMPILER ${ARM_NONE_EABI_TOOLCHAIN_PATH}/arm-none-eabi-gcc.exe)
set(OBJCOPY ${ARM_NONE_EABI_TOOLCHAIN_PATH}/arm-none-eabi-objcopy.exe)
set(OBJ_SIZE ${ARM_NONE_EABI_TOOLCHAIN_PATH}/arm-none-eabi-size.exe)



function(display_sizes TARGET)
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJ_SIZE} ${TARGET})
endfunction()

function(create_hex_file TARGET OUTPUT)
    add_custom_target(${OUTPUT}.hex ALL DEPENDS ${TARGET} COMMAND ${OBJCOPY} -Oihex ${TARGET} ${OUTPUT}.hex)
endfunction()