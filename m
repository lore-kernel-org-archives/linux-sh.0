From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 27 Aug 2015 11:57:55 +0000
Subject: Re: [PATCH/RFC 10/10] Local: Hack: arm64: dts: r8a7795: add ravb phy max-speed 100 for Salvator-X bo
Message-Id: <20150827115755.GB4326@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Bn2rw/3z4jIqBvZU"
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
To: linux-sh@vger.kernel.org


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2015 at 06:24:10PM +0900, Simon Horman wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>=20
> This is a work-around for limitations in the driver implementation.

I know this is marked "local: hack:", still: If this is a driver
limitation, shouldn't it rather be in the dtsi then?


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV3vtCAAoJEBQN5MwUoCm2sDAP/3us9iJE9UmJzMfy5NrFxecq
ZtMZY3AEYdIDMg5KPgLQ5jJRZmAg/CKa08uESF8DBeVVWpZO2UqwJoSsnV002ML5
vgtfapAVS8wrtIix+y/TuDR9juDYZBdNSeSWpTQ2n1BQi6FrooRtchr/u5AKf3eh
+92kozn9WuQFLurFfajtPnwt90id1HSe8LLPYtgu0KVyGWuUCqlhU0ZBJQqkfCSA
WM6lb/bv5PIGImN8BWAYdMz1cI+YFu3v0iwar/MwSuvvsyu6+uPZXUnCbE1ee5Ny
PnoYWbpbRoQ6L5YAYN6o2gZFQ07uwylkj0sKL3a63V2sQc6ySDL3FHZ+FGXX5F/o
NJlVeMGLOXL2kcelm+H1iP7MwLa9y5a3nwYI8e9LyrOdxm/Mt2FPRwt0jpycM8l9
gJ7t0VBEnLtN4f8QSLhZmGq5F5BcomitrUCFxsEla8VSo4zFK2zFdlWUmLGjcDfs
WMz0i5XTTgNj82xf1/r4Em/0OBQmC1MZlfuna/SIGqSbGzOWmVqB1gJ5ACzAp7WB
9pkDl6qEFghZrIV5CiWgX3Fw4Thxh5qGxd8Il8XyK9Jk0ypQtEc4AtfoFG3m9pTk
V0m4pShnxUQNA/zrm4yr2bcmGNFswIMDpr7vLFZkDNsTEG7ymcwjvOrbnHfkICEb
qpqsPamcwCffI4HczGO3
=d0LH
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
