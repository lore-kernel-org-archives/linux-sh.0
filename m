From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Jan 2015 16:18:42 +0000
Subject: Re: [PATCH v3] dmaengine:: rcar-hpbdma: add dma_dev->directions
Message-Id: <1464424.fn5X8VGNI0@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87zj9eb5ya.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zj9eb5ya.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patch.

On Tuesday 20 January 2015 01:22:48 Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> ecc19d17868be9c9f8f00ed928791533c420f3e0
> (dmaengine: Add a warning for drivers not using the generic slave
> caps retrieval) added WARN() for DMA_SLAVE.
> Kernel will shows WARNING without this patch.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - dma -> dmaengine in Subject
> 
>  drivers/dma/sh/rcar-hpbdma.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
> index 20a6f6f..6fef1b9 100644
> --- a/drivers/dma/sh/rcar-hpbdma.c
> +++ b/drivers/dma/sh/rcar-hpbdma.c
> @@ -534,6 +534,8 @@ static int hpb_dmae_chan_probe(struct hpb_dmae_device
> *hpbdev, int id)
> 
>  static int hpb_dmae_probe(struct platform_device *pdev)
>  {
> +	const enum dma_slave_buswidth widths = DMA_SLAVE_BUSWIDTH_1_BYTE |
> +		DMA_SLAVE_BUSWIDTH_2_BYTES | DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	struct hpb_dmae_pdata *pdata = pdev->dev.platform_data;
>  	struct hpb_dmae_device *hpbdev;
>  	struct dma_device *dma_dev;
> @@ -595,6 +597,10 @@ static int hpb_dmae_probe(struct platform_device *pdev)
> 
>  	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
>  	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +	dma_dev->src_addr_widths = widths;
> +	dma_dev->dst_addr_widths = widths;
> +	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;

The driver doesn't seem to support residue reporting at all, shouldn't 
residue_granularity be set to DMA_RESIDUE_GRANULARITY_DESCRIPTOR then ?

>  	hpbdev->shdma_dev.ops = &hpb_dmae_ops;
>  	hpbdev->shdma_dev.desc_size = sizeof(struct hpb_desc);

-- 
Regards,

Laurent Pinchart

