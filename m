From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 03:41:51 +0000
Subject: Re: [PATCH/RFC v2 6/8] ARM: shmobile: add INTC interrupt controllers on sh73a0 in the DT case
Message-Id: <20130213034151.GD30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2013 at 07:38:30PM +0100, Guennadi Liakhovetski wrote:
> Temporary solution to enable INTC controllers on sh73a0 with DT.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Ths should probably be considered a hack / debug patch - until we get 
> proper INTC support in DT on sh73a0. But it was useful for me to get 
> ethernet running on kzm9g-reference.

I will create a topic/kzm9g-reference-rfc branch for this and
other patches that don't seem ready for kzm9g-reference-rfc.

>  arch/arm/mach-shmobile/board-kzm9g-reference.c |    2 +-
>  arch/arm/mach-shmobile/include/mach/common.h   |    1 +
>  arch/arm/mach-shmobile/intc-sh73a0.c           |   24 ++++++++++++++++++------
>  3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> index 9f5cab757..8280d8a 100644
> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
> @@ -109,7 +109,7 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
>  	.map_io		= sh73a0_map_io,
>  	.init_early	= sh73a0_add_early_devices_dt,
>  	.nr_irqs	= NR_IRQS_LEGACY,
> -	.init_irq	= sh73a0_init_irq_dt,
> +	.init_irq	= sh73a0_init_irq_intc_dt,
>  	.init_machine	= kzm_init,
>  	.init_late	= shmobile_init_late,
>  	.init_time	= sh73a0_earlytimer_init,
> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
> index 16dab18..3bd8873 100644
> --- a/arch/arm/mach-shmobile/include/mach/common.h
> +++ b/arch/arm/mach-shmobile/include/mach/common.h
> @@ -36,6 +36,7 @@ extern struct clk sh7372_extal2_clk;
>  
>  extern void sh73a0_init_irq(void);
>  extern void sh73a0_init_irq_dt(void);
> +void __init sh73a0_init_irq_intc_dt(void);
>  extern void sh73a0_map_io(void);
>  extern void sh73a0_earlytimer_init(void);
>  extern void sh73a0_add_early_devices(void);
> diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobile/intc-sh73a0.c
> index 91faba6..209c597 100644
> --- a/arch/arm/mach-shmobile/intc-sh73a0.c
> +++ b/arch/arm/mach-shmobile/intc-sh73a0.c
> @@ -417,16 +417,11 @@ static irqreturn_t sh73a0_pint1_demux(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -void __init sh73a0_init_irq(void)
> +static void __init __sh73a0_init_irq(void)
>  {
> -	void __iomem *gic_dist_base = IOMEM(0xf0001000);
> -	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
>  	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
>  	int k, n;
>  
> -	gic_init(0, 29, gic_dist_base, gic_cpu_base);
> -	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
> -
>  	register_intc_controller(&intcs_desc);
>  	register_intc_controller(&intca_irq_pins_desc);
>  	register_intc_controller(&intc_pint0_desc);
> @@ -461,10 +456,27 @@ void __init sh73a0_init_irq(void)
>  	setup_irq(gic_spi(34), &sh73a0_pint1_cascade);
>  }
>  
> +void __init sh73a0_init_irq(void)
> +{
> +	void __iomem *gic_dist_base = IOMEM(0xf0001000);
> +	void __iomem *gic_cpu_base = IOMEM(0xf0000100);
> +
> +	gic_init(0, 29, gic_dist_base, gic_cpu_base);
> +	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
> +
> +	__sh73a0_init_irq();
> +}
> +
>  #ifdef CONFIG_OF
>  void __init sh73a0_init_irq_dt(void)
>  {
>  	irqchip_init();
>  	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
>  }
> +
> +void __init sh73a0_init_irq_intc_dt(void)
> +{
> +	sh73a0_init_irq_dt();
> +	__sh73a0_init_irq();
> +}
>  #endif
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
