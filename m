From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 05 Mar 2015 12:35:49 +0000
Subject: RE: [PATCH 2/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver
Message-Id: <HKNPR06MB32227E774659BA1179C9C5AD81F0@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423469645-2976-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1423469645-2976-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150305100917.GD2613@intel.com>
In-Reply-To: <20150305100917.GD2613@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "horms@verge.net.au" <horms@verge.net.au>, kuninori morimoto <kuninori.morimoto.gx@renesas.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Vinod,

Thank you for your review!

> On Mon, Feb 09, 2015 at 05:14:05PM +0900, Yoshihiro Shimoda wrote:
> > +struct usb_dmac_chan {
> > +	struct dma_chan chan;
> > +	void __iomem *iomem;
> > +	unsigned int index;
> > +
> > +	spinlock_t lock;
> > +
> > +	struct {
> > +		struct list_head free;
> > +		struct list_head pending;
> > +		struct list_head active;
> > +		struct list_head done;
> > +		struct list_head wait;
> > +		struct usb_dmac_desc *running;
> > +		struct usb_dmac_desc *last_done;
> > +
> > +		struct list_head chunks_free;
> > +
> > +		struct list_head pages;
> Thats too many lists, do we need so many? Shouldn't free and done be same
> thing. Similarly whats meant by wait here?
> Do you submit multiple descriptors to HW?

No, I don't submit multiple descriptors to HW.
So, as you say in the end of this email, I am thinking that I should use virt-dma infrastructure.

> > +static dma_cookie_t usb_dmac_tx_submit(struct dma_async_tx_descriptor *tx)
> > +{
> > +	struct usb_dmac_chan *chan = to_usb_dmac_chan(tx->chan);
> > +	struct usb_dmac_desc *desc = to_usb_dmac_desc(tx);
> > +	unsigned long flags;
> > +	dma_cookie_t cookie;
> > +
> > +	spin_lock_irqsave(&chan->lock, flags);
> > +
> > +	cookie = dma_cookie_assign(tx);
> > +
> > +	dev_dbg(chan->chan.device->dev, "chan%u: submit #%d@%p\n",
> > +		chan->index, tx->cookie, desc);
> > +
> > +	list_add_tail(&desc->node, &chan->desc.pending);
> > +	desc->running = list_first_entry(&desc->chunks,
> > +					 struct usb_dmac_xfer_chunk, node);
> what is this required for?

I'm not sure about the detail because I reuse it from rcar-dmac.c.
But, after I used virt-dma, I will remove this function, I think.

> > +static void usb_dmac_desc_put(struct usb_dmac_chan *chan,
> > +			      struct usb_dmac_desc *desc)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&chan->lock, flags);
> > +	list_splice_tail_init(&desc->chunks, &chan->desc.chunks_free);
> > +	list_add_tail(&desc->node, &chan->desc.free);
> > +	spin_unlock_irqrestore(&chan->lock, flags);
> > +}
> > +
> > +static void usb_dmac_desc_recycle_acked(struct usb_dmac_chan *chan)
> what is meant by acked here, and by whom?
> 
> > +{
> > +	struct usb_dmac_desc *desc, *_desc;
> > +	unsigned long flags;
> > +	LIST_HEAD(list);
> > +
> > +	/*
> > +	 * We have to temporarily move all descriptors from the wait list to a
> > +	 * local list as iterating over the wait list, even with
> > +	 * list_for_each_entry_safe, isn't safe if we release the channel lock
> > +	 * around the usb_dmac_desc_put() call.
> > +	 */
> > +	spin_lock_irqsave(&chan->lock, flags);
> > +	list_splice_init(&chan->desc.wait, &list);
> > +	spin_unlock_irqrestore(&chan->lock, flags);
> > +
> > +	list_for_each_entry_safe(desc, _desc, &list, node) {
> > +		if (async_tx_test_ack(&desc->async_tx)) {
> Hmmm, this part is not correct. ACK is for async_tx API and not for slave
> dmaengine drivers.

Thank you for the point. I will remove it.

> > +static int usb_dmac_alloc_chan_resources(struct dma_chan *chan)
> > +{
> > +	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
> > +	int ret;
> > +
> > +	INIT_LIST_HEAD(&uchan->desc.chunks_free);
> > +	INIT_LIST_HEAD(&uchan->desc.pages);
> > +
> > +	/* Preallocate descriptors. */
> > +	ret = usb_dmac_xfer_chunk_alloc(uchan, GFP_KERNEL);
> GFP_NOWAIT

Thank you for the point. I will fix it. (if this function is needed using virt-dma.)

> > +	if (ret < 0)
> > +		return -ENOMEM;
> > +
> > +	ret = usb_dmac_desc_alloc(uchan, GFP_KERNEL);
> Ditto

Thank you again.

> > +static int usb_dmac_chan_terminate_all(struct dma_chan *chan)
> > +{
> > +	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&uchan->lock, flags);
> > +	usb_dmac_chan_halt(uchan);
> > +	spin_unlock_irqrestore(&uchan->lock, flags);
> > +
> > +	/*
> > +	 * FIXME: No new interrupt can occur now, but the IRQ thread might still
> > +	 * be running.
> > +	 */
> and when ?

I'm not sure about the detail because I reuse it from rcar-dmac.c.
However, after I used virt-dma, this may be removed, I guess.

> > +static unsigned int
> > +usb_dmac_chan_get_residue_if_complete(struct usb_dmac_chan *chan)
> > +{
> > +	struct usb_dmac_desc *desc = chan->desc.last_done;
> > +	struct usb_dmac_xfer_chunk *chunk = desc ? desc->running : NULL;
> > +
> > +	if (!chunk)
> > +		return 0;
> > +
> > +	return usb_dmac_chan_get_last_residue(chan, chunk, desc->direction);
> and this calls for completed descriptor, wont reading HW be wrong here as
> you might have submitted another descriptor?

A client driver (especially renesas_usbhs driver) will not submit another
descriptor until it calls dmaengine_tx_status API.

> > +static enum dma_status usb_dmac_tx_status(struct dma_chan *chan,
> > +					  dma_cookie_t cookie,
> > +					  struct dma_tx_state *txstate)
> > +{
> > +	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
> > +	enum dma_status status;
> > +	unsigned long flags;
> > +	unsigned int residue;
> > +
> > +	status = dma_cookie_status(chan, cookie, txstate);
> > +	/* a client driver will get residue after DMA_COMPLETE */
> > +	if (!txstate)
> > +		return status;
> > +
> > +	spin_lock_irqsave(&uchan->lock, flags);
> > +	if (status = DMA_COMPLETE)
> > +		residue = usb_dmac_chan_get_residue_if_complete(uchan);
> if it is completed then residue should be zero, so why are we computing this

This USB-DMAC has a function to detect a USB specific packet (called short-length-packet).
If the USB-DMAC detects it, the USB-DMAC assumes the USB-DMAC completes the transfer.

For example:
 - A client driver submits 2048 bytes as RX.
 - When a USB controller received 512 + 488 bytes totally,
   the USB-DMAC detected it and completed the transfer.
  - However, a USB controller just knows the bytes of last packet (In this case, 488byte.)
        So, the USB controller driver cannot know that it got how many bytes.
    Therefore, this USB-DMAC driver is computing this bytes.

I'm not sure about the detail, but cppi41.c seems to compute the residue even if it is completed.

> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int usb_dmac_sleep_suspend(struct device *dev)
> > +{
> > +	/*
> > +	 * TODO: Wait for the current transfer to complete and stop the device.
> > +	 */
> > +	return 0;
> > +}
> > +
> > +static int usb_dmac_sleep_resume(struct device *dev)
> > +{
> > +	/* TODO: Resume transfers, if any. */
> > +	return 0;
> > +}
> > +#endif
> what is the point of these?

I'm not sure about the detail. So, I will remove it.

> > +
> > +#ifdef CONFIG_PM
> > +static int usb_dmac_runtime_suspend(struct device *dev)
> > +{
> > +	return 0;
> > +}
> ditto

Also I will remove it.

> > +static int usb_dmac_chan_probe(struct usb_dmac *dmac,
> > +			       struct usb_dmac_chan *uchan,
> > +			       unsigned int index)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dmac->dev);
> > +	struct dma_chan *chan = &uchan->chan;
> > +	char pdev_irqname[5];
> > +	char *irqname;
> > +	int irq;
> > +	int ret;
> > +
> > +	uchan->index = index;
> > +	uchan->iomem = dmac->iomem + USB_DMAC_CHAN_OFFSET(index);
> > +
> > +	spin_lock_init(&uchan->lock);
> > +
> > +	INIT_LIST_HEAD(&uchan->desc.free);
> > +	INIT_LIST_HEAD(&uchan->desc.pending);
> > +	INIT_LIST_HEAD(&uchan->desc.active);
> > +	INIT_LIST_HEAD(&uchan->desc.done);
> > +	INIT_LIST_HEAD(&uchan->desc.wait);
> > +
> > +	/* Request the channel interrupt. */
> > +	sprintf(pdev_irqname, "ch%u", index);
> > +	irq = platform_get_irq_byname(pdev, pdev_irqname);
> > +	if (irq < 0) {
> > +		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
> > +		return -ENODEV;
> > +	}
> > +
> > +	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
> > +				 dev_name(dmac->dev), index);
> > +	if (!irqname)
> > +		return -ENOMEM;
> > +
> > +	ret = devm_request_threaded_irq(dmac->dev, irq, usb_dmac_isr_channel,
> > +					usb_dmac_isr_channel_thread,
> > +					IRQF_SHARED,
> > +					irqname, uchan);
> DMA engine API expects that you are running a tasklet not a thread

Thank you for the point. I will fix it.

> > +
> > +static int usb_dmac_remove(struct platform_device *pdev)
> > +{
> > +	struct usb_dmac *dmac = platform_get_drvdata(pdev);
> > +
> > +	of_dma_controller_free(pdev->dev.of_node);
> > +	dma_async_device_unregister(&dmac->engine);
> > +
> > +	pm_runtime_disable(&pdev->dev);
> and you have not freed or disabled your irq, neither ensured all
> threads/tasklets running are stopped

I see. I will add such a code.

> Overall i feel descriptor management is overtly complicated. Can you see if
> you can you use virt-dma infrastructure, that will ease you descriptor management
> a lot

Thank you for the advice!
As I say above, I will try to use the virt-dma infrastructure.

Best regards,
Yoshihiro Shimoda

> Thanks
> --
> ~Vinod
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
