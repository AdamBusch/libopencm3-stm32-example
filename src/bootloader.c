#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/rcc.h>

#define USER_BUTTON_GPIO_CLOCK RCC_GPIOA
#define USER_BUTTON_GPIO_PORT GPIO_PORT_A_BASE
#define USER_BUTTON_GPIO_PIN GPIO0

extern void jump_to_app(void);

/*
 * Simple bootloader will wait for the user to press the button to start the app
 */
void bootloader_main(void)
{
    rcc_clock_setup_pll(&rcc_hse_8mhz_3v3[RCC_CLOCK_3V3_168MHZ]);
    rcc_periph_clock_enable(USER_BUTTON_GPIO_CLOCK);

    while(!gpio_get(USER_BUTTON_GPIO_PORT, USER_BUTTON_GPIO_PIN));

    rcc_periph_clock_disable(USER_BUTTON_GPIO_CLOCK);

    jump_to_app();
}