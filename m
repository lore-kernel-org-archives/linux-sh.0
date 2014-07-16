From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 16 Jul 2014 09:30:56 +0000
Subject: Re: [PATCH 4/7] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <2306070.7hZDSOyLHL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405455522-20676-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the review.

On Tuesday 15 July 2014 18:33:50 Kuninori Morimoto wrote:
> > The DMAC is a general purpose multi-channel DMA controller that supports
> > both slave and memcpy transfers.
> > 
> > The driver currently supports the DMAC found in the r8a7790 and r8a7791
> > SoCs. Support for compatible DMA controllers (such as the audio DMAC)
> > will be added later.
> > 
> > Feature-wise, automatic hardware handling of descriptors chains isn't
> > supported yet. LPAE support is implemented.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> 
> (snip)
> 
> > diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> > new file mode 100644
> > index 0000000..9cb1dd3
> > --- /dev/null
> > +++ b/drivers/dma/sh/rcar-dmac.c
> > @@ -0,0 +1,1514 @@
> > +/*
> > + * Renesas R-Car Gen2 DMA Controller Driver
> 
> We can reuse this driver in Gen3 too ?
> "Renesas R-Car" only is very enough.

Given that I don't have Gen3 hardware or documentation, I don't know :-) 
"Gen2" doesn't appear in the compatible string, so it would be trivial to 
change that later if the Gen3 DMAC is indeed compatible. Note that the R-Car 
Gen1 DMAC isn't compatible with this driver.

> > +static void rcar_dmac_chan_start_xfer(struct rcar_dmac_chan *chan)
> > +{
> > +	struct rcar_dmac_desc *desc = chan->desc.running;
> > +	struct rcar_dmac_hw_desc *hwdesc = desc->running;
> > +
> > +	dev_dbg(chan->chan.device->dev,
> > +		"chan%u: queue hwdesc %p: %u@%pad -> %pad\n",
> > +		chan->index, hwdesc, hwdesc->size, &hwdesc->src_addr,
> > +		&hwdesc->dst_addr);
> > +
> > +	WARN_ON_ONCE(rcar_dmac_chan_is_busy(chan));
> > +
> > +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> > +	rcar_dmac_chan_write(chan, RCAR_DMAFIXSAR, hwdesc->src_addr >> 32);
> > +	rcar_dmac_chan_write(chan, RCAR_DMAFIXDAR, hwdesc->dst_addr >> 32);
> > +#endif
> > +	rcar_dmac_chan_write(chan, RCAR_DMASAR, hwdesc->src_addr & 
0xffffffff);
> > +	rcar_dmac_chan_write(chan, RCAR_DMADAR, hwdesc->dst_addr & 
0xffffffff);
> > +
> > +	if (chan->mid_rid >= 0)
> > +		rcar_dmac_chan_write(chan, RCAR_DMARS, chan->mid_rid);
> 
> I guess (chan->mid_rid < 0) case should be error

No, chan->mid_rid can be 0 when using memcpy mode. It's an error in slave mode 
only.

> > +
> > +	rcar_dmac_chan_write(chan, RCAR_DMATCR,
> > +			     hwdesc->size >> desc->xfer_shift);
> > +
> > +	rcar_dmac_chan_write(chan, RCAR_DMACHCR, desc->chcr | RCAR_DMACHCR_DE 
> > +			     RCAR_DMACHCR_IE);
> > +}
> 
> (snip)
> 
> > +static dma_cookie_t rcar_dmac_tx_submit(struct dma_async_tx_descriptor
> > *tx) +{
> > +	struct rcar_dmac_chan *chan = to_rcar_dmac_chan(tx->chan);
> > +	struct rcar_dmac_desc *desc = to_rcar_dmac_desc(tx);
> > +	unsigned long flags;
> > +	dma_cookie_t cookie;
> > +	bool resume;
> > +
> > +	mutex_lock(&chan->power_lock);
> > +
> > +	spin_lock_irqsave(&chan->lock, flags);
> > +
> > +	cookie = dma_cookie_assign(tx);
> > +
> > +	dev_dbg(chan->chan.device->dev, "chan%u: submit #%d@%p\n",
> > +		chan->index, tx->cookie, desc);
> > +
> > +	list_add_tail(&desc->node, &chan->desc.pending);
> > +	desc->running = list_first_entry(&desc->hwdescs,
> > +					 struct rcar_dmac_hw_desc, node);
> > +
> > +	/* Resume the device when submitting the first descriptor. */
> > +	resume = chan->desc.submitted++ = 0;
> > +
> > +	spin_unlock_irqrestore(&chan->lock, flags);
> > +
> > +	if (resume)
> > +		pm_runtime_get_sync(chan->chan.device->dev);
> 
> pm_runtime_xxx itself has inside counter ?

Yes, but the problem is that the DMA engine API doens't provide a counterpart 
operation to tx_submit when completing the descriptor. I currently call 
pm_runtime_put in the completion interrupt handler when no descriptor is left 
to be processed, and in terminate_all if descriptors have been submitted. If I 
relied on the runtime PM counter I would need to call pm_runtime_put in a loop 
in terminate_all, which isn't very nice.

> > +
> > +	mutex_unlock(&chan->power_lock);
> > +
> > +	return cookie;
> > +}
> 
> (snip)
> 
> > +static int rcar_dmac_hw_desc_alloc(struct rcar_dmac_chan *chan)
> > +{
> > +	struct rcar_dmac_desc_page *page;
> > +	LIST_HEAD(list);
> > +	unsigned int i;
> > +
> > +	page = (void *)get_zeroed_page(GFP_KERNEL);
> > +	if (page = NULL)
> > +		return -ENOMEM;
> 
> I like "if (!page)"

Given that I use the "!" style through the driver I'll change it here and in 
the couple of other locations where "= NULL" is used.

> > +
> > +	for (i = 0; i < RCAR_DMAC_HWDESCS_PER_PAGE; ++i) {
> > +		struct rcar_dmac_hw_desc *hwdesc = &page->hwdescs[i];
> > +
> > +		list_add_tail(&hwdesc->node, &list);
> > +	}
> > +
> > +	spin_lock_irq(&chan->lock);
> > +	list_splice_tail(&list, &chan->desc.hw_free);
> > +	list_add_tail(&page->node, &chan->desc.pages);
> > +	spin_unlock_irq(&chan->lock);
> > +
> > +	return 0;
> > +}
> 
> (snip)
> 
> > +static void rcar_dmac_chan_configure_desc(struct rcar_dmac_chan *chan,
> > +					  struct rcar_dmac_desc *desc)
> > +{
> > +	static const u32 chcr_ts[] = {
> > +		RCAR_DMACHCR_TS_1B, RCAR_DMACHCR_TS_2B,
> > +		RCAR_DMACHCR_TS_4B, RCAR_DMACHCR_TS_8B,
> > +		RCAR_DMACHCR_TS_16B, RCAR_DMACHCR_TS_32B,
> > +		RCAR_DMACHCR_TS_64B,
> > +	};
> > +
> > +	unsigned int xfer_size;
> > +	u32 chcr;
> > +
> > +	switch (desc->direction) {
> > +	case DMA_DEV_TO_MEM:
> > +		chcr = RCAR_DMACHCR_DM_INC | RCAR_DMACHCR_SM_FIXED
> > +		     | RCAR_DMACHCR_RS_DMARS;
> > +		xfer_size = chan->xfer_size;
> > +		break;
> > +
> > +	case DMA_MEM_TO_DEV:
> > +		chcr = RCAR_DMACHCR_DM_FIXED | RCAR_DMACHCR_SM_INC
> > +		     | RCAR_DMACHCR_RS_DMARS;
> > +		xfer_size = chan->xfer_size;
> > +		break;
> > +
> > +	case DMA_MEM_TO_MEM:
> > +	default:
> > +		chcr = RCAR_DMACHCR_DM_INC | RCAR_DMACHCR_SM_INC
> > +		     | RCAR_DMACHCR_RS_AUTO;
> > +		xfer_size = RCAR_DMAC_MEMCPY_XFER_SIZE;
> > +		break;
> > +	}
> > +
> > +	desc->xfer_shift = ilog2(xfer_size);
> > +	desc->chcr = chcr | chcr_ts[desc->xfer_shift];
> > +}
> 
> Here and rcar_dmac_slave_config()'s chcr method is very nice for me !!

[snip]

> > +static struct dma_async_tx_descriptor *
> > +rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> > +			  size_t buf_len, size_t period_len,
> > +			  enum dma_transfer_direction dir, unsigned long flags,
> > +			  void *context)
> > +{
> > +	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> > +	struct dma_async_tx_descriptor *desc;
> > +	struct scatterlist *sgl;
> > +	unsigned int sg_len;
> > +	unsigned int i;
> > +
> > +	/* Someone calling slave DMA on a generic channel? */
> > +	if (rchan->mid_rid < 0 || buf_len < period_len) {
> > +		dev_warn(chan->device->dev,
> > +			"%s: bad parameter: buf_len=%zu, period_len=%zu, id=%d\n",
> > +			__func__, buf_len, period_len, rchan->mid_rid);
> > +		return NULL;
> > +	}
> > +
> > +	sg_len = buf_len / period_len;
> > +	if (sg_len > RCAR_DMAC_MAX_SG_LEN) {
> > +		dev_err(chan->device->dev,
> > +			"chan%u: sg length %d exceds limit %d",
> > +			rchan->index, sg_len, RCAR_DMAC_MAX_SG_LEN);
> > +		return NULL;
> > +	}
> > +
> > +	sgl = kcalloc(RCAR_DMAC_MAX_SG_LEN, sizeof(*sgl), GFP_NOWAIT);
> > +	if (!sgl)
> > +		return NULL;
> 
> This kcalloc() is using fixed size.
> we can't use this ?
> 	struct scatterlist sgl[RCAR_DMAC_MAX_SG_LEN];

That's what the shdma-base driver does, and gcc warns that it consumes more 
than 1024 bytes of stack space. Given that the kernel stack size is fixed we 
should be conservative to avoid stack overflows. I think we should fix shdma-
base.

> > +
> > +	sg_init_table(sgl, sg_len);
> > +
> > +	for (i = 0; i < sg_len; ++i) {
> > +		dma_addr_t src = buf_addr + (period_len * i);
> > +
> > +		sg_set_page(&sgl[i], pfn_to_page(PFN_DOWN(src)), period_len,
> > +			    offset_in_page(src));
> > +		sg_dma_address(&sgl[i]) = src;
> > +		sg_dma_len(&sgl[i]) = period_len;
> > +	}
> > +
> > +	desc = rcar_dmac_chan_prep_sg(rchan, sgl, sg_len, rchan->slave_addr,
> > +				      dir, flags, true);
> > +
> > +	kfree(sgl);
> > +	return desc;
> > +}
> 
> (snip)
> 
> > +static int rcar_dmac_probe(struct platform_device *pdev)
> > +{
> > +	struct dma_device *engine;
> > +	struct rcar_dmac *dmac;
> > +	struct resource *mem;
> > +	unsigned int i;
> > +	int irq;
> > +	int ret;
> > +
> > +	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> > +	if (!dmac)
> > +		return -ENOMEM;
> > +
> > +	dmac->dev = &pdev->dev;
> > +	platform_set_drvdata(pdev, dmac);
> > +
> > +	ret = rcar_dmac_parse_of(&pdev->dev, dmac);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
> > +				      sizeof(*dmac->channels), GFP_KERNEL);
> > +	if (!dmac->channels)
> > +		return -ENOMEM;
> > +
> > +	/* Request resources. */
> > +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	dmac->iomem = devm_ioremap_resource(&pdev->dev, mem);
> > +	if (IS_ERR(dmac->iomem))
> > +		return PTR_ERR(dmac->iomem);
> > +
> > +	irq = platform_get_irq_byname(pdev, "error");
> > +	if (irq < 0) {
> > +		dev_err(&pdev->dev, "no error IRQ specified\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = devm_request_irq(&pdev->dev, irq, rcar_dmac_isr_error, 0,
> > +			       "DMAC Address Error", dmac);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to request IRQ %u (%d)\n",
> > +			irq, ret);
> > +		return ret;
> > +	}
> > +
> > +	dmac->clk = clk_get(&pdev->dev, "fck");
> > +	if (IS_ERR(dmac->clk)) {
> > +		dev_err(&pdev->dev, "unable to get fck clock\n");
> > +		return PTR_ERR(dmac->clk);
> > +	}
> 
> Maybe this is my misunderstanding,
> but, which clock are you expecting to "fck" clock ?
> Is it not same as pm_runtime_xxx()'s clock ?

It's the MSTP clock for the DMAC.

> > +	/* Initialize the channels. */
> > +	INIT_LIST_HEAD(&dmac->engine.channels);
> > +
> > +	for (i = 0; i < dmac->n_channels; ++i) {
> > +		ret = rcar_dmac_chan_probe(dmac, &dmac->channels[i], i);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
> > +	/* Enable runtime PM and initialize the device. */
> > +	pm_runtime_enable(&pdev->dev);
> > +	ret = pm_runtime_get_sync(&pdev->dev);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "runtime PM get sync failed (%d)\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = rcar_dmac_init(dmac);
> > +	pm_runtime_put(&pdev->dev);
> 
> power ON -> initialize -> power OFF here,
> and shdmac.c has similar method.
> And it works, but, it is a littile bit strange for me :P

Don't forget that runtime PM can be disabled in the kernel configuration. In 
that case this is the only place where the DMAC hardware will be initialized.

-- 
Regards,

Laurent Pinchart

