From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 16 Apr 2009 00:00:39 +0000
Subject: Re: [PATCH 4/6] Add I2C support for SH7724
Message-Id: <uws9lv55k.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uy6u31ubd.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uy6u31ubd.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Dear Magnus

Thank you for your comment

> > +/* I2C */
> > +static struct resource iic0_resources[] =3D {
> > + =A0 =A0 =A0 [0] =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "IIC0",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .start =A0=3D 0x04470000,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .end =A0 =A0=3D 0x04470016 - 1,
>=20
> Each SuperH Mobile I2C register is accessed using 8-bit read/write
> operation, but all registers are 32-bit aligned. sh7724 does not seem
> to be any exception. Please use ...0017 as end.

I could understand thank you.

> > +static struct platform_device iic0_device =3D {
> > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "i2c-sh_mobile",
> > + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 0, /* "i2c0" clock */
> > + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(iic0_resources),
> > + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D iic0_resources,
> > +};
> > +
> > +static struct platform_device iic1_device =3D {
> > + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "i2c-sh_mobile",
> > + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D 1, /* "i2c1" clock */
> > + =A0 =A0 =A0 .num_resources =A0=3D ARRAY_SIZE(iic1_resources),
> > + =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D iic1_resources,
> > +};
>=20
> Why do you keep these structures together? Please put iic0_device
> after iic0_resources.

sorry. I will fix it.
Thank you

Best regards
--
Kuninori Morimoto
=20
