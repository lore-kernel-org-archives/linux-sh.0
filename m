From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Sep 2014 07:10:02 +0000
Subject: Re: [PATCH v2 03/10] ARM: shmobile: sh73a0: common clock framework board support
Message-Id: <20140904071002.GB9999@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1409649186-1046-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409649186-1046-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 02, 2014 at 11:12:59AM +0200, Ulrich Hecht wrote:
> Adds support for the common clock framework to the KZM9G reference board
> and SH73A0 SoC setup code.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/board-kzm9g-reference.c | 25 +++++++++++++++++++++++++
>  arch/arm/mach-shmobile/setup-sh73a0.c          |  5 ++++-
>  2 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> index d9cdf9a..19b0842 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -30,11 +30,36 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  
> +#include "clock.h"
>  #include "common.h"
>  #include "sh73a0.h"
>  
> +#ifdef CONFIG_COMMON_CLK
> +static const struct clk_name clk_names[] __initconst = {
> +	{ "cmt1", NULL, "sh_cmt.10" },
> +	{ "scifa0", NULL, "sh-sci.0" },
> +	{ "scifa1", NULL, "sh-sci.1" },
> +	{ "scifa2", NULL, "sh-sci.2" },
> +	{ "scifa3", NULL, "sh-sci.3" },
> +	{ "scifa4", NULL, "sh-sci.4" },
> +	{ "scifa5", NULL, "sh-sci.5" },
> +	{ "scifa6", NULL, "sh-sci.6" },
> +	{ "scifa7", NULL, "sh-sci.7" },
> +	{ "scifb", NULL, "sh-sci.8" },
> +	{ "sdhi0", NULL, "ee100000.sd" },
> +	{ "sdhi1", NULL, "ee120000.sd" },
> +	{ "sdhi2", NULL, "ee140000.sd" },
> +	{ "mmcif0", NULL, "e6bd0000.mmc" },
> +	{ "iic0", NULL, "e6820000.i2c" },
> +	{ "iic3", NULL, "e6826000.i2c" },
> +};
> +#endif
> +
>  static void __init kzm_init(void)
>  {
> +#ifdef CONFIG_COMMON_CLK
> +	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
> +#endif
>  	sh73a0_add_standard_devices_dt();
>  

I believe that the above work-around no longer needed since
3c90c55dcde745bed81f6447f24ba96bda43d984 ("drivers: sh: compile
drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI").

>  #ifdef CONFIG_CACHE_L2X0
> diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
> index 0085305..6d73b83 100644
> --- a/arch/arm/mach-shmobile/setup-sh73a0.c
> +++ b/arch/arm/mach-shmobile/setup-sh73a0.c
> @@ -756,7 +756,9 @@ void __init __weak sh73a0_register_twd(void) { }
>  void __init sh73a0_earlytimer_init(void)
>  {
>  	sh73a0_init_delay();
> +#ifndef CONFIG_COMMON_CLK
>  	sh73a0_clock_init();
> +#endif
>  	shmobile_earlytimer_init();
>  	sh73a0_register_twd();
>  }
> @@ -777,8 +779,9 @@ void __init sh73a0_add_early_devices(void)
>  void __init sh73a0_add_standard_devices_dt(void)
>  {
>  	/* clocks are setup late during boot in the case of DT */
> +#ifndef CONFIG_COMMON_CLK
>  	sh73a0_clock_init();
> -
> +#endif
>  	platform_add_devices(sh73a0_devices_dt,
>  			     ARRAY_SIZE(sh73a0_devices_dt));
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> -- 
> 1.8.4.5
> 
