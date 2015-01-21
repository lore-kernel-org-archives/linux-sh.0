From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 01:26:47 +0000
Subject: Re: [PATCH v3] dmaengine:: rcar-hpbdma: add dma_dev->directions
Message-Id: <87lhkworck.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zj9eb5ya.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zj9eb5ya.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > @@ -595,6 +597,10 @@ static int hpb_dmae_probe(struct platform_device *pdev)
> > 
> >  	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> >  	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> > +	dma_dev->src_addr_widths = widths;
> > +	dma_dev->dst_addr_widths = widths;
> > +	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
> > +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> 
> The driver doesn't seem to support residue reporting at all, shouldn't 
> residue_granularity be set to DMA_RESIDUE_GRANULARITY_DESCRIPTOR then ?

Thank you for pointing it.
will fix in v4 patch

Best regards
---
Kuninori Morimoto
