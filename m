From: Felipe Balbi <balbi@TI.COM>
Date: Thu, 12 Mar 2015 04:44:49 +0000
Subject: Re: [PATCH v2 1/4] usb: renesas_usbhs: fix spinlock suspected in a gadget complete function
Message-Id: <20150312044449.GA29718@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
List-Id: <linux-sh.vger.kernel.org>
References: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1424051579-5060-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXOkzznW_4KJwqiO5UgYXYN2tZ+2OEYwA+eQJF2S-Z8jQ@mail.gmail.com>
 <HKNPR06MB3227796F47FE559CEAD573DD82F0@HKNPR06MB322.apcprd06.prod.outlook.com>
 <HKNPR06MB3229E4509ECB25B3620B449D8060@HKNPR06MB322.apcprd06.prod.outlook.com>
In-Reply-To: <HKNPR06MB3229E4509ECB25B3620B449D8060@HKNPR06MB322.apcprd06.prod.outlook.com>
To: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@TI.COM>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, USB list <linux-usb@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 12, 2015 at 04:33:41AM +0000, yoshihiro shimoda wrote:
> Hi Geert-san again,
>=20
> > Hi Geert-san,
> >=20
> > Thank you for the reply again!
> >=20
> > > Hi Shimoda-san,
> > >
> > > On Mon, Feb 16, 2015 at 2:52 AM, Yoshihiro Shimoda
> > > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > > According to the gadget.h, a "complete" function will always be cal=
led
> > > > with interrupts disabled. However, sometimes usbhsg_queue_pop() fun=
ction
> > > > is called with interrupts enabled. So, this function should calls
> > > > local_irq_save() before this calls the usb_gadget_giveback_request(=
).
> > > > Otherwise, there is possible to cause a spinlock suspected in a gad=
get
> > > > complete function.
> > >
> > > I still feel uneasy about adding the call to local_irq_save(), as the=
 need for
> > > this is usually an indicator of another locking problem.
> >=20
> > I also think that I would like to avoid using local_irq_save().
> > But, I have no idea to resolve this issue for now.
>=20
> After I modified usb-dmac driver to use a tasklet instead of a kthread,
> this issue disappeared.
>=20
> My understanding is the followings:
> - According to the backtrace below, during usbhsf_dma_complete() was runn=
ing,
>  a softirq happened. After ncm_tx_tasklet() was called, the issue happene=
d.
> http://thread.gmane.org/gmane.linux.usb.general/122023/focus=3D43729
>=20
> - This means that usbhsf_dma_complete() ran on a kthread. So, ncm driver =
is able
>   to do the ncm_tx_tasklet().
>=20
> - After the current usb-dmac driver, since usbhsf_dma_complete() runs on =
a tasklet,
>   ncm driver is not able to do the ncm_tx_tasklet during usbhsf_dma_compl=
ete() was running.
>=20
>=20
> So, I would like to recall this patch and I will resubmit this patch seri=
es as v3.

try something like below:

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_u=
sbhs/mod_gadget.c
index e0384af77e56..e9d75d85be59 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -119,7 +119,7 @@ struct usbhsg_recip_handle {
 /*
  *		queue push/pop
  */
-static void usbhsg_queue_pop(struct usbhsg_uep *uep,
+static void __usbhsg_queue_pop(struct usbhsg_uep *uep,
 			     struct usbhsg_request *ureq,
 			     int status)
 {
@@ -133,6 +133,15 @@ static void usbhsg_queue_pop(struct usbhsg_uep *uep,
 	usb_gadget_giveback_request(&uep->ep, &ureq->req);
 }
=20
+static void usbhsg_queue_pop(struct usbhsg_uep *uep,
+			     struct usbhsg_request *ureq,
+			     int status)
+{
+	usbhs_lock(priv, flags);
+	__usbhsg_queue_pop(uep, ureq, status);
+	usbhs_unlock(priv, flags);
+}
+
 static void usbhsg_queue_done(struct usbhs_priv *priv, struct usbhs_pkt *p=
kt)
 {
 	struct usbhs_pipe *pipe =3D pkt->pipe;


then, for cases where lock is already held you call __usbhsg_queue_pop()
and for all other cases, call usbhsg_queue_pop().

--=20
balbi

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVARnBAAoJEIaOsuA1yqREQHQP+wXT1n1oDAUAqGTkhGGdrPQh
y6VcjXvFGmYnRu3RJVxQfo0Z6viD+A3GL+zXnOYYjnC7hNEAvFI3ROfzXQUGz3x5
4B1U7U4e3DTeuobYK9P82ugeW7biJjhgQOCsVFtGRald95CwefXA3footqMRiDm4
t4iTwtG3UlfBQUd0Jy0MchhpEupnrtYv08qXa/YbUmPE/KqJ7gP9FUEs1VT6B4iD
gb0cgQilSItSlakbO9EOVdPt8kD5BWvSZ3R1Qpp3ywuCHyIB5Ipz8Onob+E5Na2Y
FyvcJlk187UWN3SRmLP+l801FV/ABkFLcUtaYgXV/vImsQRI+ODOuzB5F3fQP/jm
WX/2BcXx+kK1WjYQdrsHIAgQgAH0s3XY5X4xoF7xKxJ2NlIPwW8R7QfRwg50ohDZ
2qIWB2V8DCO9xIf//7ZuvNBbAUFjpmaeTm8RfncB5QCxnu4LSOViGbN6haTj/vf3
u9V7FCeyOnSChLCSHwGgPxI+7Pc9DeAk+1w+wkxFucufWywYrTGtIi1ZOKw82t8x
dc+SPcRhS8swvmrsuzSQZY9afCbsmPrEtmHrfKHD98cw5vdPYUVQN/+izJNXB3gN
7K1+psl4WppwmjmTTgFFo8W/Bq64CU0+PzQTeCrbVoLe77+eI4iopk/H0RU0jmT6
wMS5z8hRX3HIxJHyxZ72
=YU68
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
