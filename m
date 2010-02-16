From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 16 Feb 2010 04:40:03 +0000
Subject: Re: [PATCH] ARM: ap4evb: Add SMSC 9220 network support
Message-Id: <uwryd94kc.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <ueiklq518.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <ueiklq518.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for checking patch

> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* enable SMSC911X
> > + =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0* FIXME
> > + =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0* AP4 doesn't have pinmux support now.
> > + =A0 =A0 =A0 =A0* So, set the value directly here
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 __raw_writeb(0x01, PORT65CR); /* enable CS5A */
> > + =A0 =A0 =A0 __raw_writeb(0x00, PORT39CR); /* enable IRQ6 */
> > + =A0 =A0 =A0 enable_irq(6);
> > +
> > =A0 =A0 =A0 =A0platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_d=
evices));
> > =A0}
>=20
> Why enable_irq(6)?

Oops...
I should find good excuse...

I will send v2 patch.

Best regards
--
Kuninori Morimoto
