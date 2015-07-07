From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 07 Jul 2015 19:43:13 +0000
Subject: Re: [PATCH 2/5] i2c: emev2: add binding documentation
Message-Id: <20150707194313.GB1572@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="kORqDWCi7qDJ0mEj"
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
 <1436219188-4325-3-git-send-email-wsa@the-dreams.de>
 <2376548.GgBSKQ3Rxq@avalon>
In-Reply-To: <2376548.GgBSKQ3Rxq@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>


--kORqDWCi7qDJ0mEj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > +Device tree configuration for Renesas EMEV2 IIC driver
>=20
> s/driver/controller/

Yes,

> > +- interrupts      : 1 interrupt
>=20
> I'd write this as "specifier for the IIC controller interrupt".

Yes.

>=20
> > +- clocks          : phandle to the IP core SCLK
>=20
> The datasheet mentions PCLK and IIC_SCLK but doesn't provide details. Do =
you=20
> have more information ?

I follow what is done for the other EMEV2 IP cores currently supported.
All cores I checked have PCLK and SCLK but only SCLK is referenced in
the DTS.


--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnCvRAAoJEBQN5MwUoCm2MygP/2OkVQL3U5MqvXWqUJ5f/JHG
+y30HqCwQfbpPa+vbEWKK4T9CYV4l2WWz5OKJDxq4B3VIDSv2Sdk8nFpvRBdusYc
ZQcGLiGRauoF+feC5ToVWanlAWen3JpMRmfT1ah2Ih37WVrWoGiiN06erXhJaG+J
ojzKo+Vt5qLeuHzP5tdzItLpyvU+F4ACVJ0wZi2Py2H8gSC2Mh5/LAd3j+iBeKBZ
d7m0vCH3L7/pTnxuOAgZASYT8cQCGFSb9DGno4IQ3GgSp/UIgpSVHmgtQuPbMAnn
Zsjl5iai9+iIAenxpVzcki5CNWOMQHk2DcZG9EWD3eeTINHhztHvavEP8eIHO2IG
+Py1mKYfyuSUnaU0M1Q0JZeEt79F2n+6PJcXGSr/o5eesUxqHgexeNXJcldB4iyg
mbRSHJbPpyqo1F9lquxOMYwagkKfUNrFmQZzGVxbNrW9E42AJMOALxo90nD3vORQ
9DkmX3dcrb+2cmJhvvsa4ML/fxIvMzlWz9x6PMqF0aXzj7PXRjonjT/GAUMw+680
1tOIWmsAvLf/+ffVOFwnait0kKnHH60YTCv0vSXh9AVSPx+YqgDEcC7VX9pnMO41
uiBka1BUHpMMroH+8j4So3t/MtAwrffZGwTDM8duZH0AZqHIpud7buCqJj+r04SI
Hqe5Qximix5QNA5UOiXZ
=9rdT
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
