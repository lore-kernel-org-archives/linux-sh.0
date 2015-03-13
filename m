From: Felipe Balbi <balbi@ti.com>
Date: Fri, 13 Mar 2015 15:44:08 +0000
Subject: Re: [PATCH v2 1/4] usb: renesas_usbhs: fix spinlock suspected in a gadget complete function
Message-Id: <20150313154408.GE5615@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E7i4zwmWs5DOuDSH"
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
In-Reply-To: <SIXPR06MB333E6503A469B6E147B20CED8070@SIXPR06MB333.apcprd06.prod.outlook.com>
To: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "balbi@ti.com" <balbi@ti.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, USB list <linux-usb@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--E7i4zwmWs5DOuDSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 13, 2015 at 01:14:01AM +0000, yoshihiro shimoda wrote:
> > > > diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/r=
enesas_usbhs/mod_gadget.c
> > > > index e0384af77e56..e9d75d85be59 100644
> > > > --- a/drivers/usb/renesas_usbhs/mod_gadget.c
> > > > +++ b/drivers/usb/renesas_usbhs/mod_gadget.c
> > > > @@ -119,7 +119,7 @@ struct usbhsg_recip_handle {
> > > >  /*
> > > >   *		queue push/pop
> > > >   */
> > > > -static void usbhsg_queue_pop(struct usbhsg_uep *uep,
> > > > +static void __usbhsg_queue_pop(struct usbhsg_uep *uep,
> > > >  			     struct usbhsg_request *ureq,
> > > >  			     int status)
> > > >  {
> > > > @@ -133,6 +133,15 @@ static void usbhsg_queue_pop(struct usbhsg_uep=
 *uep,
> > > >  	usb_gadget_giveback_request(&uep->ep, &ureq->req);
> > > >  }
> > > >
> > > > +static void usbhsg_queue_pop(struct usbhsg_uep *uep,
> > > > +			     struct usbhsg_request *ureq,
> > > > +			     int status)
> > > > +{
> > > > +	usbhs_lock(priv, flags);
> > > > +	__usbhsg_queue_pop(uep, ureq, status);
> > > > +	usbhs_unlock(priv, flags);
> > > > +}
> > > > +
> > > >  static void usbhsg_queue_done(struct usbhs_priv *priv, struct usbh=
s_pkt *pkt)
> > > >  {
> > > >  	struct usbhs_pipe *pipe =3D pkt->pipe;
> > > >
> > > >
> > > > then, for cases where lock is already held you call __usbhsg_queue_=
pop()
> > > > and for all other cases, call usbhsg_queue_pop().
> > >
> > > Thank you for the suggestion. However, we cannot use this
> > > usbhsg_queue_pop() because a gadget driver might call usb_ep_queue()
> > > in the "complete" function and this driver calls usbhs_lock() in the
> > > usb_ep_queue().
> >=20
> > right, in that case just call __usbhs_queue_pop() directly.
>=20
> Yes. So, my understanding is that this driver always calls __usbhs_queue_=
pop()
> because this driver cannot know that a gadget driver calls usb_ep_queue()=
 or not
> in the "complete" function.

but you don't need to know that. All you have to do is spin_unlock()
before calling usb_gadget_giveback_request(), look at
drivers/usb/dwc3/gadget.c::dwc3_gadget_giveback()

> > > Perhaps my explanation was bad, but this issue was caused by the
> > > following conditions:
> > >  - I use the renesas_usbhs driver as udc.
> > >  - I use an old usb-dmac driver that the callback runs on a kthread.
> > >  - I use the ncm driver. In this environment, the ncm driver might
> > >	cause a spinlock suspected.
> > >
> > > As an old solution, I fixed the renesas_usbhs driver by this patch.
> > > However, if I use a new usb-dmac driver that the callback runs on a
> > > tasklet, I don't need this patch. (This is a new solution.)
> >=20
> > then differentiate based on some revision register or something like
> > that ?
>=20
> Sorry for the lack information. I am submitting this usb-dmac driver that
> the callback runs on a tasklet now. This means that the driver is not
> merged yet. So, I think that we don't need to differentiate.

But as soon as your driver gets merged, you will need to differentiate,
right ?

--=20
balbi

--E7i4zwmWs5DOuDSH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAwXIAAoJEIaOsuA1yqREgjsP/3qq22ML83n70CGAP/LX2bj3
30KkuxpNSdnsBRr7jyQUitAJZDAe2irYXpPeadDOFgND7B/J2NaaObd7YyF2MJV9
gHeK/yMRpgo+8FlVumrO+774/DqAqwmvhnl99njFmU3k1Z7Ywjawo55ragP6BzeA
/Bn/zf5OsruelybMzPEDRrbA6p3ikv26iDJz+KQ0ekf6T/Rl7BIFjUjsnb2M26cJ
BFUdhKZmiBlzVhtbKSCuWZTPU4BM8McCP1BeyOLgDDUPynwu4aiHGRI3OfpLWcbe
Euvp9wpe5cTer39U1aGUYkV6dW2xiAfD4kVjmwDBf/BzFQrqv7NrfNVZ9YUGVNHp
JqTR9GYyuFb8CPSAf/G2R2uD4ZfZGgeFeG2jHWvt9spxI6cvH0JfxnBLJXzxAxbY
/GeyIPVN09xUxutddy/USxdBgB6hctZFlRgDRsVb5sR9xH0jN77UkdLIhxotaxyW
6D1pA5TfhGBpCHsUIFFflRu6tkxJMmkTWn/8uOLYrgDi3UH2nrESIDgT06plGlpP
+Yh9zeTEPkCtLBBkIM13xlqCrXij0mOqTxL+CsUr5MaYtaTjfHmEXLbndaTvtHIx
G87Vnot3ZkSrv09McOMz/cycm8OaGTQdM243pN3nCJSLK1Jcz4p6M9Lyhe1sAdii
SnqPPFuaLbuOWXfmK3UA
=8+A6
-----END PGP SIGNATURE-----

--E7i4zwmWs5DOuDSH--
