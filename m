From: Simon Horman <horms@verge.net.au>
Date: Tue, 21 May 2013 09:08:41 +0000
Subject: Re: [PATCH v2] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
Message-Id: <20130521090839.GA20703@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368610420-3961-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1368610420-3961-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[ Cc: Nguyen Hong Ky <nh-ky@jinso.co.jp> ]

On Thu, May 16, 2013 at 02:12:06PM +0900, Simon Horman wrote:
> On Wed, May 15, 2013 at 11:33:40AM +0200, Laurent Pinchart wrote:
> > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > The USB_OVCn pins are alternate options for USB over-current detection
> > when using a 3.3V USB interface. As they're not mandatory they can be
> > used independently of the USB PENC pins. Don't group the USB_OVCn and
> > PENC pins to avoid conflicts when the USB_OVCn pins are used by another
> > function.
> > 
> > Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 45 ++++++++++++++++++++++++++++--------
> >  1 file changed, 36 insertions(+), 9 deletions(-)
> > 
> > Simon, this should fix your pinctrl conflict issue for renesas-next-20130515v2
> > + v3.10-rc1.
> 
> Thanks, I have confirmed that it resolves the problem I was seeing.

Unfortuantely this problem appears to be present in v3.10-rc2
(and I assume v3.10-rc1 too). Would it be possible for you to
make a version of this patch that applies there?

I guess then we will have the great joy of merging or rebasing
the pinmux branch :-)

> 
> I have queued it up locally in the pinmux branch.
> I am holding off on pushing that and all my other branches re-based
> on top of v3.10-rc1 until I have shaken out other problems that
> surfaces during build and boot testing.
> 
> So far the only problem I am aware of is resolved by 
> "[PATCH] ARM: shmobile: marzen: Use error values in usb_power_*",
> which I posted a few minutes ago.

I have run into some problems with TWD on marzen and kzm9g which
Magnus and I are trying to work through. Sorry for the delay.

> 
> > 
> > Changes since v1:
> > 
> > - Reworked the commit message
> > - Rename OVC to USB_OVC in the pin description comments
> > 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > index 835611e..96bdf48 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > @@ -2424,27 +2424,48 @@ static const unsigned int sdhi3_wp_mux[] = {
> >  };
> >  /* - USB0 ------------------------------------------------------------------- */
> >  static const unsigned int usb0_pins[] = {
> > -	/* OVC */
> > -	RCAR_GP_PIN(4, 22), RCAR_GP_PIN(4, 26),
> > +	/* PENC */
> > +	RCAR_GP_PIN(4, 26),
> >  };
> >  static const unsigned int usb0_mux[] = {
> > -	USB_OVC0_MARK, USB_PENC0_MARK,
> > +	USB_PENC0_MARK,
> > +};
> > +static const unsigned int usb0_ovc_pins[] = {
> > +	/* USB_OVC */
> > +	RCAR_GP_PIN(4, 22),
> > +};
> > +static const unsigned int usb0_ovc_mux[] = {
> > +	USB_OVC0_MARK,
> >  };
> >  /* - USB1 ------------------------------------------------------------------- */
> >  static const unsigned int usb1_pins[] = {
> > -	/* OVC */
> > -	RCAR_GP_PIN(4, 24), RCAR_GP_PIN(4, 27),
> > +	/* PENC */
> > +	RCAR_GP_PIN(4, 27),
> >  };
> >  static const unsigned int usb1_mux[] = {
> > -	USB_OVC1_MARK, USB_PENC1_MARK,
> > +	USB_PENC1_MARK,
> > +};
> > +static const unsigned int usb1_ovc_pins[] = {
> > +	/* USB_OVC */
> > +	RCAR_GP_PIN(4, 24),
> > +};
> > +static const unsigned int usb1_ovc_mux[] = {
> > +	USB_OVC1_MARK,
> >  };
> >  /* - USB2 ------------------------------------------------------------------- */
> >  static const unsigned int usb2_pins[] = {
> > -	/* OVC, PENC */
> > -	RCAR_GP_PIN(3, 29), RCAR_GP_PIN(4, 28),
> > +	/* PENC */
> > +	RCAR_GP_PIN(4, 28),
> >  };
> >  static const unsigned int usb2_mux[] = {
> > -	USB_OVC2_MARK, USB_PENC2_MARK,
> > +	USB_PENC2_MARK,
> > +};
> > +static const unsigned int usb2_ovc_pins[] = {
> > +	/* USB_OVC */
> > +	RCAR_GP_PIN(3, 29),
> > +};
> > +static const unsigned int usb2_ovc_mux[] = {
> > +	USB_OVC2_MARK,
> >  };
> >  /* - VIN0 ------------------------------------------------------------------- */
> >  static const unsigned int vin0_data8_pins[] = {
> > @@ -2675,8 +2696,11 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
> >  	SH_PFC_PIN_GROUP(sdhi3_cd),
> >  	SH_PFC_PIN_GROUP(sdhi3_wp),
> >  	SH_PFC_PIN_GROUP(usb0),
> > +	SH_PFC_PIN_GROUP(usb0_ovc),
> >  	SH_PFC_PIN_GROUP(usb1),
> > +	SH_PFC_PIN_GROUP(usb1_ovc),
> >  	SH_PFC_PIN_GROUP(usb2),
> > +	SH_PFC_PIN_GROUP(usb2_ovc),
> >  	SH_PFC_PIN_GROUP(vin0_data8),
> >  	SH_PFC_PIN_GROUP(vin0_clk),
> >  	SH_PFC_PIN_GROUP(vin0_sync),
> > @@ -2875,14 +2899,17 @@ static const char * const sdhi3_groups[] = {
> >  
> >  static const char * const usb0_groups[] = {
> >  	"usb0",
> > +	"usb0_ovc",
> >  };
> >  
> >  static const char * const usb1_groups[] = {
> >  	"usb1",
> > +	"usb1_ovc",
> >  };
> >  
> >  static const char * const usb2_groups[] = {
> >  	"usb2",
> > +	"usb2_ovc",
> >  };
> >  
> >  static const char * const vin0_groups[] = {
> > -- 
> > Regards,
> > 
> > Laurent Pinchart
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
