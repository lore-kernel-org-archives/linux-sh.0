From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 11 Dec 2014 21:29:22 +0000
Subject: Re: [PATCH] i2c: sh_mobile: remove unneeded DMA mask
Message-Id: <20141211212921.GB21482@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="FkmkrVfFsRoUs1wW"
List-Id: <linux-sh.vger.kernel.org>
References: <1418217181-25647-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418217181-25647-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 02:13:01PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> We don't need the mask since we obtain the channels via DT.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUigyxAAoJEBQN5MwUoCm2hJMP/iyKeGkoffg4wSTTLvglxkWV
VxywE5HbSSchYaYy4Em1tSPcjQ1JytN5LRM+DHlqon0dyZiIE3I0TSEqldKpFLzv
T5j+wVJCeFrLvV8C4XGMEAm89lVpDb1AiU1OSCMm02m5lJjYmOC1pnXbYUGmee75
C/kfLxbtcLTaUIx1PxdrUcj86LnitRtT26PP19v5w+cKZ5iOwxGr/G1nx2Vv+CsN
Cp1SZ5F3RXVzorLhlQT8VH+pI/tbP9XhvKHgd9Q14p1Br4mLu5TEJ9lUmSVwof9B
sBnIhHfBoIGonmVU+T4FYP3+j2wMhmk1u0Vkbz2WJKOZ5G/T4h76bXJzjYi930Q2
9g4dPs9Dy00G6zNg/CDgvh/dRsDOIoFyU7bvMRjjeJ6Qz9aInWzJDCfFAWII5mEd
IVR4thdOEHxV14s3kRnTVvR0YC9TiQzVCPfMZjeVYpeoKxmqXdhKmnENSOgDuNAY
jCSOT6YDI3bzb7XyTMV1sEPzbfhu5y/4NqFmt3LJYanzksglQ2GOCYx+wIpxbgI0
6kOwsvQ3eGiRMOcsNT7G+Ob6s9Hegd2VYsZZdSS6TfNa/QZGP7ZeuSv5fP7ddYvx
u3a9ZZ8lkqAmrebZ74Q3VMTCxMlFCneZzMvVFYhR9mkUFr5r4BCqZx32vRT4pTdc
RJRM1Fdoyl4xoHWtLJnQ
=NhGZ
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
