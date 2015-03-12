From: Felipe Balbi <balbi@ti.com>
Date: Thu, 12 Mar 2015 16:09:07 +0000
Subject: Re: [PATCH v2 1/4] usb: renesas_usbhs: fix spinlock suspected in a gadget complete function
Message-Id: <20150312160907.GE9261@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="SNIs70sCzqvszXB4"
List-Id: <linux-sh.vger.kernel.org>
References: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1424051579-5060-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXOkzznW_4KJwqiO5UgYXYN2tZ+2OEYwA+eQJF2S-Z8jQ@mail.gmail.com>
 <HKNPR06MB3227796F47FE559CEAD573DD82F0@HKNPR06MB322.apcprd06.prod.outlook.com>
 <HKNPR06MB3229E4509ECB25B3620B449D8060@HKNPR06MB322.apcprd06.prod.outlook.com>
 <20150312044449.GA29718@saruman.tx.rr.com>
 <HKNPR06MB3228B5E1A95EDFCD58CF32BD8060@HKNPR06MB322.apcprd06.prod.outlook.com>
In-Reply-To: <HKNPR06MB3228B5E1A95EDFCD58CF32BD8060@HKNPR06MB322.apcprd06.prod.outlook.com>
To: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "balbi@TI.COM" <balbi@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, USB list <linux-usb@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 12, 2015 at 05:40:56AM +0000, yoshihiro shimoda wrote:
> Hi,
>=20
> > On Thu, Mar 12, 2015 at 04:33:41AM +0000, yoshihiro shimoda wrote:
> > > Hi Geert-san again,
> > >
> > > > Hi Geert-san,
> > > >
> > > > Thank you for the reply again!
> > > >
> > > > > Hi Shimoda-san,
> > > > >
> > > > > On Mon, Feb 16, 2015 at 2:52 AM, Yoshihiro Shimoda
> > > > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > > > According to the gadget.h, a "complete" function will always be=
 called
> > > > > > with interrupts disabled. However, sometimes usbhsg_queue_pop()=
 function
> > > > > > is called with interrupts enabled. So, this function should cal=
ls
> > > > > > local_irq_save() before this calls the usb_gadget_giveback_requ=
est().
> > > > > > Otherwise, there is possible to cause a spinlock suspected in a=
 gadget
> > > > > > complete function.
> > > > >
> > > > > I still feel uneasy about adding the call to local_irq_save(), as=
 the need for
> > > > > this is usually an indicator of another locking problem.
> > > >
> > > > I also think that I would like to avoid using local_irq_save().
> > > > But, I have no idea to resolve this issue for now.
> > >
> > > After I modified usb-dmac driver to use a tasklet instead of a kthrea=
d,
> > > this issue disappeared.
> > >
> > > My understanding is the followings:
> > > - According to the backtrace below, during usbhsf_dma_complete() was =
running,
> > >  a softirq happened. After ncm_tx_tasklet() was called, the issue hap=
pened.
> > > http://thread.gmane.org/gmane.linux.usb.general/122023/focus=3D43729
> > >
> > > - This means that usbhsf_dma_complete() ran on a kthread. So, ncm dri=
ver is able
> > >   to do the ncm_tx_tasklet().
> > >
> > > - After the current usb-dmac driver, since usbhsf_dma_complete() runs=
 on a tasklet,
> > >   ncm driver is not able to do the ncm_tx_tasklet during usbhsf_dma_c=
omplete() was running.
> > >
> > >
> > > So, I would like to recall this patch and I will resubmit this patch =
series as v3.
> >=20
> > try something like below:
> >=20
> > diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renes=
as_usbhs/mod_gadget.c
> > index e0384af77e56..e9d75d85be59 100644
> > --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> > +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> > @@ -119,7 +119,7 @@ struct usbhsg_recip_handle {
> >  /*
> >   *		queue push/pop
> >   */
> > -static void usbhsg_queue_pop(struct usbhsg_uep *uep,
> > +static void __usbhsg_queue_pop(struct usbhsg_uep *uep,
> >  			     struct usbhsg_request *ureq,
> >  			     int status)
> >  {
> > @@ -133,6 +133,15 @@ static void usbhsg_queue_pop(struct usbhsg_uep *ue=
p,
> >  	usb_gadget_giveback_request(&uep->ep, &ureq->req);
> >  }
> >=20
> > +static void usbhsg_queue_pop(struct usbhsg_uep *uep,
> > +			     struct usbhsg_request *ureq,
> > +			     int status)
> > +{
> > +	usbhs_lock(priv, flags);
> > +	__usbhsg_queue_pop(uep, ureq, status);
> > +	usbhs_unlock(priv, flags);
> > +}
> > +
> >  static void usbhsg_queue_done(struct usbhs_priv *priv, struct usbhs_pk=
t *pkt)
> >  {
> >  	struct usbhs_pipe *pipe =3D pkt->pipe;
> >=20
> >=20
> > then, for cases where lock is already held you call __usbhsg_queue_pop()
> > and for all other cases, call usbhsg_queue_pop().
>=20
> Thank you for the suggestion. However, we cannot use this
> usbhsg_queue_pop() because a gadget driver might call usb_ep_queue()
> in the "complete" function and this driver calls usbhs_lock() in the
> usb_ep_queue().

right, in that case just call __usbhs_queue_pop() directly.

> Perhaps my explanation was bad, but this issue was caused by the
> following conditions:
>  - I use the renesas_usbhs driver as udc.
>  - I use an old usb-dmac driver that the callback runs on a kthread.
>  - I use the ncm driver. In this environment, the ncm driver might
>	cause a spinlock suspected.
>=20
> As an old solution, I fixed the renesas_usbhs driver by this patch.
> However, if I use a new usb-dmac driver that the callback runs on a
> tasklet, I don't need this patch. (This is a new solution.)

then differentiate based on some revision register or something like
that ?

--=20
balbi

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAboiAAoJEIaOsuA1yqREd1kP+gKyP0c4bpqoe5QgNz+riR6x
hjr/zG+LdWFG2Z34tKzbGwIETfKpWpRSeWioQ/PLaAA1cWx9zBXesqVPmfDIq6E7
2Uv5w913RkwL/7/YspFoIr5KF8nX1z6P8ihdCQ5rC3V1pRSTYEinA+NMwp6M/H4b
/X4QV3fAwfv8wkSP1a84jBsUncc0ovVTpgrqoPCQqZDicFaY2oHjeUsFjzOWMYcm
yuYfaPlxxSc9xTXfsVE+MetKQLnJLMeK1JA1wOoJ6lp6tL/k3KYz38NZZE3VjW9R
pR0HCIZLDWOCZwr8/WbpGish619gGQP9meCeTdAj4fpYoqmYoXV9VxaUXJQ3oXZ4
Hg4YVlXcvO7+EF6HS29XGfzieA1omF389nmMOzSsDJ98Bvx+pOjH4lLZ0Jl34AbF
QmNewGFEp6nR5LmeVM9MI/9bQw9wfkkPYYT/OtQ4EwDYBYIScwYwAq0Ry5TzCMXj
vDqqL6w63nGRCbro1Zt8xpeBbzWpY+gELqJDq40/jBSO7T3qHwjf7GsCSI+XKjxl
SOv5PNxf79p6sGkWGOThHeFprAt9ZLFeStPUDKV97txH1mKO2LWAMe58IWUbLuyI
rRyQKoo9EOAaPGZFZq5m7mYR4GV205iQyeYGVoGpT3bmD4Qy8QPdDKhk3z7w0/+F
bx7KWM+IQNDWGCNXu8mP
=UEVO
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
