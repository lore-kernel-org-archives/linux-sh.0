From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 05 Mar 2015 16:33:20 +0000
Subject: Re: [PATCH 2/2] dmaengine: usb-dmac: Add Renesas USB DMA Controller (USB-DMAC) driver
Message-Id: <20150305162120.GK2613@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423469645-2976-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1423469645-2976-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20150305100917.GD2613@intel.com>
 <HKNPR06MB32227E774659BA1179C9C5AD81F0@HKNPR06MB322.apcprd06.prod.outlook.com>
In-Reply-To: <HKNPR06MB32227E774659BA1179C9C5AD81F0-xIjp3w5QIjwsJtb0Mgt7d79PrO6axcR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org" <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, kuninori morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, Mar 05, 2015 at 12:35:49PM +0000, yoshihiro shimoda wrote:
> Hi Vinod,
> 
> Thank you for your review!
> 
> > On Mon, Feb 09, 2015 at 05:14:05PM +0900, Yoshihiro Shimoda wrote:
> > > +struct usb_dmac_chan {
> > > +	struct dma_chan chan;
> > > +	void __iomem *iomem;
> > > +	unsigned int index;
> > > +
> > > +	spinlock_t lock;
> > > +
> > > +	struct {
> > > +		struct list_head free;
> > > +		struct list_head pending;
> > > +		struct list_head active;
> > > +		struct list_head done;
> > > +		struct list_head wait;
> > > +		struct usb_dmac_desc *running;
> > > +		struct usb_dmac_desc *last_done;
> > > +
> > > +		struct list_head chunks_free;
> > > +
> > > +		struct list_head pages;
> > Thats too many lists, do we need so many? Shouldn't free and done be same
> > thing. Similarly whats meant by wait here?
> > Do you submit multiple descriptors to HW?
> 
> No, I don't submit multiple descriptors to HW.
> So, as you say in the end of this email, I am thinking that I should use virt-dma infrastructure.
That will be good and greatly simplify..

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
> > > +	if (!txstate)
> > > +		return status;
> > > +
> > > +	spin_lock_irqsave(&uchan->lock, flags);
> > > +	if (status = DMA_COMPLETE)
> > > +		residue = usb_dmac_chan_get_residue_if_complete(uchan);
> > if it is completed then residue should be zero, so why are we computing this
> 
> This USB-DMAC has a function to detect a USB specific packet (called short-length-packet).
> If the USB-DMAC detects it, the USB-DMAC assumes the USB-DMAC completes the transfer.
> 
> For example:
>  - A client driver submits 2048 bytes as RX.
>  - When a USB controller received 512 + 488 bytes totally,
>    the USB-DMAC detected it and completed the transfer.
>   - However, a USB controller just knows the bytes of last packet (In this case, 488byte.)
>         So, the USB controller driver cannot know that it got how many bytes.
>     Therefore, this USB-DMAC driver is computing this bytes.
> 
> I'm not sure about the detail, but cppi41.c seems to compute the residue even if it is completed.
I suspected this to be case, so you are confirming my hunch, thanks :)

-- 
~Vinod

