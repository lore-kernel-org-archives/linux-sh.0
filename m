From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 12:07:36 +0000
Subject: Re: [PATCH 3/6] ARM: shmobile: r8a7778: Register SDHI device
Message-Id: <20130418120734.GB13101@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo9denxa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo9denxa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 16, 2013 at 10:17:25PM -0700, Kuninori Morimoto wrote:
> This patch adds SDHI register function which needs id number (= 0/1/2)
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued-up for v3.11 in the soc-r8a7778 branch.

> ---
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   24 ++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> index 68053fc..ae65b45 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> @@ -18,6 +18,7 @@
>  #ifndef __ASM_R8A7778_H__
>  #define __ASM_R8A7778_H__
>  
> +#include <linux/mmc/sh_mobile_sdhi.h>
>  #include <linux/sh_eth.h>
>  
>  extern void r8a7778_add_standard_devices(void);
> @@ -29,5 +30,6 @@ extern void r8a7778_init_irq_dt(void);
>  extern void r8a7778_clock_init(void);
>  extern void r8a7778_init_irq_extpin(int irlm);
>  extern void r8a7778_pinmux_init(void);
> +extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);
>  
>  #endif /* __ASM_R8A7778_H__ */
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index d82954b..4c32784 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -115,6 +115,30 @@ void __init r8a7778_pinmux_init(void)
>  		ARRAY_SIZE(pfc_resources));
>  }
>  
> +/* SDHI */
> +static struct resource sdhi_resources[] = {
> +	/* SDHI0 */
> +	DEFINE_RES_MEM(0xFFE4C000, 0x100),
> +	DEFINE_RES_IRQ(gic_iid(0x77)),
> +	/* SDHI1 */
> +	DEFINE_RES_MEM(0xFFE4D000, 0x100),
> +	DEFINE_RES_IRQ(gic_iid(0x78)),
> +	/* SDHI2 */
> +	DEFINE_RES_MEM(0xFFE4F000, 0x100),
> +	DEFINE_RES_IRQ(gic_iid(0x76)),
> +};
> +
> +void __init r8a7778_sdhi_init(int id,
> +			      struct sh_mobile_sdhi_info *info)
> +{
> +	BUG_ON(id < 0 || id > 2);
> +
> +	platform_device_register_resndata(
> +		&platform_bus, "sh_mobile_sdhi", id,
> +		sdhi_resources + (2 * id), 2,
> +		info, sizeof(*info));
> +}
> +
>  void __init r8a7778_add_standard_devices(void)
>  {
>  	int i;
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
