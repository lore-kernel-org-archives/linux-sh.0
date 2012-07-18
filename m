From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Wed, 18 Jul 2012 12:03:13 +0000
Subject: Re: [PATCH 1/2] mtd: sh_flctl: Use memcpy() instead of using a loop
Message-Id: <1342612993.7530.20.camel@brekeke>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-xOYfN2y9r7FE/8XlFyY9"
List-Id: <linux-sh.vger.kernel.org>
References: <1341484862-24033-1-git-send-email-hechtb@gmail.com>
In-Reply-To: <1341484862-24033-1-git-send-email-hechtb@gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Bastian Hecht <hechtb@gmail.com>, linux-mtd@lists.infradead.org, Linux-SH <linux-sh@vger.kernel.org>


--=-xOYfN2y9r7FE/8XlFyY9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-07-05 at 12:41 +0200, Bastian Hecht wrote:
> Elemets have been copied "manually" in a loop. Better use memcpy().
>=20
> Signed-off-by: Bastian Hecht <hechtb@gmail.com>

Pushed both to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-xOYfN2y9r7FE/8XlFyY9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQBqYBAAoJECmIfjd9wqK0EqsP/20j4NoflJFW9AP2Ox/4G2dP
YFO+xufLOAkN8MdgfIz4s0Jztd9kf866vcO9Dj/IdlmDgFN3YIx8Pf0zCfjL2JJu
nufw+AVsrE1uqEYWOwqehCV2yXu37wVPnD2mCCXn7FnZDAfckTrTOdF7FAGHpuJ0
keDAQBBAmMheqBjK0GgQJk4xnVRQjLPvihJ1q/Adq0jRDi9O7XOoXYN9cS/yEqrJ
aXQ8ZOrIOVFGNrasI8GaEGrW8idVTO5Nc9m6FIgfjpMadz29xeAaBCDSzH0h6wL+
iKHWqf7loR9Sj7O6Ya9pBJBj1z3ZVPth8BjV970Bqz4xkRYq36Jq3ObByoD7A0V6
mkJ7JiibXOA+fKCyYwWVDlPQHgNdmiIn0HIvu7znjMN5OpXxEZhOU7wJtn+MZGoR
OgUmYcxGZfn2ddC+/nair0DF4KNvxutiyU896qYHH+vu2XV3SP6kAyo9lWiBNvhs
TsYeHjfR/ZcRG4+QrEA8U89DDM+MVYCdOneQL2M6VhOcIYbv64l4pyFsZoEEUCGz
jlZnmF8Oehw+5l6BVmG6OS+3ddQqhwXcn+zzJ2zLwXC1ZFXrznEAx8vrw1HJVoI9
2OO0Sq/92/r9A4gz9bMvxw4ZzznNW78OEHltk/h4sO8Eu7zgo0pHL6Bb5s49RKlY
b5UlDKh4YpGUvzQvq+8P
=ZvZ4
-----END PGP SIGNATURE-----

--=-xOYfN2y9r7FE/8XlFyY9--

