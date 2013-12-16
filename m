From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 16 Dec 2013 23:53:57 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: armadillo: Fix coherent DMA mask
Message-Id: <87txe8nyia.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387217769-22751-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387217769-22751-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

> Commit 4dcfa60071b3d23f0181f27d8519f12e37cefbb9 ("ARM: DMA-API: better
> handing of DMA masks for coherent allocations") added an additional
> check to the coherent DMA mask that results in an error when the mask is
> larger than what dma_addr_t can address.
> 
> Set the LCDC coherent DMA mask to DMA_BIT_MASK(32) instead of ~0 to fix
> the problem.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

>  arch/arm/mach-shmobile/board-armadillo800eva.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index d9e28c7a..82d027c 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -483,7 +483,7 @@ static struct platform_device lcdc0_device = {
>  	.id		= 0,
>  	.dev	= {
>  		.platform_data	= &lcdc0_info,
> -		.coherent_dma_mask = ~0,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
>  	},
>  };
>  
> @@ -580,7 +580,7 @@ static struct platform_device hdmi_lcdc_device = {
>  	.id		= 1,
>  	.dev	= {
>  		.platform_data	= &hdmi_lcdc_info,
> -		.coherent_dma_mask = ~0,
> +		.coherent_dma_mask = DMA_BIT_MASK(32),
>  	},
>  };
>  
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
