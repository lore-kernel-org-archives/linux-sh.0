From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 31 Oct 2014 00:06:06 +0000
Subject: RE: [PATCH v3 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <d067d3dd831249a29183c371aa2d26c0@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414665019-1340-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414665019-1340-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> On Thu, Oct 30, 2014 at 07:30:16PM +0900, Yoshihiro Shimoda wrote:
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
> > Cc: <stable@vger.kernel.org>
> > ---
> >  drivers/usb/renesas_usbhs/mod_gadget.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c
> > b/drivers/usb/renesas_usbhs/mod_gadget.c
> > index 2d17c10..2d0903f 100644
> > --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> > +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> > @@ -602,6 +602,9 @@ static int usbhsg_ep_disable(struct usb_ep *ep)
> >  	struct usbhsg_uep *uep = usbhsg_ep_to_uep(ep);
> >  	struct usbhs_pipe *pipe = usbhsg_uep_to_pipe(uep);
> >
> > +	if (!uep || !uep->pipe)
> 
> how can uep ever be NULL ? Look at the definition of usbhsg_ep_to_uep():
> 
> 	#define usbhsg_ep_to_uep(e)             container_of(e, struct usbhsg_uep, ep)
> 
> how can a container_of() ever return NULL ? What you should check if "ep" (the argument to this function) being NULL.

Thank you for the point.
Morimoto-san also pointed out this code at v1 patch. But I forgot to fix it...
We can change the "if (!uep || !uep->pipe)" to "if (!pipe)".

I will fix this patch.

Best regards,
Yoshihiro Shimoda

