From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 18 Mar 2013 10:17:55 +0000
Subject: Re: [PATCH] sh: enable DMA for MMCIF on ecovec
Message-Id: <Pine.LNX.4.64.1303181114290.30957@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul

On Wed, 12 Dec 2012, Guennadi Liakhovetski wrote:

> MMCIF on SH7724 can use DMA for I/O. Enable it on ecovec.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Any specific reason this patch hasn't been applied?

Thanks
Guennadi

> ---
>  arch/sh/boards/mach-ecovec24/setup.c   |    3 +++
>  arch/sh/include/cpu-sh4/cpu/sh7724.h   |    2 ++
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   10 ++++++++++
>  3 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
> index 64559e8a..57c30e8 100644
> --- a/arch/sh/boards/mach-ecovec24/setup.c
> +++ b/arch/sh/boards/mach-ecovec24/setup.c
> @@ -1031,12 +1031,15 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
>  			  MMC_CAP_8_BIT_DATA |
>  			  MMC_CAP_NEEDS_POLL,
>  	.ocr		= MMC_VDD_32_33 | MMC_VDD_33_34,
> +	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
> +	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
>  };
>  
>  static struct platform_device sh_mmcif_device = {
>  	.name		= "sh_mmcif",
>  	.id		= 0,
>  	.dev		= {
> +		.coherent_dma_mask	= 0xffffffff,
>  		.platform_data		= &sh_mmcif_plat,
>  	},
>  	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
> diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
> index 38859f9..2e38361 100644
> --- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
> +++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
> @@ -309,6 +309,8 @@ enum {
>  	SHDMA_SLAVE_SDHI0_RX,
>  	SHDMA_SLAVE_SDHI1_TX,
>  	SHDMA_SLAVE_SDHI1_RX,
> +	SHDMA_SLAVE_MMCIF_TX,
> +	SHDMA_SLAVE_MMCIF_RX,
>  };
>  
>  extern struct clk sh7724_fsimcka_clk;
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> index 26b74c2..011c3c5 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
> @@ -153,6 +153,16 @@ static const struct sh_dmae_slave_config sh7724_dmae_slaves[] = {
>  		.addr		= 0x04cf0030,
>  		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
>  		.mid_rid	= 0xca,
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
> +		.addr		= 0xa4ca0034,
> +		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
> +		.mid_rid	= 0xcd,
> +	}, {
> +		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
> +		.addr		= 0xa4ca0034,
> +		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
> +		.mid_rid	= 0xce,
>  	},
>  };
>  
> -- 
> 1.7.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
