From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 29 Sep 2014 20:44:37 +0000
Subject: Re: [PATCH] i2c: rcar: remove sign-compare flaw
Message-Id: <20140929204437.GA2758@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
List-Id: <linux-sh.vger.kernel.org>
References: <1411207657-23707-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1411207657-23707-1-git-send-email-wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 20, 2014 at 12:07:37PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> gcc rightfully says:
>=20
> drivers/i2c/busses/i2c-rcar.c:198:10: warning: comparison between signed =
and unsigned integer expressions [-Wsign-compare]
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUKcS0AAoJEBQN5MwUoCm2ZMsP/1UN+I9D/sCLrZJOhstLQ0da
Y4xkmdwJGZHCDOIjk6wV61m8CkJFVHUJp0KNH+QTeDT2I5hpdRqUcQz7q+M5JWR0
oxdtbw5aRpUH+Sc/RfJTmO6YVdsg1DQt5ZmofZBzN3C3ymPVpayItrXI9ULVa2N4
zA2nfIsliXoCz4CqUKDWOTw+iIXs85MYOHsKq00fGDMpseqUq0aFgyQ1+Ss5Pd/m
c5abk2oDDtaK0hL7zrpOIta9n9FnHAZH9958uAQ80LjFtoaTGe3dK+vBXK3YH+kU
q4wA8GFZplgViSCgKJ4VPzuEoEcPYjC5yvfN6UUHCxoosvL4X6kIfeESVwuoGszi
HvThT4tiGrGfnV6CNguJh3HmpBPdKevxoAsyDiNRk3OBDRVgOdN+fsPFw6q9CYJp
q3utUZCdiJdDfJtCJ57mY0KRSElenykoAeFtmmy5mFg578/dStG25oSgmFs6qGYZ
HjDbn8OSZd48QcmhyeebvPkeUaS+LZdV2oZsirwnmedZBPOBl2Cot0cFWsmdoI18
yhPgjRwjkYljYYqo31gmUvUMzsNTdIO1NU7GkwPLkSzArSD/fn5gHbPoHi5lvZ0q
k0wAC5Hwd/DvO+Z5ueWoGqb6SmSlPiXPUB1hO1wfM7z+5l3Gj5yUrwRak7yFWOsE
qNQYMIdZXlavO9GuX3Qy
=JvKm
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
