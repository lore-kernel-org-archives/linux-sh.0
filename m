From: Mark Brown <broonie@kernel.org>
Date: Fri, 14 Mar 2014 19:34:45 +0000
Subject: Re: [PATCH 2/2] ASoC: rcar: fixup SND_SOC_DAIFMT_CBx_CFx flags
Message-Id: <20140314193445.GG366@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="C6nHA5rIg3zAawEK"
List-Id: <linux-sh.vger.kernel.org>
References: <87txb3rjzw.wl%kuninori.morimoto.gx@gmail.com>
 <87d2hpppk3.wl%kuninori.morimoto.gx@gmail.com>
 <87a9ctpph2.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87a9ctpph2.wl%kuninori.morimoto.gx@gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon <horms@verge.net.au>, Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>


--C6nHA5rIg3zAawEK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2014 at 05:56:43PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> SND_SOC_DAIFMT_CBx_CFx means "codec" side master/slave mode.
> Then, rcar will be master mode if it was SND_SOC_DAIFMT_CBS_CFS.

Applied, thanks.

--C6nHA5rIg3zAawEK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTI1nSAAoJELSic+t+oim9cYEP/iz/SrbiAlumIaYaQ1dpM3Rr
CyRZZvrGEUeIvX11NMp9ik4ex8np6nS3t41mcjl8qONKX+RoyBowkzQbk9IuRSmr
hUlYt6K01Fr87Vy2Csibb1REJPpJ2YAWa/MZStTsiNKYh9fGmuYmmlqdPAfFM6gm
JFNTyjVS7dnVTAdR4+1l/x+D5ICobNyMX/nk0IvP1Ydyiqn+9ogXOk3uqc2gtyDq
oybOoqmgdCMvNQI9UmZs4HVWWxDjmvPOhxmP4iHsiV/D3QlB+b7pC2mV8dWxIXip
kvXZN8NZFyYfYZbfuvABr8PyffCvbxmALGBanMwHcd9+BYk1MFktjmHKZYOpWE8d
xI3qF2rDcBOsamEWTpY0bR7p4nXQfsbZ4nOwXoZL1BNNFXjkvvb8BLwNLKrEsLyr
FrYXzKeLT6w02Er6DExDnEKQplDDrA00OV/pY1ivANSJd9ZZTzGOejgi+cj71c4R
sM1/nUscc2W1LzOOJ55ESA8cx/0we7Vj5lBdh29ZCCDYwA0h0VykLBnXeXVAX70C
U0AjGdZJS7aIPAguvm/MPr9k5E7cXXvwgsilt9u91Gd0UK1paBd8xhUI3dNXPYMx
qBLrBH7BUGpQfPW3GdCqY3WieYPq5lDppfXFBpWn5f8NyXP+XHVxt0MSmdNpBjN5
7ce0DSwzgvYNd8oGjkwy
=Ery8
-----END PGP SIGNATURE-----

--C6nHA5rIg3zAawEK--
