set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(OBJCOPY arm-none-eabi-objcopy)
set(OBJ_SIZE arm-none-eabi-size)



function(display_sizes TARGET)
    add_custom_command(TARGET ${TARGET} POST_BUILD COMMAND ${OBJ_SIZE} ${TARGET})
endfunction()

function(create_hex_file TARGET OUTPUT)
    add_custom_target(${OUTPUT}.hex ALL DEPENDS ${TARGET} COMMAND ${OBJCOPY} -Oihex ${TARGET} ${OUTPUT}.hex)
endfunction()