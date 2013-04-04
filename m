From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 04 Apr 2013 14:07:37 +0000
Subject: Re: [PATCH 4/6] ARM: shmobile: r8a7740: Prepare for reference DT setup
Message-Id: <2950740.FQOgZeg6Ce@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1365083144-16085-4-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1365083144-16085-4-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Thursday 04 April 2013 15:45:42 Bastian Hecht wrote:
> We need two steps to prepare for the new Armadillo reference DT board code:
>  - Split the device list into r8a7740_early_devices used by the old platform
> data setup (board-armadillo.c) and r8a7740_devices_dt used by both setup
> variants.
>  - Introduce new r8a7740_init_delay() to be more flexible about calling
>    shmobile_setup_delay().
> 
> This is similar to commit 3b00f9342623a5ebc
> "ARM: shmobile: sh73a0: Do not use early devices with DT reference"
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 ++
>  arch/arm/mach-shmobile/setup-r8a7740.c        |   41 +++++++++++-----------
>  2 files changed, 23 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h
> b/arch/arm/mach-shmobile/include/mach/r8a7740.h index abdc4d4..61df082
> 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
> @@ -533,10 +533,12 @@ enum {
>  };
> 
>  extern void r8a7740_meram_workaround(void);
> +extern void r8a7740_init_delay(void);
>  extern void r8a7740_init_irq(void);
>  extern void r8a7740_map_io(void);
>  extern void r8a7740_add_early_devices(void);
>  extern void r8a7740_add_standard_devices(void);
> +extern void r8a7740_add_standard_devices_dt(void);
>  extern void r8a7740_clock_init(u8 md_ck);
>  extern void r8a7740_pinmux_init(void);
>  extern void r8a7740_pm_init(void);
> diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c
> b/arch/arm/mach-shmobile/setup-r8a7740.c index 228d7ab..ce0d2e6 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7740.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7740.c
> @@ -531,11 +531,7 @@ static struct platform_device ipmmu_device = {
>  	.num_resources  = ARRAY_SIZE(ipmmu_resources),
>  };
> 
> -static struct platform_device *r8a7740_early_devices[] __initdata = {
> -	&irqpin0_device,
> -	&irqpin1_device,
> -	&irqpin2_device,
> -	&irqpin3_device,
> +static struct platform_device *r8a7740_devices_dt[] __initdata = {
>  	&scif0_device,
>  	&scif1_device,
>  	&scif2_device,
> @@ -546,6 +542,13 @@ static struct platform_device *r8a7740_early_devices[]
> __initdata = { &scif7_device,
>  	&scifb_device,
>  	&cmt10_device,
> +};
> +
> +static struct platform_device *r8a7740_early_devices[] __initdata = {
> +	&irqpin0_device,
> +	&irqpin1_device,
> +	&irqpin2_device,
> +	&irqpin3_device,
>  	&tmu00_device,
>  	&tmu01_device,
>  	&tmu02_device,
> @@ -965,6 +968,8 @@ void __init r8a7740_add_standard_devices(void)
>  	/* add devices */
>  	platform_add_devices(r8a7740_early_devices,
>  			    ARRAY_SIZE(r8a7740_early_devices));
> +	platform_add_devices(r8a7740_devices_dt,
> +			    ARRAY_SIZE(r8a7740_devices_dt));
>  	platform_add_devices(r8a7740_late_devices,
>  			     ARRAY_SIZE(r8a7740_late_devices));
> 
> @@ -991,31 +996,27 @@ void __init r8a7740_add_early_devices(void)
>  	shmobile_setup_console();
>  }
> 
> -#ifdef CONFIG_USE_OF
> -
> -void __init r8a7740_add_early_devices_dt(void)
> +void __init r8a7740_init_delay(void)
>  {
>  	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
> +};
> 
> -	early_platform_add_devices(r8a7740_early_devices,
> -				   ARRAY_SIZE(r8a7740_early_devices));
> -
> -	/* setup early console here as well */
> -	shmobile_setup_console();
> +void __init r8a7740_generic_init_early(void)

static void ?

> +{
> +	r8a7740_clock_init(0);
> +	r8a7740_init_delay();
>  }
> 
> +#ifdef CONFIG_USE_OF
> +
>  static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
> { }
>  };
> 
>  void __init r8a7740_add_standard_devices_dt(void)
>  {
> -	/* clocks are setup late during boot in the case of DT */
> -	r8a7740_clock_init(0);
> -
> -	platform_add_devices(r8a7740_early_devices,
> -			    ARRAY_SIZE(r8a7740_early_devices));
> -
> +	platform_add_devices(r8a7740_devices_dt,
> +			    ARRAY_SIZE(r8a7740_devices_dt));
>  	of_platform_populate(NULL, of_default_bus_match_table,
>  			     r8a7740_auxdata_lookup, NULL);
>  }
> @@ -1027,7 +1028,7 @@ static const char *r8a7740_boards_compat_dt[]
> __initdata = {
> 
>  DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
>  	.map_io		= r8a7740_map_io,
> -	.init_early	= r8a7740_add_early_devices_dt,
> +	.init_early	= r8a7740_generic_init_early,
>  	.init_irq	= r8a7740_init_irq,
>  	.init_machine	= r8a7740_add_standard_devices_dt,
>  	.init_time	= shmobile_timer_init,
-- 
Regards,

Laurent Pinchart

