From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Dec 2015 19:38:29 +0000
Subject: Re: [PATCH] i2c: emev: select I2C slave support
Message-Id: <20151217193829.GA1530@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
List-Id: <linux-sh.vger.kernel.org>
References: <1450354172-5656-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1450354172-5656-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, Wolfram Sang <wsa+renesas@sang-engineering.com>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 17, 2015 at 01:09:32PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Until we have proper support to make I2C slave support fully optional,
> select it to prevent build errors on randconfigs.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWcw81AAoJEBQN5MwUoCm2up8P/1C132hDfifM5Tth6yJjAY5m
MNffILzaAs1SJDE39nQV2gaVFJgsiOSzABkYYqWXfoAQp9GJTk5AKRbu1gdDN6SG
bIZcJPIQCnEg6/nt84sEpshik2x66xbhx1uOwWOnnlAH2RalTNbyXL0thEJY6r7Q
aEjLEVSScFhEABAEu5XhGZfOX0QC25LksMw0I1hX4ewKgLwQEqqtnZRQkqAsdRrx
3c9spAcMBK+ZVC9/pAnv1ME3h1YkDsEtdFT3xGEsthm9AKBIJflI3ytmpamn2iWs
Gl+kL7DtXp5N1EhLHBDbcYG6SfIMwD9YVI+BaI+QbrNrpadLy5sKOftY+vjl6knJ
P91Sk+JaKuv/sb4vaIvWVvgPL83fTjfqdMnA0dcU+2Llfcf81e/6ssCNJyDW/gJ+
s7f/xZ+QyZ8VSp6VpE7HDxXcYHi07c5HWOrIs2cud7ktIGKW7/yVUqf9hJltBAYa
CYW50TFamplzq6qA7Cq3u4y46y0k+3uyuqr9yCoeNhbUHS3bJTxaok16DtmRFQXb
XmorzsmSxgrKGCXaLF/xccIKnXkX75vJt/FvtWeO5Q0RjgxjntAAlZr5oLHCHHiA
L3fId7h1ytmyzGWd4Vh6PjJD7QU9XxaPpoRSGJWTbjEeYQEZ3h65OfU0udQTjSk7
YBk5An6d1S1CUdcx6G2i
=IqC2
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
