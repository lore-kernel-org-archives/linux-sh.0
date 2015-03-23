From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 23 Mar 2015 02:32:07 +0000
Subject: RE: [PATCH v2 2/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver
Message-Id: <HKNPR06MB32208DCB73732603FF61234D80D0@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426052394-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1426052394-5556-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150318082215.GF32683@intel.com>
 <SIXPR06MB33355F6F0532539A23ED8A9D8010@SIXPR06MB333.apcprd06.prod.outlook.com>
 <20150319095927.GX32683@intel.com>
In-Reply-To: <20150319095927.GX32683@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, "horms@verge.net.au" <horms@verge.net.au>, kuninori morimoto <kuninori.morimoto.gx@renesas.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Vinod,

Thank you for the reply!

> On Thu, Mar 19, 2015 at 08:12:57AM +0000, yoshihiro shimoda wrote:
> > Hi Vinod,
> >
> > Thank you for your review!
> >
> > > On Wed, Mar 11, 2015 at 02:39:54PM +0900, Yoshihiro Shimoda wrote:
> > > > +static struct dma_async_tx_descriptor *
> > > > +usb_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> > > > +		       unsigned int sg_len, enum dma_transfer_direction dir,
> > > > +		       unsigned long dma_flags, void *context)
> > > > +{
> > > > +	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
> > > > +	struct usb_dmac_desc *desc;
> > > > +
> > > > +	/* A client driver will use dmaengine_prep_slave_single() */
> > > > +	if (sg_len != 1) {
> > > and why is that?
> >
> > This is because that a usb peripheral driver (this is one of a client driver)
> > will handle a single buffer to transfer data. So, the usb peripheral driver will
> > use dmaengine_prep_slave_single().
> > Also, if this usb-dmac driver handles sg_len = 1 only, this driver code becomes more simple.
> Well having an assumption like this is not a reight design. There is nothing
> in hardware which prevents you from supporting > 1 sg_len right.
> 
> Also adding this support doesn't make driver overtly complex, see other
> drivers..

Thank you for the point. I will look other drivers and fix this.

> > > > +static enum dma_status usb_dmac_tx_status(struct dma_chan *chan,
> > > > +					  dma_cookie_t cookie,
> > > > +					  struct dma_tx_state *txstate)
> > > > +{
> > > > +	struct usb_dmac_chan *uchan = to_usb_dmac_chan(chan);
> > > > +	enum dma_status status;
> > > > +	unsigned long flags;
> > > > +	unsigned int residue;
> > > > +
> > > > +	status = dma_cookie_status(chan, cookie, txstate);
> > > > +	/* a client driver will get residue after DMA_COMPLETE */
> > > can you explain this comment?
> >
> > I'm sorry for the lack comment. This is related to the following:
> > http://thread.gmane.org/gmane.linux.drivers.devicetree/109578/focusD468
> > ==== extract from the email =====> > This USB-DMAC has a function to detect a USB specific packet (called short-length-packet).
> > If the USB-DMAC detects it, the USB-DMAC assumes the USB-DMAC completes the transfer.
> > =====================
> >
> > So, a usb peripheral driver (this is one of a client driver) will call
> > dmaengine_tx_status() after the USB-DMAC completes the transfer.
> >
> > > > +	if (!txstate)
> > > > +		return status;
> > > > +
> > > > +	spin_lock_irqsave(&uchan->vc.lock, flags);
> > > > +	residue = uchan->residue;
> > > how is this related to the cookie for which request is made?
> >
> > This implementation is not related to the cookie...
> > This is because that this driver has no chance to get the descriptor
> > after the driver calls vchan_cookie_complete().
> >
> > > > +static void usb_dmac_chan_tasklet(unsigned long data)
> > > > +{
> > > > +	struct usb_dmac_chan *chan = (struct usb_dmac_chan *)data;
> > > > +	struct usb_dmac_desc *desc = chan->desc;
> > > > +
> > > > +	spin_lock_irq(&chan->vc.lock);
> > > > +
> > > > +	/* This driver assumes a transfer finishes if desc is not NULL */
> > > > +	if (desc) {
> > > > +		chan->residue = usb_dmac_chan_get_last_residue(chan, desc);
> > > why should this be for channel and not the descriptor which is completed, so
> > > you overwrite this before user has chance to query ?
> >
> > This is related to my comment above. After the driver calls vchan_cookie_complete(),
> > the descriptor is freed. So, should this driver has "done" descriptors or something
> > to store the residue?
> >
> > > Looking at this, so you issue a transaction of 100bytes, will you get
> > > completion even if 100bytes have not been transfered, If so how does dma
> > > decide theat transfer is complete even if 100bytes are not transferred yet?
> >
> > If the USB-DMAC detects a special interrupt status (short-length-packet),
> > this driver decides that transfer is complete even if 100bytes are not transferred yet.
> Okay on this, so a descriptor can get completed even with length is not
> reached. So the question is how to communicate the length transferred.
> 
> What you have done above is not right as uchan->residue can be overwritten
> by next completion.

I understood it.

> OTOH I can think of storing the residue in the descripor and on query, check
> the descriptor in freed list and return the right residue.

I got it. I will add this code.

> You will need to manage the list carefully though

I think so.

> Also I see the tx_status callback needs fix, it doenst do residue
> calculation for in flight descriptors

I got it. I will fix this tx_status callback.

> >
> > > > +		vchan_cookie_complete(&desc->vd);
> > > > +	}
> > > > +
> > > > +	/* (Re)start the next transfer if this driver has a next desc */
> > > > +	usb_dmac_chan_start_xfer(chan);
> > > why not do this in irq :)
> >
> > Oops, I assumed that a dmaengine driver must use a tasklet.
> > However, since I think this function is not heavy, I will move this in irq.
> Yes they should use tasklet, but to mark current descriptor as complete and
> then manage the lists. You can start next one in irq.

Thank you for the comment. I understood it.

< snip >
> > > > +
> > > > +static void usb_dmac_chan_remove(struct usb_dmac_chan *uchan)
> > > > +{
> > > > +	tasklet_kill(&uchan->task);
> > > that part is good, but how about disabling irq? you can still get insterrupt
> >
> > Thank you for the point! I will add calling usb_dmac_chan_halt() to disable the interrupt.
> On top of that you should free/disable the irq as well

Does this mean I should call free_irq() or something in this remove function?
Since this driver uses devm_request_irq(), I don't think the driver call such a function.
(After this driver was removed, free_irq() was called by devm_irq_release())

To confirm whether my understanding is correct, I added some debugging codes, and
the codes output the log below. So, I thought my understanding was correct:

==== log ===devm_request_threaded_irq: dev = ee9c6210, irq = 102, dev_id = eeb62e10
devm_request_threaded_irq: dev = ee9c6210, irq = 102, dev_id = eeb62ea4
devm_request_threaded_irq: dev = ee9c6010, irq = 103, dev_id = ee1e2010
devm_request_threaded_irq: dev = ee9c6010, irq = 103, dev_id = ee1e20a4

usb_dmac_remove: dev = ee9c6010
devm_irq_release: dev = ee9c6010, irq = 103, id = ee1e20a4
devm_irq_release: dev = ee9c6010, irq = 103, id = ee1e2010
usb_dmac_remove: dev = ee9c6210
devm_irq_release: dev = ee9c6210, irq = 102, id = eeb62ea4
devm_irq_release: dev = ee9c6210, irq = 102, id = eeb62e10
=========
Best regards,
Yoshihiro Shimoda

> --
> ~Vinod
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
