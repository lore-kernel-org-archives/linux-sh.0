From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 23 Oct 2014 10:24:59 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: sh73a0: Remove wrapper sh73a0_init_delay()
Message-Id: <7577613.eTXUjXheNf@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533092-23555-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370533092-23555-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 17 October 2014 14:24:39 Geert Uytterhoeven wrote:
> sh73a0_init_delay() just calls shmobile_init_delay(), hence replace
> calls to it by direct calls to shmobile_init_delay().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-shmobile/setup-sh73a0.c | 9 ++-------
>  arch/arm/mach-shmobile/sh73a0.h       | 1 -
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c
> b/arch/arm/mach-shmobile/setup-sh73a0.c index
> b7bd8e5096687960..0754b121ae836e75 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -740,17 +740,12 @@ void __init sh73a0_add_standard_devices(void)
>  			    ARRAY_SIZE(sh73a0_late_devices));
>  }
> 
> -void __init sh73a0_init_delay(void)
> -{
> -	shmobile_init_delay();
> -}
> -
>  /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
>  void __init __weak sh73a0_register_twd(void) { }
> 
>  void __init sh73a0_earlytimer_init(void)
>  {
> -	sh73a0_init_delay();
> +	shmobile_init_delay();
>  	sh73a0_clock_init();
>  	shmobile_earlytimer_init();
>  	sh73a0_register_twd();
> @@ -783,7 +778,7 @@ static const char *sh73a0_boards_compat_dt[] __initdata
> = { DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
> .smp		= smp_ops(sh73a0_smp_ops),
>  	.map_io		= sh73a0_map_io,
> -	.init_early	= sh73a0_init_delay,
> +	.init_early	= shmobile_init_delay,
>  	.init_machine	= sh73a0_add_standard_devices_dt,
>  	.init_late	= shmobile_init_late,
>  	.dt_compat	= sh73a0_boards_compat_dt,
> diff --git a/arch/arm/mach-shmobile/sh73a0.h
> b/arch/arm/mach-shmobile/sh73a0.h index 359b582dc270d6a9..f037c64b14fc0767
> 100644
> --- a/arch/arm/mach-shmobile/sh73a0.h
> +++ b/arch/arm/mach-shmobile/sh73a0.h
> @@ -71,7 +71,6 @@ enum {
>  #define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
>  #define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
> 
> -extern void sh73a0_init_delay(void);
>  extern void sh73a0_init_irq(void);
>  extern void sh73a0_init_irq_dt(void);
>  extern void sh73a0_map_io(void);

-- 
Regards,

Laurent Pinchart

