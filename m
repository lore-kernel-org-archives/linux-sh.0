From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 16 Apr 2009 00:41:55 +0000
Subject: Re: [PATCH 3/6] Add USB support for SH7724
Message-Id: <uvdp5v38s.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your comment

> > +/* USB0 */
> > +static struct resource usb0_host_resources[] =3D {
> > + =A0 =A0 =A0 [0] =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "r8a66597_hcd",
>=20
> Please use "USB0" as name for the hardware block.

I will fix it.
Thank you.

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0xa4d80000,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0xa4d800ff,
>=20
> Is D1FIFO included in this area? Shouldn't end be ..0123?

wow !!
Sorry it is my miss.
Thank you.

> > =A0static struct platform_device *sh7724_devices[] __initdata =3D {
> > =A0 =A0 =A0 =A0&sci_device,
> > =A0 =A0 =A0 =A0&rtc_device,
> > + =A0 =A0 =A0 &usb0_device,
> > =A0};
>=20
> How about usb1?

Now, we can not support usb1.
Because latest manual (Rev 0.11) doesn't have
explain for usb1 interrupt line number.
sorry, I didn't explain about it.

> > =A0 =A0 =A0 =A0boolean "Enable SuperH on-chip R8A66597 USB"
> > - =A0 =A0 =A0 depends on USB_R8A66597_HCD && (CPU_SUBTYPE_SH7366 || CPU=
_SUBTYPE_SH7723)
> > + =A0 =A0 =A0 depends on USB_R8A66597_HCD && (CPU_SUBTYPE_SH7366 || CPU=
_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7724)
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0 This driver enables support for the on-chip R8A6659=
7 in the
> > =A0 =A0 =A0 =A0 =A0 SH7366 and SH7723 processors.
>=20
> Please update the comment as well.

Thank you I will fix it.

Best regards
--
Kuninori Morimoto
