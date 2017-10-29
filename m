From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 29 Oct 2017 17:29:18 +0000
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Message-Id: <20171029172918.2xtz2srh2meq45io@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="someicsnm7yinxah"
List-Id: <linux-sh.vger.kernel.org>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: ysato@users.sourceforge.jp, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--someicsnm7yinxah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 10:13:54PM +1200, Chris Packham wrote:
> This series addresses some of the points identified by Andy. The series is
> based on top of i2c/for-next. 2 of the patches from v1 have already been
> applied so I've dropped them from this version.
>=20
> I have compile tested patch 1/1 but I don't have access to sh hardware
> to actually test the changes on.
>=20
> Chris Packham (4):
>   sh: sh7785lcr: add GPIO lookup table for i2c controller reset
>   i2c: pca-platform: unconditionally use devm_gpiod_get_optional
>   i2c: pca-platform: use device_property_read_u32
>   i2c: pca-platform: drop gpio from platform data
>=20
>  arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
>  arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-
>  drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++----------------=
------
>  include/linux/i2c-pca-platform.h          |  3 ---
>  4 files changed, 20 insertions(+), 29 deletions(-)

Series looks good to me, too. I'd need ACKs from the SH maintainers,
though. Technically, from Blackfin maintainers as well. But I haven't
heard from them in months, so I could go without that.


--someicsnm7yinxah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAln2D+oACgkQFA3kzBSg
KbbVNA/9FeZ+qC/dFF3NXE9GKxWrKm9kACxpfLTWFCCbmVl5wZIgBOqluP5dpozI
Kl8FCX441SLXCZfm/onCbYFPu6YDuGC+envxRgQ/b51Z0wWFur31o/1EVf6bRHm0
h/Ot4FIPZBV0gzu6O567fqxnkYdc9nn1rOaE5J3/YewnbxAMJ+XzsLhGR5mZqBgU
GOva4g4LkqYv2PYN6/RRTcL1haw1ZJ+5b/LpbkfLOoX8B8MOm3eoj9TBS7KCIlFq
fpxYVGJX1QajunTXVzrDRHyMXbhpfvJucuRkxedoeQPykxKCXajNJuF0WtS00o58
lrsAfr09hSB2vJdgkRcCGHNzH12DaduVDkztyNC/5HALUhY2sInM/Hp7ZFtBrmR/
Wu8PMz2M8PStWaHY5Yy3+F9eH3Ay1XHXEsD1chCM6TdhBYEVc9leIGmWmDHbdsBB
0hXTD3r4ArNE/LEWhhbd8N6RP4lKWiFoEiYY19EAA5jDX5L06VJj7mO20pb+j2fz
a7Agsp4Tvv6X+ScFXTELfnHjy8X4NxYsv74e/MfKFQhplxxAleoQWWWwwSVUMkYT
IZkAYiaChGX5T1gLhL5Ew6cfhgHu25GUchKzPIOdh38xf5cgbC26hZ9Clvl5B++g
HzkVU9x5VGZh592+IjjHhSuS5HM/eIVGLnM4mt2QFBcN/ibaG6g=
=Zyt6
-----END PGP SIGNATURE-----

--someicsnm7yinxah--
