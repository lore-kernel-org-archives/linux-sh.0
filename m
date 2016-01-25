From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 25 Jan 2016 00:12:15 +0000
Subject: Re: [PATCH/RFC] dmaengine: rcar-dmac: Use CAE/CAIR instead of error IRQ
Message-Id: <9635825.KOsOsyzbE6@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20160114101653.16562.42789.sendpatchset@little-apple>
In-Reply-To: <20160114101653.16562.42789.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, geert+renesas@glider.be, linux-sh@vger.kernel.org, vinod.koul@intel.com, dmaengine@vger.kernel.org, horms+renesas@verge.net.au

Hi Magnus,

Thank you for the patch.

On Thursday 14 January 2016 19:16:53 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> While using SYS-DMAC together with the IPMMU it became evident
> that the shared error interrupt hooked up by rcar-dmac.c never
> got invoked but instead the per-channel CAE bit got set which
> in turn may generate a per-channel interrupt if CAIE is set.
> 
> This patch removes the shared interrupt handler and instead
> simply enables CAIE and makes sure CAE gets cleared by the
> interrupt handler. Without enabling CAIE and clearing CAE the
> DMA transfer blocks forever in case of error.
> 
> During normal operation it is hard to trigger error interrupts,
> but I have managed to trigger the SYS-DMAC error by using local
> IPMMU debug code that tracks active page table entries using
> the AF bit. This debug code results in rather high latencies
> which in turn makes the SYS-DMAC generate error interrupts.
> 
> Tested on r8a7795 Salvator-X. Not for upstream merge - needs
> more discussion and testing on other SoCs.
> 
> Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/dma/sh/rcar-dmac.c |   60 ++---------------------------------------
>  1 file changed, 3 insertions(+), 57 deletions(-)
> 
> --- 0001/drivers/dma/sh/rcar-dmac.c
> +++ work/drivers/dma/sh/rcar-dmac.c	2016-01-14 18:16:23.040513000 +0900
> @@ -808,23 +808,6 @@ static void rcar_dmac_stop(struct rcar_d
>  	rcar_dmac_write(dmac, RCAR_DMAOR, 0);
>  }
> 
> -static void rcar_dmac_abort(struct rcar_dmac *dmac)
> -{
> -	unsigned int i;
> -
> -	/* Stop all channels. */
> -	for (i = 0; i < dmac->n_channels; ++i) {
> -		struct rcar_dmac_chan *chan = &dmac->channels[i];
> -
> -		/* Stop and reinitialize the channel. */
> -		spin_lock(&chan->lock);
> -		rcar_dmac_chan_halt(chan);
> -		spin_unlock(&chan->lock);
> -
> -		rcar_dmac_chan_reinit(chan);
> -	}
> -}
> -
>  /*
> ---------------------------------------------------------------------------
> -- * Descriptors preparation
>   */
> @@ -864,7 +847,7 @@ static void rcar_dmac_chan_configure_des
>  	}
> 
>  	desc->xfer_shift = ilog2(xfer_size);
> -	desc->chcr = chcr | chcr_ts[desc->xfer_shift];
> +	desc->chcr = chcr | chcr_ts[desc->xfer_shift] | RCAR_DMACHCR_CAIE;

I'd rather let desc->chcr store the channel-specific configuration as 
documented in the rcar_dmac_desc structure kerneldoc and set the CAIE flag at 
the start of the rcar_dmac_chan_start_xfer() function with

        u32 chcr = desc->chcr | RCAR_DMACHCR_CAIE;

>  }
> 
>  /*
> @@ -1427,6 +1410,8 @@ static irqreturn_t rcar_dmac_isr_channel
>  	spin_lock(&chan->lock);
> 
>  	chcr = rcar_dmac_chan_read(chan, RCAR_DMACHCR);
> +	if (chcr & RCAR_DMACHCR_CAE)
> +		mask |= RCAR_DMACHCR_CAE;

How about setting the CAE flag unconditionally at the beginning of the 
function with

        u32 mask = RCAR_DMACHCR_CAE | RCAR_DMACHCR_DSE | RCAR_DMACHCR_TE;

>  	if (chcr & RCAR_DMACHCR_TE)
>  		mask |= RCAR_DMACHCR_DE;
>  	rcar_dmac_chan_write(chan, RCAR_DMACHCR, chcr & ~mask);

Don't you also need to act on the CAE flag being set ? Otherwise the transfer 
will just hang.

> @@ -1497,24 +1482,6 @@ static irqreturn_t rcar_dmac_isr_channel
>  	return IRQ_HANDLED;
>  }
> 
> -static irqreturn_t rcar_dmac_isr_error(int irq, void *data)
> -{
> -	struct rcar_dmac *dmac = data;
> -
> -	if (!(rcar_dmac_read(dmac, RCAR_DMAOR) & RCAR_DMAOR_AE))
> -		return IRQ_NONE;
> -
> -	/*
> -	 * An unrecoverable error occurred on an unknown channel. Halt the DMAC,
> -	 * abort transfers on all channels, and reinitialize the DMAC.
> -	 */
> -	rcar_dmac_stop(dmac);
> -	rcar_dmac_abort(dmac);
> -	rcar_dmac_init(dmac);
> -
> -	return IRQ_HANDLED;
> -}
> -
>  /*
> ---------------------------------------------------------------------------
> -- * OF xlate and channel filter
>   */
> @@ -1693,8 +1660,6 @@ static int rcar_dmac_probe(struct platfo
>  	struct rcar_dmac *dmac;
>  	struct resource *mem;
>  	unsigned int i;
> -	char *irqname;
> -	int irq;
>  	int ret;
> 
>  	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> @@ -1732,25 +1697,6 @@ static int rcar_dmac_probe(struct platfo
>  	if (IS_ERR(dmac->iomem))
>  		return PTR_ERR(dmac->iomem);
> 
> -	irq = platform_get_irq_byname(pdev, "error");
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "no error IRQ specified\n");
> -		return -ENODEV;
> -	}
> -
> -	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:error",
> -				 dev_name(dmac->dev));
> -	if (!irqname)
> -		return -ENOMEM;
> -
> -	ret = devm_request_irq(&pdev->dev, irq, rcar_dmac_isr_error, 0,
> -			       irqname, dmac);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> -			irq, ret);
> -		return ret;
> -	}
> -
>  	/* Enable runtime PM and initialize the device. */
>  	pm_runtime_enable(&pdev->dev);
>  	ret = pm_runtime_get_sync(&pdev->dev);

-- 
Regards,

Laurent Pinchart

