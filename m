From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 13 Jan 2016 12:55:46 +0000
Subject: Re: [RFC v2 3/4] i2c: mux: demux-pinctrl: add driver
Message-Id: <20160113125546.GF1540@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Wb5NtZlyOqqy58h0"
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
 <1452088285-6427-4-git-send-email-wsa@the-dreams.de>
 <CAL_JsqK8bekw0_FhzMmrZftWpFLv=NnJ7J7767KNwESROPgzPA@mail.gmail.com>
In-Reply-To: <CAL_JsqK8bekw0_FhzMmrZftWpFLv=NnJ7J7767KNwESROPgzPA@mail.gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +       mutex_lock(&of_mutex);
> > +       ret =3D of_changeset_apply(&priv->chan[new_chan].chgset);
> > +       mutex_unlock(&of_mutex);
>=20
> Looks like you need this patch[1] rather than exposing of_mutex.

Tasty! Thanks for the pointer, Rob.


--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWlklSAAoJEBQN5MwUoCm23nwP/iacx667fKuau/bXX3bKXsfc
bCZqPLK5MqZ10vwCI34SPz9TtNhmjxlGlfGsF52WcU6UihEK698sRb8wHbDlDiRc
lG1n5F2KEP3SpKuhxfDut0JQRgi6deVy2VMxuMvMT/YODnarmxYIPjqc7btL7HLA
UcTJpIQ/Pl3mB73Z6qbo1p0GMfXXlE+CMGo5o2yPXuQKhpXHZ0D+FMWeI7rxpDks
aKOIR5pn56WcHzP6J0cc43Gfbx/S3PY7fMJ3FedcMIesZyHR4PNi5nmwGzupeT6X
N0gzq9iA3c0qoilDoioPfGLBPvNTmo/VMEmD8tsV5FMvETSbSO9950iYr4CqpUAo
7aDkc5KdpRXIHa4hFNsty9gDVSwyk0beESZ5jIrshh/jyr+ZsMMMRKU0IikT7rS1
+cGsd3VcpV1wVI05n5FIzFnDT0uvQMabvcp7xOTZGgovD+bjqTEqyuEHpOs/3tJ6
s/xFL/XgRy2GVq8uRn1rKsa6SNXwv3tdEoQAwi4XKIhA6HMD09eZABPwd/mEuUKY
xhRBiTCwgeqAoaSGVAlS6/PbRxS76LokNLaVtaZgxtYW7Ty6xqeeOldGH/LvnZzp
PizrdE8hCLR/O7wY1Vsp1RJNkBwq/KYij/RtsR5yZvDy1quLf8Rr+NPBz8F2Wpdv
fYXePb+P87EYpWCY7wft
=K1o+
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
