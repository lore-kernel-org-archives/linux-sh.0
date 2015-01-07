From: Mark Brown <broonie@kernel.org>
Date: Wed, 07 Jan 2015 17:30:49 +0000
Subject: Re: [PATCH] spi: sh-msiof: Use async pm_runtime_put() in sh_msiof_spi_setup()
Message-Id: <20150107173049.GZ2634@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EAECBqR2X0HbR9Ag"
List-Id: <linux-sh.vger.kernel.org>
References: <1420645045-18804-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420645045-18804-1-git-send-email-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--EAECBqR2X0HbR9Ag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 07, 2015 at 04:37:25PM +0100, Geert Uytterhoeven wrote:
> There's no need to use the synchronous version.
>=20
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Fixes: 015760563ec77bf1 ("spi: sh-msiof: Add runtime PM lock in initializ=
ing")
> ---
> Please note that 015760563ec77bf1 is marked for stable.

Sure, but this is just an optimisation really.  Anyway, applied.

--EAECBqR2X0HbR9Ag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrW1JAAoJECTWi3JdVIfQzR8IAIVOuPgFmdD0C+2xKrd2u2CS
EZVtK41XVKtnDh94TXRc9txAt1b3avpiimtkZhRUBXM1WVOSuNsjD3maCdVPSOrH
DhREiOczbnN3ylmhSnDhvisjWXpwiscqma9Fi2M6Hb9v5Lzb5aUkchkzdYgZjQei
hqeO9KKxCcBfBCEmcJJ7oRQAYCTmGOtR9xmfFZAhYjmQiBuQezioHV56uTQHb1R9
rPDI+ogbC9tTwDrbZSLS+HtLXbaa2LG9MpNWcxKuT00mpoczMFwmwxCd5Rpxxrxa
baWneQO8FaZiv8R0ER7Gbcp9s9Vb1P+W+31JBD2Jtays/BCDTIwAPFyCSZ57KiE=
=0tJq
-----END PGP SIGNATURE-----

--EAECBqR2X0HbR9Ag--
