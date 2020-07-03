#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/rcc.h>


#define USER_BUTTON_GPIO_CLOCK RCC_GPIOA
#define USER_BUTTON_GPIO_PORT GPIO_PORT_A_BASE
#define USER_BUTTON_GPIO_PIN GPIO0

#define PCB_LED_GPIO_CLOCK RCC_GPIOG
#define PCB_LED_GPIO_PORT GPIO_PORT_G_BASE
#define GREEN_LED_GPIO_PIN GPIO13
#define RED_LED_GPIO_PIN GPIO14

// Function prototypes
void setup_clocks(void);
void setup_gpio(void);
int main(void);

/*
 *
 */
void setup_clocks(void)
{
    rcc_clock_setup_pll(&rcc_hse_8mhz_3v3[RCC_CLOCK_3V3_168MHZ]);

    rcc_periph_clock_enable(USER_BUTTON_GPIO_CLOCK);
    rcc_periph_clock_enable(PCB_LED_GPIO_CLOCK);
}

void setup_gpio(void)
{
    gpio_mode_setup(PCB_LED_GPIO_PORT, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, GREEN_LED_GPIO_PIN);
    gpio_mode_setup(PCB_LED_GPIO_PORT, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, RED_LED_GPIO_PIN);
}


int main(void)
{

    setup_clocks();
    setup_gpio();

    int i = 0;
    while(1)
    {
        gpio_toggle(PCB_LED_GPIO_PORT, GREEN_LED_GPIO_PIN);
        for(i = 0; i < 18000000; i ++)
                asm("nop");
        while(gpio_get(USER_BUTTON_GPIO_PORT, USER_BUTTON_GPIO_PIN));

    }

    return 1;
}