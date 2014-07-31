From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 31 Jul 2014 11:56:39 +0000
Subject: Re: [PATCH 5/6] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <20140731114439.GO8181@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
In-Reply-To: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 31, 2014 at 09:34:08AM +0900, Simon Horman wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> The DMAC is a general purpose multi-channel DMA controller that supports
> both slave and memcpy transfers.
> 
> The driver currently supports the DMAC found in the r8a7790 and r8a7791
> SoCs. Support for compatible DMA controllers (such as the audio DMAC)
> will be added later.
> 
> Feature-wise, automatic hardware handling of descriptors chains isn't
> supported yet. LPAE support is implemented.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---

> +static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> +	int ret;
> +
> +	INIT_LIST_HEAD(&rchan->desc.free);
> +	INIT_LIST_HEAD(&rchan->desc.pending);
> +	INIT_LIST_HEAD(&rchan->desc.active);
> +	INIT_LIST_HEAD(&rchan->desc.done);
> +	INIT_LIST_HEAD(&rchan->desc.wait);
> +	INIT_LIST_HEAD(&rchan->desc.hw_free);
> +	INIT_LIST_HEAD(&rchan->desc.pages);
Seriously we need so many lists? 1st three makes sense but what is delta b/w
done and free. Once a descriptor is done it should be moved to freee list.

What does wait list mean and the last two?


> +static struct dma_async_tx_descriptor *
> +rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +			  size_t buf_len, size_t period_len,
> +			  enum dma_transfer_direction dir, unsigned long flags,
> +			  void *context)
> +{
> +	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> +	struct dma_async_tx_descriptor *desc;
> +	struct scatterlist *sgl;
> +	unsigned int sg_len;
> +	unsigned int i;
> +
> +	/* Someone calling slave DMA on a generic channel? */
> +	if (rchan->mid_rid < 0 || buf_len < period_len) {
> +		dev_warn(chan->device->dev,
> +			"%s: bad parameter: buf_len=%zu, period_len=%zu, id=%d\n",
> +			__func__, buf_len, period_len, rchan->mid_rid);
> +		return NULL;
> +	}
> +
> +	sg_len = buf_len / period_len;
> +	if (sg_len > RCAR_DMAC_MAX_SG_LEN) {
> +		dev_err(chan->device->dev,
> +			"chan%u: sg length %d exceds limit %d",
> +			rchan->index, sg_len, RCAR_DMAC_MAX_SG_LEN);
> +		return NULL;
> +	}
> +
> +	/*
> +	 * Allocate the sg list dynamically as it would consumer too much stack
> +	 * space.
> +	 */
> +	sgl = kcalloc(sg_len, sizeof(*sgl), GFP_KERNEL);
GFP_NOWAIT, prepare calls can be invoked from atomic context
> +	if (!sgl)
> +		return NULL;
Wouldn't ERR_PTR help here?

> +static void rcar_dmac_slave_config(struct rcar_dmac_chan *chan,
> +				  struct dma_slave_config *cfg)
> +{
> +	/*
> +	 * We could lock this, but you shouldn't be configuring the
> +	 * channel, while using it...
> +	 */
> +
> +	if (cfg->direction = DMA_DEV_TO_MEM) {
> +		chan->slave_addr = cfg->src_addr;
> +		chan->xfer_size = cfg->src_addr_width;
> +	} else {
> +		chan->slave_addr = cfg->dst_addr;
> +		chan->xfer_size = cfg->dst_addr_width;
> +	}
okay this bit needs modification. The channel can be configured in any
direction. SO you can have one descriptor doing DMA_DEV_TO_MEM and another
DMA_MEM_TO_DEV. The prep_ calls have direction arg to be used, so please
store both :)

> +}
> +
> +static int rcar_dmac_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +			     unsigned long arg)
> +{
> +	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> +
> +	switch (cmd) {
> +	case DMA_TERMINATE_ALL:
> +		rcar_dmac_chan_terminate_all(rchan);
> +		break;
> +
> +	case DMA_SLAVE_CONFIG:
> +		rcar_dmac_slave_config(rchan, (struct dma_slave_config *)arg);
> +		break;
> +
> +	default:
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static size_t rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
> +					 dma_cookie_t cookie)
> +{
> +	struct rcar_dmac_desc *desc = chan->desc.running;
> +	struct rcar_dmac_hw_desc *hwdesc;
> +	size_t residue = 0;
> +
> +	if (!desc)
> +		return 0;
Why?
We should be able to query even when channel is not running, right?

> +static int rcar_dmac_slave_caps(struct dma_chan *chan,
> +				struct dma_slave_caps *caps)
> +{
> +	memset(caps, 0, sizeof(*caps));
> +
> +	/*
> +	 * The device supports all widths from 1 to 64 bytes. As the
> +	 * dma_slave_buswidth enumeration is limited to 8 bytes, set the
> +	 * numerical value directly.
> +	 */
> +	caps->src_addr_widths = 0x7f;
> +	caps->dstn_addr_widths = 0x7f;
no magic numbers pls

> +	caps->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
> +	caps->cmd_terminate = true;
> +	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
pls do initialize pause.

> +static irqreturn_t rcar_dmac_isr_transfer_end(struct rcar_dmac_chan *chan)
> +{
> +	struct rcar_dmac_desc *desc = chan->desc.running;
> +	struct rcar_dmac_hw_desc *hwdesc;
> +	irqreturn_t ret = IRQ_WAKE_THREAD;
> +
> +	if (WARN_ON(!desc)) {
> +		/*
> +		 * This should never happen, there should always be
> +		 * a running descriptor when a transfer ends. Warn and
> +		 * return.
> +		 */
> +		return IRQ_NONE;
> +	}
> +
> +	/*
> +	 * If we haven't completed the last hardware descriptor simply move to
> +	 * the next one. Only wake the IRQ thread if the transfer is cyclic.
> +	 */
> +	hwdesc = desc->running;
> +	if (!list_is_last(&hwdesc->node, &desc->hwdescs)) {
> +		desc->running = list_next_entry(hwdesc, node);
> +		if (!desc->cyclic)
> +			ret = IRQ_HANDLED;
> +		goto done;
> +	}
> +
> +	/*
> +	 * We've completed the last hardware. If the transfer is cyclic, move
> +	 * back to the first one.
> +	 */
> +	if (desc->cyclic) {
> +		desc->running = list_first_entry(&desc->hwdescs,
> +						 struct rcar_dmac_hw_desc,
> +						 node);
> +		goto done;
> +	}
> +
> +	/* The descriptor is complete, move it to the done list. */
> +	list_move_tail(&desc->node, &chan->desc.done);
> +	chan->desc.submitted--;
no lock protecting this one? I am sure you would be running a multi-core
system!

> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
> +static int rcar_dmac_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int rcar_dmac_resume(struct device *dev)
> +{
> +	struct rcar_dmac *dmac = dev_get_drvdata(dev);
> +
> +	return rcar_dmac_init(dmac);
> +}
> +#endif
I dont think you need these as you are using PM macros.

> +static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> +				struct rcar_dmac_chan *rchan,
> +				unsigned int index)
> +{
> +	struct platform_device *pdev = to_platform_device(dmac->dev);
> +	struct dma_chan *chan = &rchan->chan;
> +	char irqname[5];
> +	int irq;
> +	int ret;
> +
> +	rchan->index = index;
> +	rchan->iomem = dmac->iomem + RCAR_DMAC_CHAN_OFFSET(index);
> +	rchan->mid_rid = -EINVAL;
> +
> +	spin_lock_init(&rchan->lock);
> +	mutex_init(&rchan->power_lock);
> +
> +	/* Request the channel interrupt. */
> +	sprintf(irqname, "ch%u", index);
> +	irq = platform_get_irq_byname(pdev, irqname);
> +	if (irq < 0) {
> +		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
> +		return -ENODEV;
> +	}
> +
> +	rchan->irqname = devm_kmalloc(dmac->dev,
> +				      strlen(dev_name(dmac->dev)) + 4,
> +				      GFP_KERNEL);
> +	if (!rchan->irqname)
> +		return -ENOMEM;
> +	sprintf(rchan->irqname, "%s:%u", dev_name(dmac->dev), index);
> +
> +	ret = devm_request_threaded_irq(dmac->dev, irq, rcar_dmac_isr_channel,
> +					rcar_dmac_isr_channel_thread, 0,
> +					rchan->irqname, rchan);
I know sh drivers do this but WHY. All other dmac drivers are happy with API
and do tasklets.

> +static int rcar_dmac_probe(struct platform_device *pdev)
> +{
> +	struct dma_device *engine;
> +	struct rcar_dmac *dmac;
> +	struct resource *mem;
> +	unsigned int i;
> +	int irq;
> +	int ret;
> +
> +	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> +	if (!dmac)
> +		return -ENOMEM;
> +
> +	dmac->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, dmac);
> +
> +	ret = rcar_dmac_parse_of(&pdev->dev, dmac);
> +	if (ret < 0)
> +		return ret;
> +
> +	dmac->channels = devm_kcalloc(&pdev->dev, dmac->n_channels,
> +				      sizeof(*dmac->channels), GFP_KERNEL);
> +	if (!dmac->channels)
> +		return -ENOMEM;
> +
> +	/* Request resources. */
> +	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	dmac->iomem = devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(dmac->iomem))
> +		return PTR_ERR(dmac->iomem);
> +
> +	irq = platform_get_irq_byname(pdev, "error");
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "no error IRQ specified\n");
> +		return -ENODEV;
> +	}
> +
> +	dmac->irqname = devm_kmalloc(dmac->dev, strlen(dev_name(dmac->dev)) + 7,
> +				     GFP_KERNEL);
> +	if (!dmac->irqname)
> +		return -ENOMEM;
> +	sprintf(dmac->irqname, "%s:error", dev_name(&pdev->dev));
> +
> +	ret = devm_request_irq(&pdev->dev, irq, rcar_dmac_isr_error, 0,
> +			       dmac->irqname, dmac);
and you can get isr invoked after this while you are still enabling device.


> +static int rcar_dmac_remove(struct platform_device *pdev)
> +{
> +	struct rcar_dmac *dmac = platform_get_drvdata(pdev);
> +	unsigned int i;
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	dma_async_device_unregister(&dmac->engine);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	for (i = 0; i < dmac->n_channels; ++i)
> +		mutex_destroy(&dmac->channels[i].power_lock);
> +
> +	return 0;
and what prevents you getting irq and all the irq threads running and
executed before you do remove. Lots of potential race conditions here!

-- 
~Vinod
