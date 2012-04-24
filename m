From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Apr 2012 23:55:19 +0000
Subject: Re: [PATCH 6/6] ARM: mach-shmobile: kzm9g: add PCF8757 gpio-key
Message-Id: <20120424235518.GE2461@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Apr 22, 2012 at 11:54:14PM -0700, Kuninori Morimoto wrote:
> This patch adds extra GPIO via PCF8757 chip,
> and use it as gpio-key.

Hi Morimoto-san,

I am having a little trouble getting this working on top of 3.4-rc4
with your "[PATCH 0/6] ARM: mach-shmobile: add KZM-A9-GT board support"
series and the rest of this series.

I have enabled INPUT_PCF8574, but perhaps that isn't sufficient?

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-kzm9g.c |   59 ++++++++++++++++++++++++++++++++++
>  1 files changed, 59 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
> index 657ba64..78e9850 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g.c
> @@ -19,9 +19,12 @@
>  
>  #include <linux/delay.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio_keys.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/i2c.h>
> +#include <linux/i2c/pcf857x.h>
> +#include <linux/input.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/sh_mmcif.h>
>  #include <linux/mmc/sh_mobile_sdhi.h>
> @@ -39,6 +42,18 @@
>  #include <asm/mach/arch.h>
>  #include <video/sh_mobile_lcdc.h>
>  
> +/*
> + * external GPIO
> + */
> +#define GPIO_PCF8575_BASE	(GPIO_NR)
> +#define GPIO_PCF8575_PORT10	(GPIO_NR + 8)
> +#define GPIO_PCF8575_PORT11	(GPIO_NR + 9)
> +#define GPIO_PCF8575_PORT12	(GPIO_NR + 10)
> +#define GPIO_PCF8575_PORT13	(GPIO_NR + 11)
> +#define GPIO_PCF8575_PORT14	(GPIO_NR + 12)
> +#define GPIO_PCF8575_PORT15	(GPIO_NR + 13)
> +#define GPIO_PCF8575_PORT16	(GPIO_NR + 14)
> +
>  /* SMSC 9221 */
>  static struct resource smsc9221_resources[] = {
>  	[0] = {
> @@ -225,7 +240,38 @@ static struct platform_device sdhi0_device = {
>  	},
>  };
>  
> +/* KEY */
> +#define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
> +
> +static struct gpio_keys_button gpio_buttons[] = {
> +	GPIO_KEY(KEY_BACK,	GPIO_PCF8575_PORT10,	"SW3"),
> +	GPIO_KEY(KEY_RIGHT,	GPIO_PCF8575_PORT11,	"SW2-R"),
> +	GPIO_KEY(KEY_LEFT,	GPIO_PCF8575_PORT12,	"SW2-L"),
> +	GPIO_KEY(KEY_ENTER,	GPIO_PCF8575_PORT13,	"SW2-P"),
> +	GPIO_KEY(KEY_UP,	GPIO_PCF8575_PORT14,	"SW2-U"),
> +	GPIO_KEY(KEY_DOWN,	GPIO_PCF8575_PORT15,	"SW2-D"),
> +	GPIO_KEY(KEY_HOME,	GPIO_PCF8575_PORT16,	"SW1"),
> +};
> +
> +static struct gpio_keys_platform_data gpio_key_info = {
> +	.buttons	= gpio_buttons,
> +	.nbuttons	= ARRAY_SIZE(gpio_buttons),
> +	.poll_interval	= 250, /* poling at this point */
> +};
> +
> +static struct platform_device gpio_keys_device = {
> +	/* gpio-pcf857x.c driver doesn't support gpio_to_irq() */
> +	.name	= "gpio-keys-polled",
> +	.dev	= {
> +		.platform_data  = &gpio_key_info,
> +	},
> +};
> +
>  /* I2C */
> +static struct pcf857x_platform_data pcf8575_pdata = {
> +	.gpio_base	= GPIO_PCF8575_BASE,
> +};
> +
>  static struct i2c_board_info i2c1_devices[] = {
>  	{
>  		I2C_BOARD_INFO("st1232-ts", 0x55),
> @@ -233,12 +279,20 @@ static struct i2c_board_info i2c1_devices[] = {
>  	},
>  };
>  
> +static struct i2c_board_info i2c3_devices[] = {
> +	{
> +		I2C_BOARD_INFO("pcf8575", 0x20),
> +		.platform_data = &pcf8575_pdata,
> +	},
> +};
> +
>  static struct platform_device *kzm_devices[] __initdata = {
>  	&smsc_device,
>  	&usb_host_device,
>  	&lcdc_device,
>  	&mmc_device,
>  	&sdhi0_device,
> +	&gpio_keys_device,
>  };
>  
>  /*
> @@ -373,12 +427,17 @@ static void __init kzm_init(void)
>  	gpio_request(GPIO_PORT15, NULL);
>  	gpio_direction_output(GPIO_PORT15, 1); /* power */
>  
> +	/* I2C 3 */
> +	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
> +	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
> +
>  #ifdef CONFIG_CACHE_L2X0
>  	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
>  	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
>  #endif
>  
>  	i2c_register_board_info(1, i2c1_devices, ARRAY_SIZE(i2c1_devices));
> +	i2c_register_board_info(3, i2c3_devices, ARRAY_SIZE(i2c3_devices));
>  
>  	sh73a0_add_standard_devices();
>  	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
