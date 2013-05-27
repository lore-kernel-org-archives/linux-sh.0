From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 May 2013 09:54:52 +0000
Subject: Re: [PATCH 1/2 v3] ARM: shmobile: r8a7778: add __initdata on resource and device data
Message-Id: <20130527095450.GB31428@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwrh8cqa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mwrh8cqa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, May 26, 2013 at 05:53:37PM -0700, Kuninori Morimoto wrote:
> These data will be kmemdup()'ed on
> platform_device_add_resources() and platform_device_add_data()

Thanks, queued up for v3.11 in the pinmux branch.

I added it there as that is the branch which includes
all the code that this patch modifies.

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - no change, but become 1st patch
> 
>  arch/arm/mach-shmobile/setup-r8a7778.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index a02efce..9191acc 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -47,7 +47,7 @@
>  	.irqs		= SCIx_IRQ_MUXED(irq),			\
>  }
>  
> -static struct plat_sci_port scif_platform_data[] = {
> +static struct plat_sci_port scif_platform_data[] __initdata = {
>  	SCIF_INFO(0xffe40000, gic_iid(0x66)),
>  	SCIF_INFO(0xffe41000, gic_iid(0x67)),
>  	SCIF_INFO(0xffe42000, gic_iid(0x68)),
> @@ -57,24 +57,24 @@ static struct plat_sci_port scif_platform_data[] = {
>  };
>  
>  /* TMU */
> -static struct resource sh_tmu0_resources[] = {
> +static struct resource sh_tmu0_resources[] __initdata = {
>  	DEFINE_RES_MEM(0xffd80008, 12),
>  	DEFINE_RES_IRQ(gic_iid(0x40)),
>  };
>  
> -static struct sh_timer_config sh_tmu0_platform_data = {
> +static struct sh_timer_config sh_tmu0_platform_data __initdata = {
>  	.name			= "TMU00",
>  	.channel_offset		= 0x4,
>  	.timer_bit		= 0,
>  	.clockevent_rating	= 200,
>  };
>  
> -static struct resource sh_tmu1_resources[] = {
> +static struct resource sh_tmu1_resources[] __initdata = {
>  	DEFINE_RES_MEM(0xffd80014, 12),
>  	DEFINE_RES_IRQ(gic_iid(0x41)),
>  };
>  
> -static struct sh_timer_config sh_tmu1_platform_data = {
> +static struct sh_timer_config sh_tmu1_platform_data __initdata = {
>  	.name			= "TMU01",
>  	.channel_offset		= 0x10,
>  	.timer_bit		= 1,
> @@ -90,7 +90,7 @@ static struct sh_timer_config sh_tmu1_platform_data = {
>  		sizeof(sh_tmu##idx##_platform_data))
>  
>  /* Ether */
> -static struct resource ether_resources[] = {
> +static struct resource ether_resources[] __initdata = {
>  	DEFINE_RES_MEM(0xfde00000, 0x400),
>  	DEFINE_RES_IRQ(gic_iid(0x89)),
>  };
> @@ -104,17 +104,17 @@ void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
>  }
>  
>  /* PFC/GPIO */
> -static struct resource pfc_resources[] = {
> +static struct resource pfc_resources[] __initdata = {
>  	DEFINE_RES_MEM(0xfffc0000, 0x118),
>  };
>  
>  #define R8A7778_GPIO(idx)						\
> -static struct resource r8a7778_gpio##idx##_resources[] = {		\
> +static struct resource r8a7778_gpio##idx##_resources[] __initdata = {	\
>  	DEFINE_RES_MEM(0xffc40000 + 0x1000 * (idx), 0x30),		\
>  	DEFINE_RES_IRQ(gic_iid(0x87)),					\
>  };									\
>  									\
> -static struct gpio_rcar_config r8a7778_gpio##idx##_platform_data = {	\
> +static struct gpio_rcar_config r8a7778_gpio##idx##_platform_data __initdata = { \
>  	.gpio_base	= 32 * (idx),					\
>  	.irq_base	= GPIO_IRQ_BASE(idx),				\
>  	.number_of_pins	= 32,						\
> @@ -150,7 +150,7 @@ void __init r8a7778_pinmux_init(void)
>  }
>  
>  /* SDHI */
> -static struct resource sdhi_resources[] = {
> +static struct resource sdhi_resources[] __initdata = {
>  	/* SDHI0 */
>  	DEFINE_RES_MEM(0xFFE4C000, 0x100),
>  	DEFINE_RES_IRQ(gic_iid(0x77)),
> @@ -197,12 +197,12 @@ void __init r8a7778_add_standard_devices(void)
>  	r8a7778_register_tmu(1);
>  }
>  
> -static struct renesas_intc_irqpin_config irqpin_platform_data = {
> +static struct renesas_intc_irqpin_config irqpin_platform_data __initdata = {
>  	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
>  	.sense_bitfield_width = 2,
>  };
>  
> -static struct resource irqpin_resources[] = {
> +static struct resource irqpin_resources[] __initdata = {
>  	DEFINE_RES_MEM(0xfe78001c, 4), /* ICR1 */
>  	DEFINE_RES_MEM(0xfe780010, 4), /* INTPRI */
>  	DEFINE_RES_MEM(0xfe780024, 4), /* INTREQ */
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
