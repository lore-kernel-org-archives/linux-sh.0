From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 12 Aug 2014 21:47:30 +0000
Subject: Re: ARM: shmobile: "i2c<m>" vs. "iic<n>" DT nodes and pinmux
Message-Id: <20140812214723.GA3443@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com>
In-Reply-To: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Tue, Aug 12, 2014 at 03:11:18PM +0200, Geert Uytterhoeven wrote:
> Hi,
>=20
> On r8a7790, DT device nodes and C/DT pinmux data for IIC<n> are called
> "iic<n>", with DT aliases from "i2c<m>" to the "iic<n>" DT nodes.
> On r8a7791, DT device nodes and C/DT pinmux data for IIC<n> are called
> "i2c<m>", with DT aliases from "i2c<m>" to the "i2c<m>" DT nodes.
>=20
> In light of the proliferation of other members of the R-Car Gen 2 familie=
s, is
> there a plan to make this consistent?

The 'i2c'-prefix describes the IP core handled by the rcar driver. This
core is named i2c in the datasheets.

The 'iic'-prefix describes the IP core handled by the sh-mobile-driver.
This core is named iic(b) in the datasheets.


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT6otrAAoJEBQN5MwUoCm2y2EP/Aw3qzoOgpITADFCwQSXTgMK
qG/fPHaNhkqoXamGXLBUnYySvZUwbYLtbh7uCpgEp2kBBKyMaQ8oX/+jjd6RgcZ9
8KBv4gMqFwlwHkueh6AYQfH/jn4TvW4mJ9AvMkT3Z/BNH2lg5anKK41AOHCGZ6zt
PsSk/C5i/IwrD5FDdH/Nq3LxmkzCTE7s15tpeA4h8CupPAeFyUFDcrJp4GFzSIns
PlHCGHyAquem2pmjJNC/A8s8nO7XRsmQNo1a6W6e8rFFEOYa1mxHxAP5sfNyD6kx
SClSJMbowqpCR1Kp7lqUVuWMqrbd++s+e9+GzmZhuogcowlmlKSUE7vMQfk3ubeo
a/iLkJBMsiQH247srzEpZINUS46Q1sOsfRVlPO/AtobExUsx0zZrXYcp1c3tcsQO
C50T2AVRM2W09q6Ed4QJvq6vt3QYa0UWmyeW3/juPp/MFAcuKQVcPnDEHR4q1fI1
P3FF8kFHM0Cvr61TXhTcBjctWu+KRj9b7Eb4e4yL7VCAD2BvkP3LH5Vo3oBwZWUO
PdXo5RIFwNOWw9EYuhdTzCNoXtslc+y230ZZj3JQApxIeSI5YwFz7vcqlIAyHBmR
PzrWJ/NB8Tt16///Uzfehv8PDE3HhJ2JaGLiAww0Ph8FRCHVuI1J40FgcAEEzAyd
BX8Z6ki19YZtAdQPrfwd
=z0OX
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
