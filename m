From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Sep 2014 04:05:42 +0000
Subject: Re: [PATCH 01/03] ARM: shmobile: sh73a0: Introduce generic setup callback
Message-Id: <20140904040539.GB20602@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140904022845.26216.45573.sendpatchset@w520>
In-Reply-To: <20140904022845.26216.45573.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 04, 2014 at 11:28:45AM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Add a generic sh73a0 machine setup callback for the upcoming
> sh73a0 multiplatform case. Cache needs to be configured, and
> legacy clocks must be omitted.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/setup-sh73a0.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2014-09-04 10:46:41.000000000 +0900
> @@ -33,6 +33,7 @@
>  #include <linux/platform_data/sh_ipmmu.h>
>  #include <linux/platform_data/irq-renesas-intc-irqpin.h>
>  
> +#include <asm/hardware/cache-l2x0.h>
>  #include <asm/mach-types.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/arch.h>
> @@ -772,8 +773,6 @@ void __init sh73a0_add_early_devices(voi
>  	shmobile_setup_console();
>  }
>  
> -#ifdef CONFIG_USE_OF
> -

Is moving CONFIG_USE_OF from here to a bit further down intentional?
I'm not sure how it fits with the rest of the patch.

>  void __init sh73a0_add_standard_devices_dt(void)
>  {
>  	/* clocks are setup late during boot in the case of DT */
> @@ -784,6 +783,17 @@ void __init sh73a0_add_standard_devices_
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }
>  
> +#ifdef CONFIG_USE_OF
> +
> +static void __init sh73a0_generic_init(void)
> +{
> +#ifdef CONFIG_CACHE_L2X0
> +	/* Shared attribute override enable, 64K*8way */
> +	l2x0_init(IOMEM(0xf0100000), 0x00400000, 0xc20f0fff);
> +#endif
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}
> +
>  static const char *sh73a0_boards_compat_dt[] __initdata = {
>  	"renesas,sh73a0",
>  	NULL,
> @@ -793,7 +803,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH7
>  	.smp		= smp_ops(sh73a0_smp_ops),
>  	.map_io		= sh73a0_map_io,
>  	.init_early	= sh73a0_init_delay,
> -	.init_machine	= sh73a0_add_standard_devices_dt,
> +	.init_machine	= sh73a0_generic_init,
>  	.init_late	= shmobile_init_late,
>  	.dt_compat	= sh73a0_boards_compat_dt,
>  MACHINE_END
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
