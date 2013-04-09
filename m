From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 07:59:39 +0000
Subject: Re: [RFC][PATCH 2/4] ARM: shmobile: r8a7778: fixup Ether setup code position
Message-Id: <20130409075937.GA18478@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874nfgb74b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nfgb74b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 08, 2013 at 10:33:44PM -0700, Kuninori Morimoto wrote:
> Ether setup code position was scattering.
> This patch fixes it up

Thanks, queued-up in the shc-r8a7778 branch.

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/mach-shmobile/setup-r8a7778.c |   28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 30b4a33..d6ee521 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -80,12 +80,6 @@ static struct sh_timer_config sh_tmu1_platform_data = {
>  	.clocksource_rating	= 200,
>  };
>  
> -/* Ether */
> -static struct resource ether_resources[] = {
> -	DEFINE_RES_MEM(0xfde00000, 0x400),
> -	DEFINE_RES_IRQ(gic_iid(0x89)),
> -};
> -
>  #define r8a7778_register_tmu(idx)			\
>  	platform_device_register_resndata(		\
>  		&platform_bus, "sh_tmu", idx,		\
> @@ -94,6 +88,20 @@ static struct resource ether_resources[] = {
>  		&sh_tmu##idx##_platform_data,		\
>  		sizeof(sh_tmu##idx##_platform_data))
>  
> +/* Ether */
> +static struct resource ether_resources[] = {
> +	DEFINE_RES_MEM(0xfde00000, 0x400),
> +	DEFINE_RES_IRQ(gic_iid(0x89)),
> +};
> +
> +void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
> +{
> +	platform_device_register_resndata(&platform_bus, "sh_eth", -1,

BTW, s/sh_eth/sh-eth/ ? Also for r8a7778?

> +					  ether_resources,
> +					  ARRAY_SIZE(ether_resources),
> +					  pdata, sizeof(*pdata));
> +}
> +
>  void __init r8a7778_add_standard_devices(void)
>  {
>  	int i;
> @@ -118,14 +126,6 @@ void __init r8a7778_add_standard_devices(void)
>  	r8a7778_register_tmu(1);
>  }
>  
> -void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
> -{
> -	platform_device_register_resndata(&platform_bus, "sh_eth", -1,
> -					  ether_resources,
> -					  ARRAY_SIZE(ether_resources),
> -					  pdata, sizeof(*pdata));
> -}
> -
>  static struct renesas_intc_irqpin_config irqpin_platform_data = {
>  	.irq_base = irq_pin(0), /* IRQ0 -> IRQ3 */
>  	.sense_bitfield_width = 2,
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
