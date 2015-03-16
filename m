From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 16 Mar 2015 07:34:00 +0000
Subject: RE: [PATCH v2 1/4] usb: renesas_usbhs: fix spinlock suspected in a gadget complete function
Message-Id: <HKNPR06MB32288BD972AD6DBCAE68E71D8020@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1424051579-5060-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXOkzznW_4KJwqiO5UgYXYN2tZ+2OEYwA+eQJF2S-Z8jQ@mail.gmail.com>
 <HKNPR06MB3227796F47FE559CEAD573DD82F0@HKNPR06MB322.apcprd06.prod.outlook.com>
 <HKNPR06MB3229E4509ECB25B3620B449D8060@HKNPR06MB322.apcprd06.prod.outlook.com>
 <20150312044449.GA29718@saruman.tx.rr.com>
 <HKNPR06MB3228B5E1A95EDFCD58CF32BD8060@HKNPR06MB322.apcprd06.prod.outlook.com>
 <20150312160907.GE9261@saruman.tx.rr.com>
 <SIXPR06MB333E6503A469B6E147B20CED8070@SIXPR06MB333.apcprd06.prod.outlook.com>
 <20150313154408.GE5615@saruman.tx.rr.com>
In-Reply-To: <20150313154408.GE5615-HgARHv6XitJaoMGHk7MhZQC/G2K4zDHf@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi,

> Hi,
> 
> On Fri, Mar 13, 2015 at 01:14:01AM +0000, yoshihiro shimoda wrote:
> > > > > diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
> > > > > index e0384af77e56..e9d75d85be59 100644
> > > > > --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> > > > > +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> > > > > @@ -119,7 +119,7 @@ struct usbhsg_recip_handle {
> > > > >  /*
> > > > >   *		queue push/pop
> > > > >   */
> > > > > -static void usbhsg_queue_pop(struct usbhsg_uep *uep,
> > > > > +static void __usbhsg_queue_pop(struct usbhsg_uep *uep,
> > > > >  			     struct usbhsg_request *ureq,
> > > > >  			     int status)
> > > > >  {
> > > > > @@ -133,6 +133,15 @@ static void usbhsg_queue_pop(struct usbhsg_uep *uep,
> > > > >  	usb_gadget_giveback_request(&uep->ep, &ureq->req);
> > > > >  }
> > > > >
> > > > > +static void usbhsg_queue_pop(struct usbhsg_uep *uep,
> > > > > +			     struct usbhsg_request *ureq,
> > > > > +			     int status)
> > > > > +{
> > > > > +	usbhs_lock(priv, flags);
> > > > > +	__usbhsg_queue_pop(uep, ureq, status);
> > > > > +	usbhs_unlock(priv, flags);
> > > > > +}
> > > > > +
> > > > >  static void usbhsg_queue_done(struct usbhs_priv *priv, struct usbhs_pkt *pkt)
> > > > >  {
> > > > >  	struct usbhs_pipe *pipe = pkt->pipe;
> > > > >
> > > > >
> > > > > then, for cases where lock is already held you call __usbhsg_queue_pop()
> > > > > and for all other cases, call usbhsg_queue_pop().
> > > >
> > > > Thank you for the suggestion. However, we cannot use this
> > > > usbhsg_queue_pop() because a gadget driver might call usb_ep_queue()
> > > > in the "complete" function and this driver calls usbhs_lock() in the
> > > > usb_ep_queue().
> > >
> > > right, in that case just call __usbhs_queue_pop() directly.
> >
> > Yes. So, my understanding is that this driver always calls __usbhs_queue_pop()
> > because this driver cannot know that a gadget driver calls usb_ep_queue() or not
> > in the "complete" function.
> 
> but you don't need to know that. All you have to do is spin_unlock()
> before calling usb_gadget_giveback_request(), look at
> drivers/usb/dwc3/gadget.c::dwc3_gadget_giveback()

Thank you for the suggestion. I understood it.

> > > > Perhaps my explanation was bad, but this issue was caused by the
> > > > following conditions:
> > > >  - I use the renesas_usbhs driver as udc.
> > > >  - I use an old usb-dmac driver that the callback runs on a kthread.
> > > >  - I use the ncm driver. In this environment, the ncm driver might
> > > >	cause a spinlock suspected.
> > > >
> > > > As an old solution, I fixed the renesas_usbhs driver by this patch.
> > > > However, if I use a new usb-dmac driver that the callback runs on a
> > > > tasklet, I don't need this patch. (This is a new solution.)
> > >
> > > then differentiate based on some revision register or something like
> > > that ?
> >
> > Sorry for the lack information. I am submitting this usb-dmac driver that
> > the callback runs on a tasklet now. This means that the driver is not
> > merged yet. So, I think that we don't need to differentiate.
> 
> But as soon as your driver gets merged, you will need to differentiate,
> right ?

Right. So, I will submit v3 patch soon.

Best regards,
Yoshihiro Shimoda

> --
> balbi
