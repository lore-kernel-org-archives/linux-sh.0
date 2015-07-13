From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 13 Jul 2015 19:00:43 +0000
Subject: Re: [PATCH/RFC 2/3] dmaengine: shdmac: Add missing DMA_MEM_TO_MEM direction
Message-Id: <59869612.fDLAJFKxLR@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1436529553-30571-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436529553-30571-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Friday 10 July 2015 13:59:12 Geert Uytterhoeven wrote:
> If a driver does "dma_cap_set(DMA_MEMCPY), ...)", it should advertise
> DMA_MEM_TO_MEM support in the direction mask.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Is it true that DMA_MEMCPY implies DMA_MEM_TO_MEM?

The directions field is defined as

 * @directions: bit mask of slave direction the channel supported
 *      since the enum dma_transfer_direction is not defined as bits for each
 *      type of direction, the dma controller should fill (1 << <TYPE>) and 
same
 *      should be checked by controller as well

Memory-to-memory transfer isn't a DMA slave capability, so I don't think the 
directions field should report BIT(DMA_MEM_TO_MEM).

> ---
>  drivers/dma/sh/rcar-dmac.c   | 3 ++-
>  drivers/dma/sh/rcar-hpbdma.c | 3 ++-
>  drivers/dma/sh/shdmac.c      | 4 +++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 7820d07e7beea7dd..11e5003a6cc27b40 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -1707,7 +1707,8 @@ static int rcar_dmac_probe(struct platform_device
> *pdev)
> 
>  	engine->src_addr_widths = widths;
>  	engine->dst_addr_widths = widths;
> -	engine->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
> +	engine->directions = BIT(DMA_MEM_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
> +			     BIT(DMA_DEV_TO_MEM);
>  	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> 
>  	engine->device_alloc_chan_resources = rcar_dmac_alloc_chan_resources;
> diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
> index 2e21c1197769d0c8..29d67277415084b4 100644
> --- a/drivers/dma/sh/rcar-hpbdma.c
> +++ b/drivers/dma/sh/rcar-hpbdma.c
> @@ -599,7 +599,8 @@ static int hpb_dmae_probe(struct platform_device *pdev)
>  	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
>  	dma_dev->src_addr_widths = widths;
>  	dma_dev->dst_addr_widths = widths;
> -	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
> +	dma_dev->directions = BIT(DMA_MEM_TO_MEM) | BIT(DMA_MEM_TO_DEV) |
> +			      BIT(DMA_DEV_TO_MEM);
>  	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> 
>  	hpbdev->shdma_dev.ops = &hpb_dmae_ops;
> diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
> index c9489ae6c0fa7f47..8693fff83d7b3af4 100644
> --- a/drivers/dma/sh/shdmac.c
> +++ b/drivers/dma/sh/shdmac.c
> @@ -750,8 +750,10 @@ static int sh_dmae_probe(struct platform_device *pdev)
>  	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
>  	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> 
> -	if (!pdata->slave_only)
> +	if (!pdata->slave_only) {
>  		dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +		dma_dev->directions |= BIT(DMA_MEM_TO_MEM);
> +	}
>  	if (pdata->slave && pdata->slave_num)
>  		dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);

-- 
Regards,

Laurent Pinchart

