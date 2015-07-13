From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 13 Jul 2015 15:22:59 +0000
Subject: RE: [PATCH v5] usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS
Message-Id: <SIXPR06MB0639856FCA734EC44BF54CFAF59C0@SIXPR06MB0639.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3446210.Evs1k3c1oP@avalon> <1989113.aQDiRBvWpG@avalon>
 <SIXPR06MB0639B6B493881EBB77A59A01F5910@SIXPR06MB0639.apcprd06.prod.outlook.com>
 <8728955.GfUuMsjafi@avalon>
In-Reply-To: <8728955.GfUuMsjafi@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Ulrich Hecht <ulrich.hecht@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Laurent,

On 09 July 2015 02:03, Laurent wrote:
> Hi Phil,
> 
> On Wednesday 08 July 2015 08:08:27 Phil Edworthy wrote:
> > On 08 July 2015 00:08, Laurent wrote:
> > > On Tuesday 07 July 2015 12:52:43 Phil Edworthy wrote:
> > > > These changes allow a PHY driver to trigger a VBUS interrupt and
> > > > to provide the value of VBUS.
> > > >
> > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > >
> > > This looks much better to me. I just have two comments, please see below.
> > >
> > > > ---
> > > >
> > > > v5:
> > > >   - Avoid race when vbus_is_indirect may or may not be read
> > > >
> > > >     before the phy has called vbus_session. In doing so, the
> > > >     changes have also been isolated to mod_gadget.c
> > > >
> > > > v4:
> > > >   - Use true/false with bool vars.
> > > >   - Clean up "transceiver found" message.
> > > >
> > > > v3:
> > > >   - Changed how indirect vbus is plumbed in.
> > > >   - Removed unnecessary (void) on call to otg_set_peripheral.
> > > >   - Moved code that connects to bus through transceiver so it
> > > >
> > > >     is before setting gpriv->driver.
> > > >
> > > > v2:
> > > >   - vbus variables changed from int to bool.
> > > >   - dev_info() changed to dev_err()
> > > >
> > > > ---
> > > >
> > > >  drivers/usb/renesas_usbhs/mod_gadget.c | 62
> +++++++++++++++++++++++++++
> > > >  1 file changed, 62 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c
> > > > b/drivers/usb/renesas_usbhs/mod_gadget.c index dc2aa32..19a22a3
> 100644
> > > > --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> > > > +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> 
> [snip]
> 
> > > > @@ -882,12 +906,28 @@ static int usbhsg_gadget_start(struct usb_gadget
> > > > *gadget,
> > > >  {
> > > >  	struct usbhsg_gpriv *gpriv = usbhsg_gadget_to_gpriv(gadget);
> > > >  	struct usbhs_priv *priv = usbhsg_gpriv_to_priv(gpriv);
> > > > +	struct device *dev = usbhs_priv_to_dev(priv);
> > > > +	int ret;
> > > >
> > > >  	if (!driver		||
> > > >  	    !driver->setup	||
> > > >  	    driver->max_speed < USB_SPEED_FULL)
> > > >  		return -EINVAL;
> > > >
> > > > +	/* connect to bus through transceiver */
> > > > +	if (!IS_ERR_OR_NULL(gpriv->transceiver)) {
> > > > +		ret = otg_set_peripheral(gpriv->transceiver->otg,
> > > > +					&gpriv->gadget);
> > > > +		if (ret) {
> > > > +			dev_err(dev, "%s: can't bind to transceiver\n",
> > > > +				gpriv->gadget.name);
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		/* get vbus using phy versions */
> > > > +		usbhs_mod_phy_mode(priv);
> > >
> > > Given that the presence of an external PHY is known at probe time,
> > > couldn't this call be moved to the probe function ? It would then probably
> > > conflict with the usbhs_mod_autonomy_mode() call from usbhs_probe(),
> which
> > > would need to be fixed.
> >
> > You could do this, but as you say it would conflict with usbhs_probe(). I
> > can't see a simple way to check for the external phy connection, so I would
> > prefer to keep it here.
> > Is that ok?
> 
> I can live with that, but I can't help feeling that it's not the best
> architecture. Coming to think about it, why do we get the transceiver (by
> calling usb_get_phy) in the gadget code ? Isn't the transceiver shared between
> host and peripheral modes ? Shouldn't it be handled by core code then ? I
> might miss something as my knowledge of the USB subsystem isn't perfect.
I suspect your knowledge of it is much better than mine!

 
> If we decide to refactor the code it can be done in a follow-up patch, this
> patch has been delayed for long enough.
Ok, thanks. I'll fix the variable name and re-post.

> > > > +	}
> > > > +
> > > >
> > > >  	/* first hook up the driver ... */
> > > >  	gpriv->driver = driver;
> 
> --
> Regards,
> 
> Laurent Pinchart

Thanks
Phil
