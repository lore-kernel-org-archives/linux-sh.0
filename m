From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 04 Jul 2017 14:04:42 +0000
Subject: Re: [PATCH 3/6] i2c: pca-platform: propagate error from i2c_pca_add_numbered_bus
Message-Id: <20170704140442.vzksexlldzet2clt@ninjato>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2wpn74yjgxteyive"
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
 <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170630005408.23968-4-chris.packham@alliedtelesis.co.nz>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--2wpn74yjgxteyive
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 12:54:05PM +1200, Chris Packham wrote:
> Rather than returning -ENODEV if i2c_pca_add_numbered_bus() fails,
> propagate the error to aid debugging.
>=20
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Easy one and nice to have. Will be in this merge window.

Applied to for-next, thanks!


--2wpn74yjgxteyive
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAllboHoACgkQFA3kzBSg
KbY0sA/+JzoEYP4GkhS/blCYDnxdEiMGnzYZMqC+9JDbocq+O4xAr5S0UY+ySvRf
5FtroXyMQ/EKd2PIc5SazWqZO+mVUYqRt2qIEhzw57+fQy6VehjUnSP+jdg6YgEy
uqSgFh3bglpKOHYf5OTm8oiwWo9ZubZNgnfFdhn5OMrMPdBGA7spnUhG+bwKjha2
6lVq8PLzmzuQImck6bZcxBtqadbjBp//U7lIGkLQU3+GJxaRGFps3qdNxsOHqYGm
n3hsQCnhMH7/ESy87vgbrchnrsgSjW6qDb1/ATVC6hk+qsFt0JQM/DlHNg1PrTQ+
N0VNcqWELmt7zjLkm6v3Hz8q9q+0l7d+J+zt2NYYC7vNXrG2fNGA4bqcqwz3wrbm
HeDjqzyICz7aF2oe/3QsUZOFx44zEyKrA88ecfFxbywPWTKl07ihuJ/IgwLepEby
rtnp2GkC+lK5dfBbgUw8WTI2IHsNsX8bMbO4wJmDXQ5zOw8kNu6z8p84s7XKuQgD
85aCHV2oqc/0BDCDjqDPx5PK1axhpUrg2Ge0K+loq3ww2oBB5KJB/YoUSu/YVTp3
MGaT/Btc93aKKACtK9Zwa5GCn+ejpCUw0SpAlGM/xCToFGKtWXy0ycvzfdtfcZYl
bpQfx1Qa9eCnIr0KOwRYWImrRqeMoTgVrL6pvpmSM+2mfPxord4=
=KFH+
-----END PGP SIGNATURE-----

--2wpn74yjgxteyive--
