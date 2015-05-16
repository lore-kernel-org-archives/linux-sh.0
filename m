From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 16 May 2015 08:22:16 +0000
Subject: Re: [PATCH 1/4] i2c: add FUNC flag for slave capabilities
Message-Id: <20150516082216.GA4014@schokonusskuchen.bad>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
List-Id: <linux-sh.vger.kernel.org>
References: <1431607205-2316-1-git-send-email-wsa@the-dreams.de>
 <1431607205-2316-2-git-send-email-wsa@the-dreams.de>
 <20150515113744.GS28888@pengutronix.de>
In-Reply-To: <20150515113744.GS28888@pengutronix.de>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2015 at 01:37:44PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello Wolfram,
>=20
> On Thu, May 14, 2015 at 02:40:02PM +0200, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >=20
> > So users can check in advance if there is slave support.
> I wonder if the core should check if .{,un}reg_slave is !=3D NULL and
> automatically set this bit accordingly.

I thought about this, too, but decided against it. Maybe some driver
doesn't want to make its slave interface public because it is
specialized for one use-case only (thinking ECs here)? Also, doing it
would be a little inconsistent, since we could do the same for
I2C_FUNC_I2C when master_xfer is populated. So, let's start simple I'd
say.


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJVVv43AAoJEBQN5MwUoCm2lf8P/1YI/+jkv5at5EShGaBxOomC
St8FNTCoLOFrsb2RNYERxdY9K9agF5AKSkU3CMImBbsmpjE4ukOIhmWLH/d42cSb
ccHvS43X1gLO9p54Zwltj+NJLJHOFBLS0dMdQ7FKCQvoSz/DQEeJq3wX4E/AnXHo
qqA5lfc9qDSpEB8k7jlucjIep5gCB6dPkLtBWWfMD5WZbDtfiONy2Nl/8YG8IPQ/
PrH0w090NrJOD4HP8Mrs7HhwY436M7l2MzZlEA5WgR6a6SOfe0t1mH2fnxW1cH4m
XwjN+t3D1YL06pes4f3XLFzggX5qn+EhscTB7Tacy2JDBbX/mkF3wqQOmAbeNywv
9SpGwWSre3nbdbgL+52U2AppKmI20wt+hcFjAphBHZe0ZKtmN2UP/67YSvBW3Ieu
jDOpBQfSkMSuZm2dZHbcsU1ND/2d9K0dyw6ZEgOsuEJSPnoeDL1oc64cgtQsud5C
cvlcWrjchKeZzcNuBR1EbhUsykMkO+vlSNCM23kQO2xNSn/pveHBrzDd/v1vSM6R
um11PEC1Z30Dpto2/LbKfn99ii20FaBymlCHk4HzvGLl8XxtBQxZbpabqakcEkt8
9wsTB3i7bL70cZ+G88Db9x2m9RAIZ5m+du1EsAnTABiBVG0Nc0oUWUa3n8R9dotz
CD5AbmfmDQibV0Au+UVO
=8yz/
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
