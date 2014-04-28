From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 28 Apr 2014 13:26:41 +0000
Subject: Re: [PATCH] clk: shmobile: clk-mstp: change to using clock-indices
Message-Id: <20140428132641.GA9590@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
List-Id: <linux-sh.vger.kernel.org>
References: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397577994-12061-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2014 at 05:06:34PM +0100, Ben Dooks wrote:
> With the addition of clock-indices, we need to change the renesas
> clock implementation to use these instead of the local definition
> of "renesas,clock-indices".
>=20
> Since this will break booting with older device trees, we add a
> simple auto-detection of which properties are present.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  .../devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt        | 2 +-
>  drivers/clk/shmobile/clk-mstp.c                                  | 9 +++=
++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clo=
cks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.t=
xt
> index 5992dce..02a25d9 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt

What about mentioning the old binding as deprecated in this file...

> =20
> +	if (of_find_property(np, "clock-indices", &i))
> +		idxname =3D "clock-indices";
> +	else
> +		idxname =3D "renesas,clock-indices";

=2E..and here in the code? It might also be a tad more intuitive to check
for the depracted binding, and if not found, use the new one as default,
i.e. switch the logic of the if block. Very minor nit, though.

But in general,

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>



--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTXlcRAAoJEBQN5MwUoCm2q4gQAJGqcTuzQtoUra982liBCFE+
xHQk3lHiF7KGPLOPOkGQjZAutFNtFug+E4vetf7YrxwxJuNa8PYowv5r4r2Y2q9c
F84MTUeILnRx7Ppu2tUGx0fBu6lmVvfIFlpausoIi8ZkzCuPFw8gXocBpO0kmLG+
HyevQJxCC90ihepUPA4zjvsVMAJxfGUuVicMz25ZEOl4bQniLY2SgdhOEPmHxahL
AG79dBOpJxvwTMmOfuQ/UoBBdS7ve2eL5nFVX5ZpTd2ySanLDo8SDJD5EpUfjoj8
xK8d3x0se/hsCJ6FBariCiX0srazbee8gudHKNpSougb9q9FokVHThDLrHNniLWF
bweD/CpgeiQtA3XSB3ayAsoF4y+yJ16bhFPKD59lRU/MZX9rWpJ0koX1FPy1zaoz
5OMXTKod714gOay2Xr58EqgL/kzcvVUGy9QxnX6E+3IuBKcTnpsDTBeVXbVdypBu
IzeaN4Luj9G3YPwdDgVlpYXur2xKvhRGGsrQY3EVdOeA2K3P+QNzIcUrlGHJRrFc
3x2npugKkASre9/UgFFHV8nWEHrESRRkt/oi2sjyhcpoXaZ/4tML5EnNexjvlIYG
Zp4jnq94QHXkFZEsNRL7nCIbv2o6V7zGfPcUVOnzcoIDILmmHbEAtwFO4iAy5xz4
J7p73p0rf30rchMYD3W3
=3NY7
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
