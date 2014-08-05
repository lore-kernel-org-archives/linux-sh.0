From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 05 Aug 2014 23:35:07 +0000
Subject: Re: [PATCH 5/6] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <1435319.y2a78rkErx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
In-Reply-To: <7ae1dbb4f4a79a529250600cc2eeb7c31a644938.1406766014.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

On Tuesday 05 August 2014 22:18:27 Vinod Koul wrote:
> On Mon, Aug 04, 2014 at 06:30:51PM +0200, Laurent Pinchart wrote:
> > > > +static int rcar_dmac_alloc_chan_resources(struct dma_chan *chan)
> > > > +{
> > > > +	struct rcar_dmac_chan *rchan = to_rcar_dmac_chan(chan);
> > > > +	int ret;
> > > > +
> > > > +	INIT_LIST_HEAD(&rchan->desc.free);
> > > > +	INIT_LIST_HEAD(&rchan->desc.pending);
> > > > +	INIT_LIST_HEAD(&rchan->desc.active);
> > > > +	INIT_LIST_HEAD(&rchan->desc.done);
> > > > +	INIT_LIST_HEAD(&rchan->desc.wait);
> > > > +	INIT_LIST_HEAD(&rchan->desc.hw_free);
> > > > +	INIT_LIST_HEAD(&rchan->desc.pages);
> > > 
> > > Seriously we need so many lists? 1st three makes sense but what is delta
> > > b/w done and free. Once a descriptor is done it should be moved to
> > > freee list.
> > > 
> > > What does wait list mean and the last two?
> > 
> > The free list contains descriptors that have been allocated and are not
> > used. Those can be descriptors preallocated and not used yet, or
> > descriptors that have been used and recycled.
> > 
> > The pending list contains descriptors submitted (through dmaengine_submit)
> > but not issued (with dma_async_issue_pending) yet.
> > 
> > The active list contains descriptors issued with dma_async_issue_pending.
> > The list tail is or will be processed by the hardware, and the other
> > elements in the list will be processed in turn.
> > 
> > The done list contains descriptors that have been processed by the
> > hardware but haven't been processed by the interrupt thread (I'll discuss
> > thread vs.tasklet below) yet. Descriptors are added to the done list in
> > the interrupt handler, and taken from the list by the interrupt thread.
> > 
> > The wait list contains descriptors processed by the interrupt thread for
> > which the completion callback has been called, but that haven't been
> > acked (tested with async_tx_test_ack) yet. Descriptors are added to that
> > list after calling their callback function, and the list is then
> > processed by rcar_dmac_desc_recycle_acked (called both from the interrupt
> > thread and from the descriptor allocation function) to move all acked
> > descriptors back to the free list.
> 
> Okay but do we really need the two list for transistions? The descriptors in
> active_list can be marked for intermediate stages and then pushed to
> free_list.

Using separate lists seem simpler to me, as I can minimize the amount of code 
executed with a spinlock held by using the list splice API and then iterating 
over a private list after releasing the lock, instead of iterating over the 
whole list and checking the state of every descriptor with the spinlock held. 
Feel free to prove me wrong if you can see an easy implementation that gets 
rid of the wait list though :-)

> Also second question, do you submit multiple clinet request in a single go
> to hardware or it is usually one descriptor?

It depends what you mean by descriptor. The driver is always involved to push 
the next transaction (dma_async_tx_descriptor) to the hardware. When a 
transaction is split into multiple hardware transfers, the driver creates an 
array of hardware transfer descriptors and submits it in one go (except when 
the source or destination addresses are above 4GB, in which case the hardware 
isn't able to chain transfers).

> >> okay this bit needs modification. The channel can be configured in any
> >> direction. SO you can have one descriptor doing DMA_DEV_TO_MEM and
> >> another DMA_MEM_TO_DEV. The prep_ calls have direction arg to be used,
> >> so please store both :)
> > 
> > Right, but before fixing that, let's document exactly how the struct
> > dma_slave_config field are supposed to be used.
> > 
> > The direction field is documented in the header as
> > 
> >  * @direction: whether the data shall go in or out on this slave
> >  * channel, right now. DMA_MEM_TO_DEV and DMA_DEV_TO_MEM are
> >  * legal values.
> > 
> > That seems to contradict your statement.
> 
> Yes certainly, we need to fix that too :)

I was expecting you to tell how you would like that to be fixed... What's the 
right interpretation of the dma_slave_config direction field ?

> >>> +static size_t rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
> >>> +					 dma_cookie_t cookie)
> >>> +{
> >>> +	struct rcar_dmac_desc *desc = chan->desc.running;
> >>> +	struct rcar_dmac_hw_desc *hwdesc;
> >>> +	size_t residue = 0;
> >>> +
> >>> +	if (!desc)
> >>> +		return 0;
> >> 
> >> Why?
> >> We should be able to query even when channel is not running, right?
> > 
> > Good question, should we ? :-)
> > 
> > This would require going through all lists to find the descriptor
> > corresponding to the cookie, and returning either 0 (if the descriptor has
> > been processed completely) or the descriptor length (if it hasn't been
> > processed yet). This is potentially costly.
> 
> Not really, the status of descriptor will tell you.
> 
> > The first case can be easily handled using the cookie only, when
> > dma_cookie_status() state returns DMA_COMPLETE then we know that the
> > residue is 0. This is actually the current behaviour, as
> > dma_cookie_status() zeroes the residue field.a
> 
> yes this is the key
> 
> > Is the second case something we need to support ? chan->desc.running is
> > only NULL when there's no descriptor to process. In that case the cookie
> > can either correspond to a descriptor already complete (first case), a
> > descriptor prepared but not submitted or an invalid descriptor (in which
> > case we can't report the residue anyway). Is there really a use case for
> > reporting the residue for a descriptor not submitted ? That seems like a
> > bad use of the API to me, I think it would be better to forbid it.
> 
> So you need to check only running list. For the queued up descriptor it is
> easy enough. For the one which is running you are already doing the
> calculation. For completed but still not preocessed it is zero anyway

I'm still not convinced. Reporting the residue for a descriptor that hasn't 
been started yet will require looping through lists with locks held, and I'm 
not sure to see what benefit it would bring. Do we have DMA engine users that 
retrieve (and use) the residue value of descriptors that haven't been started 
yet ?

> >>> +static int rcar_dmac_slave_caps(struct dma_chan *chan,
> >>> +				struct dma_slave_caps *caps)
> >>> +{
> >>> +	memset(caps, 0, sizeof(*caps));
> >>> +
> >>> +	/*
> >>> +	 * The device supports all widths from 1 to 64 bytes. As the
> >>> +	 * dma_slave_buswidth enumeration is limited to 8 bytes, set the
> >>> +	 * numerical value directly.
> >>> +	 */
> >>> +	caps->src_addr_widths = 0x7f;
> >>> +	caps->dstn_addr_widths = 0x7f;
> >> 
> >> no magic numbers pls
> > 
> > Come on, 0x7f is hardly magic ;-)
> 
> For you yes, but down the line someone would scrath their head on why this
> was 0x7f :)
> 
> > Should I add DMA_SLAVE_BUSWIDTH_16_BYTES, DMA_SLAVE_BUSWIDTH_32_BYTES and
> > DMA_SLAVE_BUSWIDTH_64_BYTES to enum dma_slave_buswidth ?
> 
> Yup

OK, will do.

> >>> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_RUNTIME)
> >>> +static int rcar_dmac_suspend(struct device *dev)
> >>> +{
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +static int rcar_dmac_resume(struct device *dev)
> >>> +{
> >>> +	struct rcar_dmac *dmac = dev_get_drvdata(dev);
> >>> +
> >>> +	return rcar_dmac_init(dmac);
> >>> +}
> >>> +#endif
> >> 
> >> I dont think you need these as you are using PM macros.
> > 
> > Then gcc will complain above functions being defined and not used.
> 
> oh, then we should fix in the macro itself rather than adding in driver.

Fix what, the SET_SYSTEM_SLEEP_PM_OPS and SET_RUNTIME_PM_OPS macros ? How so ?

> >>> +static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
> >>> +				struct rcar_dmac_chan *rchan,
> >>> +				unsigned int index)
> >>> +{
> >>> +	struct platform_device *pdev = to_platform_device(dmac->dev);
> >>> +	struct dma_chan *chan = &rchan->chan;
> >>> +	char irqname[5];
> >>> +	int irq;
> >>> +	int ret;
> >>> +
> >>> +	rchan->index = index;
> >>> +	rchan->iomem = dmac->iomem + RCAR_DMAC_CHAN_OFFSET(index);
> >>> +	rchan->mid_rid = -EINVAL;
> >>> +
> >>> +	spin_lock_init(&rchan->lock);
> >>> +	mutex_init(&rchan->power_lock);
> >>> +
> >>> +	/* Request the channel interrupt. */
> >>> +	sprintf(irqname, "ch%u", index);
> >>> +	irq = platform_get_irq_byname(pdev, irqname);
> >>> +	if (irq < 0) {
> >>> +		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
> >>> +		return -ENODEV;
> >>> +	}
> >>> +
> >>> +	rchan->irqname = devm_kmalloc(dmac->dev,
> >>> +				      strlen(dev_name(dmac->dev)) + 4,
> >>> +				      GFP_KERNEL);
> >>> +	if (!rchan->irqname)
> >>> +		return -ENOMEM;
> >>> +	sprintf(rchan->irqname, "%s:%u", dev_name(dmac->dev), index);
> >>> +
> >>> +	ret = devm_request_threaded_irq(dmac->dev, irq,
> > 
> > rcar_dmac_isr_channel,
> > 
> >>> +					rcar_dmac_isr_channel_thread, 0,
> >>> +					rchan->irqname, rchan);
> >> 
> >> I know sh drivers do this but WHY. All other dmac drivers are happy with
> >> API and do tasklets.
> > 
> > Honestly, I don't know. I've just copied that code from shdma-base.c. It
> > was introduced in commit 9a7b8e002e331d0599127f16613c32f425a14f2c
> > ("dmaengine: add an shdma-base library") without a specific explanation.
> > 
> > I can change that. What's the rationale though ? Is it just a matter of
> > realtime constraints, or are there other reasons for using tasklets
> > instead of threaded IRQs ?
> > 
> > By the way, as callbacks can prepare new descriptors, running them in a
> > tasklet means I can't sleep in the prep_* functions. It seems I can't
> > sleep there for other reasons anyway, but I need to fix it, and it leaves
> > me with no way to properly implement runtime PM support without using a
> > work queue. I've raised the issue in "DMA engine API issue" mail thread,
> > I'd like to sort it out first before fixing the driver.
> 
> Okay lets sort that out first

I'm all ears, please give me your opinion in a reply to that mail thread.

-- 
Regards,

Laurent Pinchart

