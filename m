From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 01 Jul 2015 10:07:08 +0000
Subject: Re: [RFC 2/3] i2c: mux: demux-pinctrl: add driver
Message-Id: <20150701100707.GA1926@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
List-Id: <linux-sh.vger.kernel.org>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
 <1435700651-3543-3-git-send-email-wsa@the-dreams.de>
 <CAMuHMdW+rd+U0VQjitbyJ3AiZakhLztdYe27n1rkK9tFWT=z4w@mail.gmail.com>
In-Reply-To: <CAMuHMdW+rd+U0VQjitbyJ3AiZakhLztdYe27n1rkK9tFWT=z4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +Changing I2C controllers:
> > +
> > +The created mux-device will have a file "cur_master" in its sysfs-entr=
y. Write
> > +0 there for the first master listed in the "i2c-parent" property, 1 fo=
r the
> > +second etc. Reading the file will give you a list with the active mast=
er
> > +marked.
>=20
> This paragraph doesn't belong in the DT binding doc, but somewhere
> under Documentation/i2c/

Yes.

> > +struct i2c_demux_pinctrl_priv {
> > +       int cur_chan;
> > +       int num_chan;
>=20
> unsigned int

When comparing variables, I prefer to have them the same signedness.

> > +static struct property status_okay =3D { .name =3D "status", .length =
=3D 3, .value =3D "ok" };
>=20
> "okay" or "ok"?

Both are valid, I took the shorter one.

> > +       struct i2c_demux_pinctrl_priv *priv =3D dev_get_drvdata(dev);
> > +       int count =3D 0, i;
>=20
> unsigned int i

Same as above.

>=20
> > +
> > +       for (i =3D 0; i < priv->num_chan; i++)
> > +               count +=3D sprintf(buf + count, "%c %d - %s\n",
> > +                                i =3D=3D priv->cur_chan ? '*' : ' ', i,
> > +                                priv->chan[i].parent_np->full_name);
> > +       //FIXME: Check count > PAGE_SIZE
>=20
> Can you use seq_printf() for device attributes?

I can't find a reference to that.


> > +static ssize_t cur_master_store(struct device *dev, struct device_attr=
ibute *attr,
> > +                           const char *buf, size_t count)
> > +{
> > +       struct i2c_demux_pinctrl_priv *priv =3D dev_get_drvdata(dev);
> > +       unsigned long val;
>=20
> unsigned int
>=20
> > +       int ret;
> > +
> > +       ret =3D kstrtoul(buf, 0, &val);
>=20
> kstrtouint()

Yes, I agree to the last two.

Thanks for the review,

   Wolfram


--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVk7vLAAoJEBQN5MwUoCm2VXoP/2i+I6LwDxbyw/TFGBVsREp+
0vvLY2wnZERNhbU6BIlB+RDE3Tv1Gk95NLZ8ljDqC50HzsBCxWdj20sqkUS9vy4q
oYZybnenghwBWJTpaeoSqaMCKx/K/re+yTSmZT9npMHYuBDYke60ELUrwuDGbXhi
u6ojQZlZ1ylpLUTDAtOOEqvGPx53jdY1dwx3cPYGxyWMytNDZbYXDiZ4lgLFaS+u
Ydb0gkHVvYcmNZ4accxFfJqBHOYtlbrpjDzlM7QBPFxvia/56v3n+rZQLL4gO0MO
pi7UQNr6wO81CwyX9aNMmQKXz0vPDOQlpHptPGq2kjyHHNwBJ0VX/zaenAN2nK3i
4EebCVugtYww/ZHoo1hPr+YSgDk4rI+MIrFjQb0xiF7QB+yhpPUaxNB+a6/MQ6ip
Xv2owsd3oM3yQz5X+g+Rf65SH0jSeoDmPiOF48IgwlYB8IXJj/KnU8yNlL2sm8xR
WyBQ69CHZOxuPi1w1saN+50Pw8UmVH5ktQPsrqJpbE3EBSQw4iy2nFP0P48bFwGW
HCONULPxegdmvdnoSEHwl17Dir/4f8HFE0bHC57SahRuj4T7wQcXAtjWTL6jHGNV
FGv4yzpfPh/1JQRD4f/BL7/4oOtPzaepUcW0b4fA95Ccadue8lQa7xD7Gu5A68v1
JW+jpjBreIC2pxNf3Q5P
=KGTo
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
