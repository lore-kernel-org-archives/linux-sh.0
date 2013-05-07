From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 May 2013 14:51:59 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
Message-Id: <4858235.no5cliV4d4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1367908563-20293-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1367908563-20293-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Tuesday 07 May 2013 16:01:14 Sergei Shtylyov wrote:
> On 07-05-2013 10:36, Laurent Pinchart wrote:
> > the USB OVC pins
> 
>     This is too vague -- I would have been more specific: USB_OVCn pins.
> 
> > are optional  alternate options
> 
>     "Optional options" sound somewhat tautological. :-)
> 
> > for USB over-current
> > detection when using a 3.3V USB interface. As they're not mandatory,
> > don't group them with the USB PENC pins.
> 
>     I'd mention a false pin conflict with HSPI on Marzen that grouping
> the pins ensued.

What about

The USB_OVCn pins alternate options for USB over-current detection when using 
a 3.3V USB interface. As they're not mandatory they can be used independently 
of the USB PENC pins. Don't group the USB_OVCn and PENC pins to avoid 
conflicts when the USB_OVCn pins are used by another function.

> > Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >   drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 45 +++++++++++++++++++++++-------
> >   1 file changed, 36 insertions(+), 9 deletions(-)
> > 
> > Simon, this is a v3.10 fix, could you apply it upon Sergei's ack ?
> > 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index d6056ed..ddc2b2e 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > @@ -2392,27 +2392,48 @@ static const unsigned int sdhi3_wp_mux[] = {
> > 
> >   };
> >   /* - USB0
> >   ------------------------------------------------------------------- */
> >   static const unsigned int usb0_pins[] = {
> > 
> > -	/* OVC */
> > -	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 26),
> > +	/* PENC */
> 
>      PENC0.

It's the PENC pin for the USB0 function, so the comments refer to PENC, not 
PENC0. Same for the other pins below.

> > +	RCAR_GP_PIN(4, 26),
> > 
> >   };
> >   static const unsigned int usb0_mux[] = {
> > 
> > -	USB_OVC0_MARK, USB_PENC0_MARK,
> > +	USB_PENC0_MARK,
> > +};
> > +static const unsigned int usb0_ovc_pins[] = {
> > +	/* OVC */
> 
>     USB_OVC0.
> 
> > +	RCAR_GP_PIN(4, 22),
> > +};
> > +static const unsigned int usb0_ovc_mux[] = {
> > +	USB_OVC0_MARK,
> > 
> >   };
> >   /* - USB1
> >   ------------------------------------------------------------------- */
> >   static const unsigned int usb1_pins[] = {
> > 
> > -	/* OVC */
> > -	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 27),
> > +	/* PENC */
> 
>      PENC1.
> 
> > +	RCAR_GP_PIN(4, 27),
> > 
> >   };
> >   static const unsigned int usb1_mux[] = {
> > 
> > -	USB_OVC1_MARK, USB_PENC1_MARK,
> > +	USB_PENC1_MARK,
> > +};
> > +static const unsigned int usb1_ovc_pins[] = {
> > +	/* OVC */
> 
>      USB_OVC1.
> 
> > +	RCAR_GP_PIN(4, 24),
> > +};
> > +static const unsigned int usb1_ovc_mux[] = {
> > +	USB_OVC1_MARK,
> > 
> >   };
> >   /* - USB2
> >   ------------------------------------------------------------------- */
> >   static const unsigned int usb2_pins[] = {
> > 
> > -	/* OVC, PENC */
> > -	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(4, 28),
> > +	/* PENC */
> 
>      PENC2.
> 
> > +	RCAR_GP_PIN(4, 28),
> > 
> >   };
> >   static const unsigned int usb2_mux[] = {
> > 
> > -	USB_OVC2_MARK, USB_PENC2_MARK,
> > +	USB_PENC2_MARK,
> > +};
> > +static const unsigned int usb2_ovc_pins[] = {
> > +	/* OVC */
> 
>      USB_OVC2.
> 
> > +	RCAR_GP_PIN(3, 29),
> > +};
> > +static const unsigned int usb2_ovc_mux[] = {
> > +	USB_OVC2_MARK,
> > 
> >   };
> >   /* - VIN0
> >   ------------------------------------------------------------------- */
> >   static const unsigned int vin0_data8_pins[] = {
> 
> Looks good otherwise. Maybe usb[0-2]_ovc_{pins|mux} should have been
> named usb[0-2]_3_3v_{pins|mux} but it seems good enough as is...

-- 
Regards,

Laurent Pinchart

