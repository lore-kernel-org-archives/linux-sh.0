From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 30 Oct 2014 06:47:07 +0000
Subject: RE: [PATCH v2 2/4] usb: renesas_usbhs: gadget: fix the behavior of pullup
Message-Id: <88b4b558bfc140fe97860dbf52e67ce5@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414641767-5780-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414641767-5780-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

> Hi shimoda-san
> 
> > From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> >
> > This patch fixes an issue that this driver always enable the D+ pullup
> > after it detected the VBUS connection even though this usb controller
> > can control the D+ pullup timing by software. So, this driver should
> > enable the D+ pullup after a gadget driver called usb_gadget_connect().
> >
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> (snip)
> > diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c
> > b/drivers/usb/renesas_usbhs/mod_gadget.c
> > index 2d0903f..0d50be0 100644
> > --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> > +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> > @@ -56,6 +56,8 @@ struct usbhsg_gpriv {
> >  #define USBHSG_STATUS_REGISTERD		(1 << 1)
> >  #define USBHSG_STATUS_WEDGE		(1 << 2)
> >  #define USBHSG_STATUS_SELF_POWERED	(1 << 3)
> > +
> > +	unsigned		softconnect:1;
> >  };
> 
> We can re-use USBHSG_STATUS_xxx instead of new variable ?
> renesas_usb driver has usbhsg_status_xxx() macro.

Thank you for the review.
Yes, we can re-use that. So, I will fix this patch.

Best regards,
Yoshihiro Shimoda

> Best regards
> ---
> Kuninori Morimoto
