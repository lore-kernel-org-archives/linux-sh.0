From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 05 Nov 2014 15:49:11 +0000
Subject: Re: [PATCH v3 6/7] ARM: shmobile: sh73a0: disable legacy clock initialization
Message-Id: <1543605.yENia7DqG9@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Tuesday 28 October 2014 18:02:15 Ulrich Hecht wrote:
> Disables sh73a0_clock_init() if CCF is enabled.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-shmobile/setup-sh73a0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c
> b/arch/arm/mach-shmobile/setup-sh73a0.c index 2955a08..3134bc1 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -742,7 +742,9 @@ void __init __weak sh73a0_register_twd(void) { }
>  void __init sh73a0_earlytimer_init(void)
>  {
>  	shmobile_init_delay();
> +#ifndef CONFIG_COMMON_CLK
>  	sh73a0_clock_init();
> +#endif
>  	shmobile_earlytimer_init();
>  	sh73a0_register_twd();
>  }
> @@ -761,8 +763,9 @@ void __init sh73a0_add_early_devices(void)
>  void __init sh73a0_add_standard_devices_dt(void)
>  {
>  	/* clocks are setup late during boot in the case of DT */
> +#ifndef CONFIG_COMMON_CLK
>  	sh73a0_clock_init();
> -
> +#endif
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  }

-- 
Regards,

Laurent Pinchart

