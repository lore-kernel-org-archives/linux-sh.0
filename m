From: Mark Brown <broonie@kernel.org>
Date: Tue, 04 Feb 2014 11:14:23 +0000
Subject: Re: [PATCH] spi: rspi: Only enable interrupts when there's a need to wait
Message-Id: <20140204111423.GT22609@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="2cECDj2Pn+L6wlyc"
List-Id: <linux-sh.vger.kernel.org>
References: <1391508384-5013-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1391508384-5013-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>


--2cECDj2Pn+L6wlyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2014 at 11:06:24AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>=20
> rspi_wait_for_interrupt() unconditionally enables interrupts, even when t=
he
> wait condition is already satisfied. This causes a high interrupt load (2
> interrupts/byte for full-duplex Single SPI transfers, 1 interrupt/byte for
> RSPI with TX Only mode, or QSPI in unidirectional Dual or Quad Transfer
> mode).

Applied but I am wondering if the interrupts are really worth it in the
first place especially at higher clock rates - if you can get completion
within a small number of polls it might be more efficient to just do
that rather than take interrupts.

--2cECDj2Pn+L6wlyc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8MuLAAoJELSic+t+oim9NzYP/Rtjuw4sggCybprd5E7snNbp
27aE/AvUTYstJFGXsBf9aW/H8XlpEKUKDiDGXaDP1Q6TCu2Tg/b9nK1+Ffm11qmj
Ak3rKwMqgtC5/2sIPxIJKH10zLyaDFCsDmOkPmVWa3tw92112NhfYWHzI0Klo3gU
qXqe7ACIe4JDj796ww14ld0Lj6WX9BVpLxfLbjGVJFkZ60lrxzBWiwXqo6CQ5qBJ
7Z36tBthUPmdREL6OFwYQ5Vf7a/LlSJdqqLBHN257sFYJ2fltP0vUFfLIYpCVRPz
R8//kppnIWw9dZMqV3O68m1GXWFPIUpX/vDZikZxdPMstOFJc0l8FEWsu9OTDl/5
VDkuhMiKV6AdfJ7OV/6kcL3bUvsfiXskt8YHsQkU3BJ7abob/NtB8iNxbRVUffOk
t4udK9u9UYhlIrfynXYuDiouu9pSq5tFBktUAF64BcQKCq6q+0ANUrhL9tLm632T
t37VuA7c/N9F2xlL399kwAgUvhqmGv9f+YDEsHqTdfq82eMd6gGkHPvSJaAvyqgY
WS8HY/tiPcMRPtXp8/t9fCMKNiVNGLM5peNlo5plWh/t/VN3PZzFUKY4xOUNO+aN
PQgb0m2f1irYBHKW4eZMAvBI/oMDmh/hX2r8oAYUuy8s6b2ExdAlGfUNVf5DW2jV
lf96Jl0RBOMUCHHnigpV
=kk+a
-----END PGP SIGNATURE-----

--2cECDj2Pn+L6wlyc--
