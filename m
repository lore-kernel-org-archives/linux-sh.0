From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 Aug 2013 07:46:30 +0000
Subject: Re: [PATCH v4 1/3] ARM: shmobile: ape6evm: add "__initconst" annotations where needed
Message-Id: <20130801074630.GD15265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375342881-2155-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1375342881-2155-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 01, 2013 at 09:41:19AM +0200, Guennadi Liakhovetski wrote:
> This patch adds __initconst markers to the platform data and resources,
> used on ape6evm as parameters to platform_device_register_resndata().
> The data is duplicated inside that function, therefore original data
> can be discarded after initialisation is completed.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Hi Guennadi,

I was just in the process of queueing up v3 of this patch.
Should I update to v4 or is it the same as v3?

> ---
>  arch/arm/mach-shmobile/board-ape6evm.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
> index ccf8b04..c5e6cba 100644
> --- a/arch/arm/mach-shmobile/board-ape6evm.c
> +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> @@ -44,7 +44,7 @@ static struct regulator_consumer_supply dummy_supplies[] = {
>  };
>  
>  /* SMSC LAN9220 */
> -static const struct resource lan9220_res[] = {
> +static const struct resource lan9220_res[] __initconst = {
>  	DEFINE_RES_MEM(0x08000000, 0x1000),
>  	{
>  		.start	= irq_pin(40), /* IRQ40 */
> @@ -52,7 +52,7 @@ static const struct resource lan9220_res[] = {
>  	},
>  };
>  
> -static const struct smsc911x_platform_config lan9220_data = {
> +static const struct smsc911x_platform_config lan9220_data __initconst = {
>  	.flags		= SMSC911X_USE_32BIT,
>  	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
>  	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
> @@ -73,39 +73,39 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[] >  };
>  
>  /* MMCIF */
> -static struct sh_mmcif_plat_data mmcif0_pdata = {
> +static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
>  	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
>  };
>  
> -static struct resource mmcif0_resources[] = {
> +static const struct resource mmcif0_resources[] __initconst = {
>  	DEFINE_RES_MEM_NAMED(0xee200000, 0x100, "MMCIF0"),
>  	DEFINE_RES_IRQ(gic_spi(169)),
>  };
>  
>  /* SDHI0 */
> -static struct sh_mobile_sdhi_info sdhi0_pdata = {
> +static const struct sh_mobile_sdhi_info sdhi0_pdata __initconst = {
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>  };
>  
> -static struct resource sdhi0_resources[] = {
> +static const struct resource sdhi0_resources[] __initconst = {
>  	DEFINE_RES_MEM_NAMED(0xee100000, 0x100, "SDHI0"),
>  	DEFINE_RES_IRQ(gic_spi(165)),
>  };
>  
>  /* SDHI1 */
> -static struct sh_mobile_sdhi_info sdhi1_pdata = {
> +static const struct sh_mobile_sdhi_info sdhi1_pdata __initconst = {
>  	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
>  	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>  			  MMC_CAP_NEEDS_POLL,
>  };
>  
> -static struct resource sdhi1_resources[] = {
> +static const struct resource sdhi1_resources[] __initconst = {
>  	DEFINE_RES_MEM_NAMED(0xee120000, 0x100, "SDHI1"),
>  	DEFINE_RES_IRQ(gic_spi(166)),
>  };
>  
> -static const struct pinctrl_map ape6evm_pinctrl_map[] = {
> +static const struct pinctrl_map ape6evm_pinctrl_map[] __initconst = {
>  	/* SCIFA0 console */
>  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
>  				  "scifa0_data", "scifa0"),
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
