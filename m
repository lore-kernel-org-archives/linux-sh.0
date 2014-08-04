From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 04 Aug 2014 16:30:51 +0000
Subject: Re: [PATCH 5/6] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <1851029.GHoG8vOP6u@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
In-Reply-To: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

Thank you for the review. Please see below for a couple of questions.

On Thursday 31 July 2014 17:14:39 Vinod Koul wrote:
> On Thu, Jul 31, 2014 at 09:34:08AM +0900, Simon Horman wrote:
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
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
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > 
> > +static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
> > +{
> > +	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> > +	int ret;
> > +
> > +	INIT_LIST_HEAD(&rchan->desc.free);
> > +	INIT_LIST_HEAD(&rchan->desc.pending);
> > +	INIT_LIST_HEAD(&rchan->desc.active);
> > +	INIT_LIST_HEAD(&rchan->desc.done);
> > +	INIT_LIST_HEAD(&rchan->desc.wait);
> > +	INIT_LIST_HEAD(&rchan->desc.hw_free);
> > +	INIT_LIST_HEAD(&rchan->desc.pages);
> 
> Seriously we need so many lists? 1st three makes sense but what is delta b/w
> done and free. Once a descriptor is done it should be moved to freee list.
> 
> What does wait list mean and the last two?

The free list contains descriptors that have been allocated and are not used. 
Those can be descriptors preallocated and not used yet, or descriptors that 
have been used and recycled.

The pending list contains descriptors submitted (through dmaengine_submit) but 
not issued (with dma_async_issue_pending) yet.

The active list contains descriptors issued with dma_async_issue_pending. The 
list tail is or will be processed by the hardware, and the other elements in 
the list will be processed in turn.

The done list contains descriptors that have been processed by the hardware 
but haven't been processed by the interrupt thread (I'll discuss thread 
vs.tasklet below) yet. Descriptors are added to the done list in the interrupt 
handler, and taken from the list by the interrupt thread.

The wait list contains descriptors processed by the interrupt thread for which 
the completion callback has been called, but that haven't been acked (tested 
with async_tx_test_ack) yet. Descriptors are added to that list after calling 
their callback function, and the list is then processed by 
rcar_dmac_desc_recycle_acked (called both from the interrupt thread and from 
the descriptor allocation function) to move all acked descriptors back to the 
free list. 

The hw_free and pages lists are used for memory management, they don't contain 
descriptors.

Do you see any specific list that you think should be removed ? If so, how ?

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
> > +	/*
> > +	 * Allocate the sg list dynamically as it would consumer too much 
stack
> > +	 * space.
> > +	 */
> > +	sgl = kcalloc(sg_len, sizeof(*sgl), GFP_KERNEL);
> 
> GFP_NOWAIT, prepare calls can be invoked from atomic context

I'll rework the driver in that regard.

> > +	if (!sgl)
> > +		return NULL;
> 
> Wouldn't ERR_PTR help here?

If the callers are prepared to deal with non-NULL error values, sure. I'll let 
you guess whether that's documented :-D

> > +static void rcar_dmac_slave_config(struct rcar_dmac_chan *chan,
> > +				  struct dma_slave_config *cfg)
> > +{
> > +	/*
> > +	 * We could lock this, but you shouldn't be configuring the
> > +	 * channel, while using it...
> > +	 */
> > +
> > +	if (cfg->direction = DMA_DEV_TO_MEM) {
> > +		chan->slave_addr = cfg->src_addr;
> > +		chan->xfer_size = cfg->src_addr_width;
> > +	} else {
> > +		chan->slave_addr = cfg->dst_addr;
> > +		chan->xfer_size = cfg->dst_addr_width;
> > +	}
> 
> okay this bit needs modification. The channel can be configured in any
> direction. SO you can have one descriptor doing DMA_DEV_TO_MEM and another
> DMA_MEM_TO_DEV. The prep_ calls have direction arg to be used, so please
> store both :)

Right, but before fixing that, let's document exactly how the struct 
dma_slave_config field are supposed to be used.

The direction field is documented in the header as

 * @direction: whether the data shall go in or out on this slave
 * channel, right now. DMA_MEM_TO_DEV and DMA_DEV_TO_MEM are
 * legal values.

That seems to contradict your statement.

> > +}
> > +
> > +static int rcar_dmac_control(struct dma_chan *chan, enum dma_ctrl_cmd
> > cmd,
> > +			     unsigned long arg)
> > +{
> > +	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> > +
> > +	switch (cmd) {
> > +	case DMA_TERMINATE_ALL:
> > +		rcar_dmac_chan_terminate_all(rchan);
> > +		break;
> > +
> > +	case DMA_SLAVE_CONFIG:
> > +		rcar_dmac_slave_config(rchan, (struct dma_slave_config *)arg);
> > +		break;
> > +
> > +	default:
> > +		return -ENXIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static size_t rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
> > +					 dma_cookie_t cookie)
> > +{
> > +	struct rcar_dmac_desc *desc = chan->desc.running;
> > +	struct rcar_dmac_hw_desc *hwdesc;
> > +	size_t residue = 0;
> > +
> > +	if (!desc)
> > +		return 0;
> 
> Why?
> We should be able to query even when channel is not running, right?

Good question, should we ? :-)

This would require going through all lists to find the descriptor 
corresponding to the cookie, and returning either 0 (if the descriptor has 
been processed completely) or the descriptor length (if it hasn't been 
processed yet). This is potentially costly.

The first case can be easily handled using the cookie only, when 
dma_cookie_status() state returns DMA_COMPLETE then we know that the residue 
is 0. This is actually the current behaviour, as dma_cookie_status() zeroes 
the residue field.

Is the second case something we need to support ? chan->desc.running is only 
NULL when there's no descriptor to process. In that case the cookie can either 
correspond to a descriptor already complete (first case), a descriptor 
prepared but not submitted or an invalid descriptor (in which case we can't 
report the residue anyway). Is there really a use case for reporting the 
residue for a descriptor not submitted ? That seems like a bad use of the API 
to me, I think it would be better to forbid it.

> > +static int rcar_dmac_slave_caps(struct dma_chan *chan,
> > +				struct dma_slave_caps *caps)
> > +{
> > +	memset(caps, 0, sizeof(*caps));
> > +
> > +	/*
> > +	 * The device supports all widths from 1 to 64 bytes. As the
> > +	 * dma_slave_buswidth enumeration is limited to 8 bytes, set the
> > +	 * numerical value directly.
> > +	 */
> > +	caps->src_addr_widths = 0x7f;
> > +	caps->dstn_addr_widths = 0x7f;
> 
> no magic numbers pls

Come on, 0x7f is hardly magic ;-)

Should I add DMA_SLAVE_BUSWIDTH_16_BYTES, DMA_SLAVE_BUSWIDTH_32_BYTES and 
DMA_SLAVE_BUSWIDTH_64_BYTES to enum dma_slave_buswidth ?

> > +	caps->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
> > +	caps->cmd_terminate = true;
> > +	caps->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> 
> pls do initialize pause.

It's initialized by the memset above.

> > +static irqreturn_t rcar_dmac_isr_transfer_end(struct rcar_dmac_chan
> > *chan)
> > +{
> > +	struct rcar_dmac_desc *desc = chan->desc.running;
> > +	struct rcar_dmac_hw_desc *hwdesc;
> > +	irqreturn_t ret = IRQ_WAKE_THREAD;
> > +
> > +	if (WARN_ON(!desc)) {
> > +		/*
> > +		 * This should never happen, there should always be
> > +		 * a running descriptor when a transfer ends. Warn and
> > +		 * return.
> > +		 */
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	/*
> > +	 * If we haven't completed the last hardware descriptor simply move 
to
> > +	 * the next one. Only wake the IRQ thread if the transfer is cyclic.
> > +	 */
> > +	hwdesc = desc->running;
> > +	if (!list_is_last(&hwdesc->node, &desc->hwdescs)) {
> > +		desc->running = list_next_entry(hwdesc, node);
> > +		if (!desc->cyclic)
> > +			ret = IRQ_HANDLED;
> > +		goto done;
> > +	}
> > +
> > +	/*
> > +	 * We've completed the last hardware. If the transfer is cyclic, move
> > +	 * back to the first one.
> > +	 */
> > +	if (desc->cyclic) {
> > +		desc->running = list_first_entry(&desc->hwdescs,
> > +						 struct rcar_dmac_hw_desc,
> > +						 node);
> > +		goto done;
> > +	}
> > +
> > +	/* The descriptor is complete, move it to the done list. */
> > +	list_move_tail(&desc->node, &chan->desc.done);
> > +	chan->desc.submitted--;
> 
> no lock protecting this one? I am sure you would be running a multi-core
> system!

The rcar_dmac_isr_transfer_end function is called from rcar_dmac_isr_channel 
with the channel spinlock held. The submitted field is also updated in 
rcar_dmac_tx_submit with the same spinlock held.

> > +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
> > +static int rcar_dmac_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static int rcar_dmac_resume(struct device *dev)
> > +{
> > +	struct rcar_dmac *dmac = dev_get_drvdata(dev);
> > +
> > +	return rcar_dmac_init(dmac);
> > +}
> > +#endif
> 
> I dont think you need these as you are using PM macros.

Then gcc will complain above functions being defined and not used.

> > +static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> > +				struct rcar_dmac_chan *rchan,
> > +				unsigned int index)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dmac->dev);
> > +	struct dma_chan *chan = &rchan->chan;
> > +	char irqname[5];
> > +	int irq;
> > +	int ret;
> > +
> > +	rchan->index = index;
> > +	rchan->iomem = dmac->iomem + RCAR_DMAC_CHAN_OFFSET(index);
> > +	rchan->mid_rid = -EINVAL;
> > +
> > +	spin_lock_init(&rchan->lock);
> > +	mutex_init(&rchan->power_lock);
> > +
> > +	/* Request the channel interrupt. */
> > +	sprintf(irqname, "ch%u", index);
> > +	irq = platform_get_irq_byname(pdev, irqname);
> > +	if (irq < 0) {
> > +		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
> > +		return -ENODEV;
> > +	}
> > +
> > +	rchan->irqname = devm_kmalloc(dmac->dev,
> > +				      strlen(dev_name(dmac->dev)) + 4,
> > +				      GFP_KERNEL);
> > +	if (!rchan->irqname)
> > +		return -ENOMEM;
> > +	sprintf(rchan->irqname, "%s:%u", dev_name(dmac->dev), index);
> > +
> > +	ret = devm_request_threaded_irq(dmac->dev, irq, 
rcar_dmac_isr_channel,
> > +					rcar_dmac_isr_channel_thread, 0,
> > +					rchan->irqname, rchan);
> 
> I know sh drivers do this but WHY. All other dmac drivers are happy with API
> and do tasklets.

Honestly, I don't know. I've just copied that code from shdma-base.c. It was 
introduced in commit 9a7b8e002e331d0599127f16613c32f425a14f2c ("dmaengine: add 
an shdma-base library") without a specific explanation.

I can change that. What's the rationale though ? Is it just a matter of 
realtime constraints, or are there other reasons for using tasklets instead of 
threaded IRQs ?

By the way, as callbacks can prepare new descriptors, running them in a 
tasklet means I can't sleep in the prep_* functions. It seems I can't sleep 
there for other reasons anyway, but I need to fix it, and it leaves me with no 
way to properly implement runtime PM support without using a work queue. I've 
raised the issue in "DMA engine API issue" mail thread, I'd like to sort it 
out first before fixing the driver.

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
> > +	dmac->irqname = devm_kmalloc(dmac->dev, strlen(dev_name(dmac->dev)) + 
7,
> > +				     GFP_KERNEL);
> > +	if (!dmac->irqname)
> > +		return -ENOMEM;
> > +	sprintf(dmac->irqname, "%s:error", dev_name(&pdev->dev));
> > +
> > +	ret = devm_request_irq(&pdev->dev, irq, rcar_dmac_isr_error, 0,
> > +			       dmac->irqname, dmac);
> 
> and you can get isr invoked after this while you are still enabling device.

Right (although pretty unlikely). I'll reset the device first.

> > +static int rcar_dmac_remove(struct platform_device *pdev)
> > +{
> > +	struct rcar_dmac *dmac = platform_get_drvdata(pdev);
> > +	unsigned int i;
> > +
> > +	of_dma_controller_free(pdev->dev.of_node);
> > +	dma_async_device_unregister(&dmac->engine);
> > +
> > +	pm_runtime_disable(&pdev->dev);
> > +
> > +	for (i = 0; i < dmac->n_channels; ++i)
> > +		mutex_destroy(&dmac->channels[i].power_lock);
> > +
> > +	return 0;
> 
> and what prevents you getting irq and all the irq threads running and
> executed before you do remove. Lots of potential race conditions here!

Mostly the fact that the device should be quiescent when unbounded from the 
driver. If that's not the case it means that something is still using the DMA 
engine, and that's bound to cause damages anyway as the remove function will 
free all memory allocated for device structures.

-- 
Regards,

Laurent Pinchart

