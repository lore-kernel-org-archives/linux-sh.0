From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 28 Sep 2015 11:48:07 +0000
Subject: RE: [PATCH] usb: renesas_usbhs: Add support for R-Car H3
Message-Id: <SG2PR06MB091979AD8228513ABBC0CB1DD84F0@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442556232-6564-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <87a8skyw7s.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a8skyw7s.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Morimoto-san,

Thank you for the comment.
And, I'm sorry for the delayed response.

> Sent: Friday, September 18, 2015 5:25 PM
> 
> Hi Shimoda-san
> 
> > This patch adds a compatible string to support for R-Car H3.
> >
> > Since the HS-USB controller of R-Car H3 is almost the same specification
> > with R-Car Gen2 (these have 16 pipes and usb-dmac), this patch
> > sets the "type" of renesas_usbhs_driver_param to USBHS_TYPE_RCAR_GEN2.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> (snip)
> > diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
> > index 7b98e1d..2becd6b 100644
> > --- a/drivers/usb/renesas_usbhs/common.c
> > +++ b/drivers/usb/renesas_usbhs/common.c
> > @@ -476,6 +476,10 @@ static const struct of_device_id usbhs_of_match[] = {
> >  		.compatible = "renesas,usbhs-r8a7794",
> >  		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> >  	},
> > +	{
> > +		.compatible = "renesas,usbhs-r8a7795",
> > +		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> > +	},
> 
> It is helpful for user if it is indicating Gen2 compatible.
> Because r8a7795 is Gen3

So, I will add a comment in the code like the followings:

{
	/* Gen3 is compatible with Gen2 */
	.compatible = "renesas,usbhs-r8a7795",
	.data = (void *)USBHS_TYPE_RCAR_GEN2,
},

Best regards,
Yoshihiro Shimoda

