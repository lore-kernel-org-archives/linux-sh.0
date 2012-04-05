From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Apr 2012 21:41:20 +0000
Subject: Re: [PATCH 3/6] ARM: mach-shmobile: armadillo800eva: add support LCDC0
Message-Id: <20120405214119.GC32550@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87lima4lxy.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lima4lxy.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

I ran across a few minor problems after apply your series on top
of the current linux/master -- "Merge tag 'for_linus-3.4-rc2' of
git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb"
(6c216ec636f75d834461be15f83ec41a6759bd2b).

On Thu, Apr 05, 2012 at 01:33:50AM -0700, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c |  112 ++++++++++++++++++++++++
>  1 files changed, 112 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 1ca153b..58d2ba1 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -25,6 +25,7 @@
>  #include <linux/irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/gpio.h>
> +#include <linux/videodev2.h>
>  #include <mach/common.h>

Locally, I added #include <mach/irqs.h> here in order to have evt2irq()
which is used further down, though I am unsure if that is the correct course
of action.

This appears to be the first patch in your series that makes use of
evt2irq(). It is also used in the sh_eth and ST1232 patches in your series.

evt2irq() was moved from arch/sh/include/asm/irq.h
toinclude/linux/sh_intc.h by "sh: intc: unify evt2irq/irq2evt macros for sh
and arm" (7f1e76370b717be264f0af54719182a96fb8f36d). The same patch
includes linux/sh_intc.h in arch/arm/mach-shmobile/include/mach/irqs.h.

>  #include <asm/page.h>
>  #include <asm/mach-types.h>
> @@ -33,6 +34,7 @@
>  #include <asm/mach/time.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <mach/r8a7740.h>
> +#include <video/sh_mobile_lcdc.h>
>  
>  /*
>   * CON1		Camera Module
> @@ -92,10 +94,66 @@
>   *-----------+---------------+----------------------------
>   */
>  
> +/* LCDC */
> +static struct fb_videomode lcdc0_mode = {
> +	.name		= "AMPIER/AM-800480",
> +	.xres		= 800,
> +	.yres		= 480,
> +	.left_margin	= 88,
> +	.right_margin	= 40,
> +	.hsync_len	= 128,
> +	.upper_margin	= 20,
> +	.lower_margin	= 5,
> +	.vsync_len	= 5,
> +	.sync		= 0,
> +};
> +
> +static struct sh_mobile_lcdc_info lcdc0_info = {
> +	.clock_source	= LCDC_CLK_BUS,
> +	.ch[0] = {
> +		.chan		= LCDC_CHAN_MAINLCD,
> +		.fourcc		= V4L2_PIX_FMT_RGB565,
> +		.interface_type	= RGB24,
> +		.clock_divider	= 5,
> +		.flags		= 0,
> +		.lcd_cfg	= &lcdc0_mode,
> +		.num_cfg	= 1,

.lcd_cfg was changes to .lcd_modes and .num_cfg was changed to .num_modes
by "fbdev: sh_mobile_lcdc: Rename (lcd|num)_cfg (lcd|num)_modes"
(93ff259846a774ff37dca54792c5a3a6425882c0). I think it is sufficient to
just change the names above accordingly.

> +		.lcd_size_cfg = {
> +			.width	= 111,
> +			.height = 68,
> +		},

.lcd_size_cfg and .board_cfg were merged into .panel_cfg
by "fbdev: sh_mobile_lcdc: Merge board_cfg and lcd_size_cfg into panel_cfg"
(afaad83b9c0d24eac88535cc5a8c6019f0c45bcb). I think it is sufficient to
change  .lcd_size_cfg to .panel_cfg above.

> +	},
> +};
> +
> +static struct resource lcdc0_resources[] = {
> +	[0] = {
> +		.name	= "LCD0",
> +		.start	= 0xfe940000,
> +		.end	= 0xfe943fff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= intcs_evt2irq(0x580),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device lcdc0_device = {
> +	.name		= "sh_mobile_lcdc_fb",
> +	.num_resources	= ARRAY_SIZE(lcdc0_resources),
> +	.resource	= lcdc0_resources,
> +	.id		= 0,
> +	.dev	= {
> +		.platform_data	= &lcdc0_info,
> +		.coherent_dma_mask = ~0,
> +	},
> +};
> +
>  /*
>   * board devices
>   */
>  static struct platform_device *eva_devices[] __initdata = {
> +	&lcdc0_device,
>  };
>  
>  /*
> @@ -109,6 +167,53 @@ static void __init eva_init(void)
>  	gpio_request(GPIO_FN_SCIFA1_RXD, NULL);
>  	gpio_request(GPIO_FN_SCIFA1_TXD, NULL);
>  
> +	/* LCDC0 */
> +	gpio_request(GPIO_FN_LCDC0_SELECT,	NULL);
> +	gpio_request(GPIO_FN_LCD0_D0,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D1,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D2,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D3,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D4,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D5,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D6,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D7,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D8,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D9,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D10,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D11,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D12,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D13,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D14,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D15,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D16,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D17,		NULL);
> +	gpio_request(GPIO_FN_LCD0_D18_PORT40,	NULL);
> +	gpio_request(GPIO_FN_LCD0_D19_PORT4,	NULL);
> +	gpio_request(GPIO_FN_LCD0_D20_PORT3,	NULL);
> +	gpio_request(GPIO_FN_LCD0_D21_PORT2,	NULL);
> +	gpio_request(GPIO_FN_LCD0_D22_PORT0,	NULL);
> +	gpio_request(GPIO_FN_LCD0_D23_PORT1,	NULL);
> +	gpio_request(GPIO_FN_LCD0_DCK,		NULL);
> +	gpio_request(GPIO_FN_LCD0_VSYN,		NULL);
> +	gpio_request(GPIO_FN_LCD0_HSYN,		NULL);
> +	gpio_request(GPIO_FN_LCD0_DISP,		NULL);
> +	gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
> +
> +	gpio_request(GPIO_PORT61, NULL); /* LCDDON */
> +	gpio_direction_output(GPIO_PORT61, 1);
> +
> +	gpio_request(GPIO_PORT202, NULL); /* LCD0_LED_CONT */
> +	gpio_direction_output(GPIO_PORT202, 0);
> +
> +	/*
> +	 * CAUTION
> +	 *
> +	 * DBGMD/LCDC0/FSIA MUX
> +	 * DBGMD_SELECT_B should be set after setting PFC Function.
> +	 */
> +	gpio_request(GPIO_PORT176, NULL);
> +	gpio_direction_output(GPIO_PORT176, 1);
> +
>  #ifdef CONFIG_CACHE_L2X0
>  	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
>  	l2x0_init(__io(0xf0002000), 0x40440000, 0x82000fff);
> @@ -138,6 +243,13 @@ static void __init eva_earlytimer_init(void)
>  
>  static void __init eva_add_early_devices(void)
>  {
> +
> +	/*
> +	 *  The default 2MB size isn't
> +	 * enough to allocate the frame buffer memory.
> +	 */
> +	init_consistent_dma_size(12 << 20);
> +
>  	r8a7740_add_early_devices();
>  
>  	/* override timer setup with board-specific code */
> -- 
> 1.7.5.4
> 
