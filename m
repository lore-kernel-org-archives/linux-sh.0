From: Felipe Balbi <balbi@ti.com>
Date: Fri, 17 May 2013 14:00:06 +0000
Subject: Re: [PATCH v7 7/9] rcar-phy: add platform data
Message-Id: <20130517140006.GK14133@arwen.pp.htv.fi>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="BFVE2HhgxTpCzM8t"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--BFVE2HhgxTpCzM8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2013 at 03:00:30AM +0400, Sergei Shtylyov wrote:
> Currently the driver hard-codes  USBPCTRL0 register to 0. It is wrong sin=
ce this
> register contains board-specific USB ports configuration and so its value=
 should
> be somehow passed via the platform data.  Add the global header file cont=
aining
> 'struct rcar_phy_platform_data' consisting of the various bit fields desc=
ribing
> USB ports' pin configuration.
>=20
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--BFVE2HhgxTpCzM8t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRljfmAAoJEIaOsuA1yqREs+QP/36NQai1qlTACudPeyBR+T09
eaqAyG9Jd9HHmZNbJMD/CpFMncbc+oiR1p8Hh7EW5KQ7PvL+3gl+hCvKt81W+J8l
lWvMfzzjUJM7sGd7I1aGTe39GkD070t+T9MaNyI41Wq5d4UNnZ0DZFzWGDBOUNLt
tTx1eBxnYBT78+dt0xVYZlt//0ORi/bEKMRpdgw2dhKX1OJou9aoIHpA0CGebfMi
N6sfyZv4McYOqHnLBRpm7RNGYpm4/xv7ZsJXGmqSgegdx9/+wVnVcgXeq4KdLKA4
HdLiW3UjD4JAAuFUCsWWe9R5WyqGIC+X/vn1GOKXAQArqPRUfTmCbPzmZvp70dHQ
HPLjMQl0OIqs3s22uPn8xKqoz5wOiDpMRYwxkXS9a3Mg09BGOFnfmfjKDiD2iH5G
2CLZPyZJLlIwWoJ8H3o7dWzyz8KY5G6TPjE+bajtcfOWQYKP0Q/oACZhlIeOgusD
72EeEapR3Czce2zFjAwzH5+8pdWhPE7+7ydrD62G+CHioIt5MUz9Ja6ZWRgV+1ZX
E2EzXbLwux2oiPuVNGtBK4ieIG9kTGMictzpGFjdxAX4CK42QY0sG+6VuiSSD6UI
pcUjqn5JbdHLz/5EHAusiVNYWDc05LlKd4pdx8mFxG77wOrcdUiAdNQ7l0+Iv0nY
fZzUq/+j/2h1NJ4RYPpI
=qRNB
-----END PGP SIGNATURE-----

--BFVE2HhgxTpCzM8t--
