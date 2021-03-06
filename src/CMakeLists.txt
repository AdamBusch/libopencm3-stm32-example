cmake_minimum_required(VERSION 3.10)


set(BOOT_TARGET ${PROJECT_NAME}_BOOT)
set(APP_TARGET ${PROJECT_NAME}_APP)
set(COMBINED_TARGET ${PROJECT_NAME}_COMB)

add_executable(${APP_TARGET}.elf app.c)
target_link_libraries(${APP_TARGET}.elf opencm3_stm32f4)
set_target_properties(${APP_TARGET}.elf
        PROPERTIES
        LINK_FLAGS -T${CMAKE_SOURCE_DIR}/linker/application_config.ld
        )
display_sizes(${APP_TARGET}.elf)
create_hex_file(${APP_TARGET}.elf ${APP_TARGET})


add_executable(${BOOT_TARGET}.elf bootloader.c boot_startup.s)
target_link_libraries(${BOOT_TARGET}.elf opencm3_stm32f4)
set_target_properties(${BOOT_TARGET}.elf
        PROPERTIES
        LINK_FLAGS -T${CMAKE_SOURCE_DIR}/linker/bootloader_config.ld
        )
display_sizes(${BOOT_TARGET}.elf)
create_hex_file(${BOOT_TARGET}.elf ${BOOT_TARGET})

add_custom_command(
        OUTPUT ${COMBINED_TARGET}.hex
        COMMAND type ${BOOT_TARGET}.hex ${APP_TARGET}.hex > ${COMBINED_TARGET}.hex
        DEPENDS ${BOOT_TARGET}.hex ${APP_TARGET}.hex)

add_custom_target(${COMBINED_TARGET} DEPENDS ${COMBINED_TARGET}.hex)