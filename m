From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 04 Nov 2014 01:03:57 +0000
Subject: RE: [PATCH v5 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <f17a94dd97fd491692afe887fb2a9582@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414729211-3276-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414729211-3276-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> On Fri, Oct 31, 2014 at 01:20:08PM +0900, Yoshihiro Shimoda wrote:
> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >
> > This patch fixes an issue that the NULL pointer dereference happens
> > when we uses g_audio driver. Since the g_audio driver will call
> > usb_ep_disable() in afunc_set_alt() before it calls usb_ep_enable(),
> > the uep->pipe of renesas usbhs driver will be NULL. So, this patch
> > adds a condition to avoid the oops.
> >
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Fixes: 132fcb4608 (usb: gadget: Add Audio Class 2.0 Driver)
> 
> since this change is not patching the audio class driver, you can be fixing that commit. Looking at the history of that
> file, it seems like this was always broken since day one of this driver (commit 2f98382dc) and if that's the case, this
> should become:
> 
> Fixes: 2f98382dc (usb: renesas_usbhs: Add Renesas USBHS Gadget)
> Cc: <stable@vger.kernel.org> # v3.0+

Thank you very much for the point. I will fix it.

Best regards,
Yoshihiro Shimoda

> > Cc: <stable@vger.kernel.org> # v3.3+
> > ---
> >  drivers/usb/renesas_usbhs/mod_gadget.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c
> > b/drivers/usb/renesas_usbhs/mod_gadget.c
> > index 2d17c10..294d43c 100644
> > --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> > +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> > @@ -602,6 +602,9 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
> >  	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
> >  	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> >
> > +	if (!pipe)
> > +		return -EINVAL;
> > +
> >  	usbhsg_pipe_disable(uep);
> >  	usbhs_pipe_free(pipe);
> >
> > --
> > 1.7.9.5
> >
> 
> --
> balbi
