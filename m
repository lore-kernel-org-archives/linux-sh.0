From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 19 Mar 2015 10:11:27 +0000
Subject: Re: [PATCH v2 2/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver
Message-Id: <20150319095927.GX32683@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426052394-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1426052394-5556-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150318082215.GF32683@intel.com>
 <SIXPR06MB33355F6F0532539A23ED8A9D8010@SIXPR06MB333.apcprd06.prod.outlook.com>
In-Reply-To: <SIXPR06MB33355F6F0532539A23ED8A9D8010-ptTgG45MbEnBsD+8QL/kzr9PrO6axcR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org" <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, kuninori morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Mar 19, 2015 at 08:12:57AM +0000, yoshihiro shimoda wrote:
> Hi Vinod,
> 
> Thank you for your review!
> 
> > On Wed, Mar 11, 2015 at 02:39:54PM +0900, Yoshihiro Shimoda wrote:
> > > +static struct dma_async_tx_descriptor *
> > > +usb_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > > +		       unsigned int sg_len, enum dma_transfer_direction dir,
> > > +		       unsigned long dma_flags, void *context)
> > > +{
> > > +	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
> > > +	struct usb_dmac_desc *desc;
> > > +
> > > +	/* A client driver will use dmaengine_prep_slave_single() */
> > > +	if (sg_len != 1) {
> > and why is that?
> 
> This is because that a usb peripheral driver (this is one of a client driver)
> will handle a single buffer to transfer data. So, the usb peripheral driver will
> use dmaengine_prep_slave_single().
> Also, if this usb-dmac driver handles sg_len = 1 only, this driver code becomes more simple.
Well having an assumption like this is not a reight design. There is nothing
in hardware which prevents you from supporting > 1 sg_len right.

Also adding this support doesn't make driver overtly complex, see other
drivers..

> > > +static enum dma_status usb_dmac_tx_status(struct dma_chan *chan,
> > > +					  dma_cookie_t cookie,
> > > +					  struct dma_tx_state *txstate)
> > > +{
> > > +	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
> > > +	enum dma_status status;
> > > +	unsigned long flags;
> > > +	unsigned int residue;
> > > +
> > > +	status = dma_cookie_status(chan, cookie, txstate);
> > > +	/* a client driver will get residue after DMA_COMPLETE */
> > can you explain this comment?
> 
> I'm sorry for the lack comment. This is related to the following:
> http://thread.gmane.org/gmane.linux.drivers.devicetree/109578/focusD468
> ==== extract from the email =====> This USB-DMAC has a function to detect a USB specific packet (called short-length-packet).
> If the USB-DMAC detects it, the USB-DMAC assumes the USB-DMAC completes the transfer.
> =====================
> 
> So, a usb peripheral driver (this is one of a client driver) will call
> dmaengine_tx_status() after the USB-DMAC completes the transfer.
> 
> > > +	if (!txstate)
> > > +		return status;
> > > +
> > > +	spin_lock_irqsave(&uchan->vc.lock, flags);
> > > +	residue = uchan->residue;
> > how is this related to the cookie for which request is made?
> 
> This implementation is not related to the cookie...
> This is because that this driver has no chance to get the descriptor
> after the driver calls vchan_cookie_complete().
> 
> > > +static void usb_dmac_chan_tasklet(unsigned long data)
> > > +{
> > > +	struct usb_dmac_chan *chan = (struct usb_dmac_chan *)data;
> > > +	struct usb_dmac_desc *desc = chan->desc;
> > > +
> > > +	spin_lock_irq(&chan->vc.lock);
> > > +
> > > +	/* This driver assumes a transfer finishes if desc is not NULL */
> > > +	if (desc) {
> > > +		chan->residue = usb_dmac_chan_get_last_residue(chan, desc);
> > why should this be for channel and not the descriptor which is completed, so
> > you overwrite this before user has chance to query ?
> 
> This is related to my comment above. After the driver calls vchan_cookie_complete(),
> the descriptor is freed. So, should this driver has "done" descriptors or something
> to store the residue?
> 
> > Looking at this, so you issue a transaction of 100bytes, will you get
> > completion even if 100bytes have not been transfered, If so how does dma
> > decide theat transfer is complete even if 100bytes are not transferred yet?
> 
> If the USB-DMAC detects a special interrupt status (short-length-packet),
> this driver decides that transfer is complete even if 100bytes are not transferred yet.
Okay on this, so a descriptor can get completed even with length is not
reached. So the question is how to communicate the length transferred.

What you have done above is not right as uchan->residue can be overwritten
by next completion.

OTOH I can think of storing the residue in the descripor and on query, check
the descriptor in freed list and return the right residue.
You will need to manage the list carefully though

Also I see the tx_status callback needs fix, it doenst do residue
calculation for in flight descriptors

> 
> > > +		vchan_cookie_complete(&desc->vd);
> > > +	}
> > > +
> > > +	/* (Re)start the next transfer if this driver has a next desc */
> > > +	usb_dmac_chan_start_xfer(chan);
> > why not do this in irq :)
> 
> Oops, I assumed that a dmaengine driver must use a tasklet.
> However, since I think this function is not heavy, I will move this in irq.
Yes they should use tasklet, but to mark current descriptor as complete and
then manage the lists. You can start next one in irq.

> 
> > > +#ifdef CONFIG_PM
> > > +static int usb_dmac_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct usb_dmac *dmac = dev_get_drvdata(dev);
> > > +	int i;
> > > +
> > > +	for (i = 0; i < dmac->n_channels; ++i)
> > > +		usb_dmac_chan_halt(&dmac->channels[i]);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int usb_dmac_runtime_resume(struct device *dev)
> > > +{
> > > +	struct usb_dmac *dmac = dev_get_drvdata(dev);
> > > +
> > > +	return usb_dmac_init(dmac);
> > > +}
> > > +#endif
> > > +
> > > +static const struct dev_pm_ops usb_dmac_pm = {
> > > +	SET_RUNTIME_PM_OPS(usb_dmac_runtime_suspend, usb_dmac_runtime_resume,
> > since you are using SET_RUNTIME_PM_OPS, you dont need to wrap this with
> > ifdef CONFIG_PM
> 
> Thank you for the point. I will fix it.
> 
> > > +
> > > +static void usb_dmac_chan_remove(struct usb_dmac_chan *uchan)
> > > +{
> > > +	tasklet_kill(&uchan->task);
> > that part is good, but how about disabling irq? you can still get insterrupt
> 
> Thank you for the point! I will add calling usb_dmac_chan_halt() to disable the interrupt.
On top of that you should free/disable the irq as well

-- 
~Vinod

