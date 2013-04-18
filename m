From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Apr 2013 12:37:17 +0000
Subject: Re: [PATCH v2 4/6] ARM: shmobile: r8a7740: Add OF support to initialze the GIC
Message-Id: <20130418123717.GJ13101@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1366194847-9879-4-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1366194847-9879-4-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 17, 2013 at 12:34:04PM +0200, Bastian Hecht wrote:
> We add a variant to initalize the interrupt controller in case we describe
> the GIC using the Device Tree and not platform data.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Thanks, queued-up for v3.11 in the r8a7740 branch.

> ---
> v2:
> r8a7740_init_irq_common is static now
> Reordered patch
> 
>  arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
>  arch/arm/mach-shmobile/intc-r8a7740.c         |   24 ++++++++++++++++++------
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
> index abdc4d4..19c0423 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
> @@ -534,6 +534,7 @@ enum {
>  
>  extern void r8a7740_meram_workaround(void);
>  extern void r8a7740_init_irq(void);
> +extern void r8a7740_init_irq_of(void);
>  extern void r8a7740_map_io(void);
>  extern void r8a7740_add_early_devices(void);
>  extern void r8a7740_add_standard_devices(void);
> diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
> index b741c84..8871f77 100644
> --- a/arch/arm/mach-shmobile/intc-r8a7740.c
> +++ b/arch/arm/mach-shmobile/intc-r8a7740.c
> @@ -20,19 +20,15 @@
>  
>  #include <linux/init.h>
>  #include <linux/io.h>
> +#include <linux/irqchip.h>
>  #include <linux/irqchip/arm-gic.h>
>  
> -void __init r8a7740_init_irq(void)
> +static void __init r8a7740_init_irq_common(void)
>  {
> -	void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
> -	void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
>  	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
>  	void __iomem *intc_msk_base = ioremap_nocache(0xe6900040, 0x10);
>  	void __iomem *pfc_inta_ctrl = ioremap_nocache(0xe605807c, 0x4);
>  
> -	/* initialize the Generic Interrupt Controller PL390 r0p0 */
> -	gic_init(0, 29, gic_dist_base, gic_cpu_base);
> -
>  	/* route signals to GIC */
>  	iowrite32(0x0, pfc_inta_ctrl);
>  
> @@ -54,3 +50,19 @@ void __init r8a7740_init_irq(void)
>  	iounmap(intc_msk_base);
>  	iounmap(pfc_inta_ctrl);
>  }
> +
> +void __init r8a7740_init_irq_of(void)
> +{
> +	irqchip_init();
> +	r8a7740_init_irq_common();
> +}
> +
> +void __init r8a7740_init_irq(void)
> +{
> +	void __iomem *gic_dist_base = ioremap_nocache(0xc2800000, 0x1000);
> +	void __iomem *gic_cpu_base = ioremap_nocache(0xc2000000, 0x1000);
> +
> +	/* initialize the Generic Interrupt Controller PL390 r0p0 */
> +	gic_init(0, 29, gic_dist_base, gic_cpu_base);
> +	r8a7740_init_irq_common();
> +}
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
