From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Mar 2015 09:44:06 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: R-Car Gen2: Add da9063/da9210 regulator quirk
Message-Id: <20150303094406.GI21293@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9Lxh293ZELbusAxJ"
List-Id: <linux-sh.vger.kernel.org>
References: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org


--9Lxh293ZELbusAxJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 06:28:43PM +0100, Geert Uytterhoeven wrote:
> The r8a7791/koelsch development board has da9063 and da9210 regulators.
> Both regulators have their interrupt request lines tied to the same
> interrupt pin (IRQ2) on the SoC.

Reviewed-by: Mark Brown <broonie@kernel.org>

This is all rather fun isn't it?

--9Lxh293ZELbusAxJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9YJlAAoJECTWi3JdVIfQD3IH/RlFanJL0hKC3ikeLS/rYDSA
1onMFxdzGI+EDnAKYsYKkaPXKMG/GAoc2FqBXixPQrBcw9L9eIFmJC2B78wBZMzb
7n60jFTgtLunpv9KXRaAAEYv1YjzHzgjOCLd5tnKPoaunEu2O+lIqFJLi71WX1RW
d7mCY/wCZOzS79+8VSihMdgUqRft5+KKEca2pKN1+u9915pc5m6Ija1So/ub9DRs
4RAo4HKOcvXqnCGg2mLFF5u5/zhaa29Nh/z3KSqT9CIqgT1OmWIF5lId7wElhRnN
I/M/n4+UBOZKKoE0IJTmjd0eCsUM2I9hvczdidxYLEKpemj0wXYDgIUKdhiV+HY=
=4blo
-----END PGP SIGNATURE-----

--9Lxh293ZELbusAxJ--
