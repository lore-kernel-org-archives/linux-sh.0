From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 01 Jul 2015 10:08:03 +0000
Subject: Re: [RFC 3/3] ARM: shmobile: r8a7790: rework dts to use i2c demuxer
Message-Id: <20150701100803.GB1926@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7iMSBzlTiPOCCT2k"
List-Id: <linux-sh.vger.kernel.org>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
 <1435700651-3543-4-git-send-email-wsa@the-dreams.de>
 <CAMuHMdXTnY_gg+VWcSxUZWnD6yrL9xxCSoJYQVCh4Dj7Lxr8Qg@mail.gmail.com>
In-Reply-To: <CAMuHMdXTnY_gg+VWcSxUZWnD6yrL9xxCSoJYQVCh4Dj7Lxr8Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2015 at 09:10:23AM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 30, 2015 at 11:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > --- a/arch/arm/boot/dts/r8a7790-lager.dts
> > +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> > @@ -49,6 +49,8 @@
> >         aliases {
> >                 serial0 =3D &scifa0;
> >                 serial1 =3D &scifa1;
> > +               i2c8 =3D &i2chdmi;
> > +               i2c9 =3D &gpioi2c;
>=20
> "i2c<suffix>" or "<prefix>i2c"?

i2c<suffix> describes the bus here. <prefix>i2c another master. Could be
made more obvious, probably.


--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVk7wDAAoJEBQN5MwUoCm2rRQP/1paHnQcfriGVGKjmlk11v+H
RXpWNGV2VYGIEb9QDtmniTqQrGR5Z0ZrItrXJo5Xnd6wY92kYQ30DQtCvYUnSVy+
5TJ1ibS7zsV98cR4Qrnsuf9NzY9YsJPTFteJcJfiMuqvU59uRkX8qelszYk0NA+z
520Bos8PdEoaLNi2Zxf6SKtCA3AAUlJewDyxm0QjqhYHQwuF+svZJyX94ygMGfLt
S/2tQJ6jLiwwVhGlPKG+rK9BiorMcHlgwNGrVOR6sGCmYKvzP2AVgqW2BoUG17zy
b3cMSeNliqxgA1jPZlWWGfEvD4czDoEa8irl6wLgZ/jW5unghxUUFKlyw7/c54A9
80huHVtZzzZ1pnC3Ivr57dWBV/tnnwEDEisto0+Yz3qZL7ijSTkRG8WMeUvF9V4t
JztUJsCJJCFrzVnEi9zhOokF9gI21yLk3Omu4d2K9Yq6246PlO0grYOgYjSePxA0
hDLikoOCcCoFgQr6VMW/sQdXEHFuIXoKe8TE6BIuL1/N0LGhZ0I2ew07jAU9bhYR
qLn46vCTT9wkrv7VBpVzCBUjpBe9eaogX63yLIZF7qnnpG6I0hCzlgWlePYpsDop
T5m6GJkZArhxYZVKdUGPEyuVvGbNVGmYG3pql6Ygn1EhD5j43Sb80UXI9vt2nx5w
LVCS6gAKbmj20IbfR72u
=JXYV
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
