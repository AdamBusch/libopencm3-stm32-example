.extern bootloader_main
.extern application_address

.equ RAM_START,         0x20000000
.equ SCB_VTOR,          0xE000ED08

.thumb
.thumb_func
.syntax unified
.section .text
.global reset_handler


reset_handler:
    ldr r0, =application_address
    ldr r1, =SCB_VTOR
    str r0, [r1]
    dsb
    ldr sp, [r0, #0]
    ldr r0, [r0, #4]
    bx r0

    b bootloader_main
