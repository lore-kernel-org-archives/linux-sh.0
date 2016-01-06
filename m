From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 06 Jan 2016 08:51:18 +0000
Subject: Re: [PATCH v2] ARM: shmobile: gose: add i2c2 bus to device tree
Message-Id: <20160106085118.GF1525@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yH1ZJFh+qWm+VodA"
List-Id: <linux-sh.vger.kernel.org>
References: <1451945780-17558-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1451945780-17558-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org


--yH1ZJFh+qWm+VodA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 05, 2016 at 09:16:20AM +1100, Simon Horman wrote:
> Activate i2c2 bus in r8a7793/gose device tree.
>=20
> Based on similar work for the r8a7791/koelsch by Wolfram Sang.
>=20
> Cc: Wolfram Sang <wsa@sang-engineering.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> * Update eprom compat strings to "renesas,r1ex24002", "atmel,24c02".
>   The former needs to be documented once the desired mechanism
>   for documenting eprom compat strings has been confirmed
>   with the maintainer.

I'll take care of this now.


--yH1ZJFh+qWm+VodA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWjNWGAAoJEBQN5MwUoCm2zzMP/2mSneQbWu8k4tNxwfiI40w1
vRyPQQKIIdn/0JzsOIuBMP4ybjWCG4h+2YzudiuBNkg1VYK7g/vWo22FqAgUy5g7
zqWJszgGhiZ2Gqf+KrTd+qdDdxFLXsttqqxyEzaWXyvvBUXwIHEbnBCpE0WAd4wm
D49KCB5BwqhInPXiPaRNjIvVv4IvEXyIg6NwdG1FH55WLgjXRq8ki0VvcxS4t+0g
erPJw8WmBMzLg0NDWTdNl5OHEGl/mI1QpstbmGhz6MTIJ1JkGX2TbuBc4QlO6ouU
kFiV+K7myhF5puBq2PUzCgqsPVNV+kW/C64F694WYciRIpxQmMGJqbkAk+iRXKlc
UH1g5JykFt1PWpzYYsnLfiKpFl1/oJd3S7ne1bAt9DrRemy3wfU4xXhtYVdAhzHl
uSc4/oPRQzb77PY8BARE4Qn9h8u0+EN5aglQ5SAZT8BBCAlBSBXWkO/HOeO1+CPm
VdWlCTUOx08uaYt/BscG1u+pITER5jbZUPMh3H0XbfRCE2YFY8t5Ofzm97/nVKqH
rIKdyVLzBFg+Jh7EM+xOZm2cO47eq+ecw7/HK7hihPHGLHaG4Uerg5jhnqGNq0Yv
DOF8AZenFeReqXFl7qH9i60BKIYK+1NWYhwuuiA905kzAHkATx5Aq9ssyF5j2E4K
8QPb1kYqwRTrtarswgDq
=8cSH
-----END PGP SIGNATURE-----

--yH1ZJFh+qWm+VodA--
