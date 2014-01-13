From: Mark Brown <broonie@kernel.org>
Date: Mon, 13 Jan 2014 11:59:47 +0000
Subject: Re: [PATCH 1/9] spi: rspi: Add missing clk_disable() calls in error and cleanup paths
Message-Id: <20140113115947.GL29039@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WI+ghjzd0JGVd6h/"
List-Id: <linux-sh.vger.kernel.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389525222-3482-2-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org


--WI+ghjzd0JGVd6h/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2014 at 12:13:34PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This doesn't seem to apply to current code, please check and resend.
The fact that there's multiple patch serieses in flight from you for
this driver plus development work (again mostly from you) in git is
probably not helping here...

--WI+ghjzd0JGVd6h/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS09UwAAoJELSic+t+oim95cIP/1K+jA6FYXdZCJgnziEalRdi
UcIgRvWSwHtDNQNRqZ29jlYtC+aVhh3S3U1DW0pAZD3K+0m4UrvuMLJPJfsAO+GO
4kX9KOVCsLym0jwBJWXjRtr2zBywIvRw4DiVuBM7Q4M1K6JPVoqg0vz5o/HyLKwj
kxGsDUX2HGUt0uSlA8GEBgiUmbTXbmM1jniyxfOUjL2R7Sv3y2dPQ4351FMbfI2p
k4C5/JQ4gCY2Jj4vRdXY0c0sSbC6BtEGEh51mV91w7/1kw06le8jXIWkW8Czgrmw
FPSDA4c4KrJ6kz1JvtKgg1QWNCUMuhFlyarBXeFWObSFrjS1832rDGqIle5Nh1Ai
pZvfx+UngBW4G/PHU01smGG2/kJbHzgYoiPdTNNBcD/0VwdjXvoFpcpGYNl6plBw
4OokFS9JWFEFLkUCXS82Qz9B2sFpS5EYd9Uwb0lylJT3Je4jQArlmga8sscEPvPn
vkmVOJFgHtcJxWZwjElsIpfRZHZsxSfQFgkZsZ6NUZWqRFjSeuVENM4qAFyntvpy
mde2vA8juhmz4Bgm5nkyduvKGXmbHFho5rgLobQfOnXUCu35AB0fd+JYiM7lcbH0
+NtWqvFUMz5o+PEp3Vucq5fHiEBit6o/Y0qfsI4ALJX0259tf+ZOzOcW07jbCHvv
B2R12pnXn5zivnTwmosm
=kvxK
-----END PGP SIGNATURE-----

--WI+ghjzd0JGVd6h/--
