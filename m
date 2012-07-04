From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 04 Jul 2012 10:38:55 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <20120704103854.GH4111@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="e5bfZ/T2xnjpUIbw"
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
To: linux-sh@vger.kernel.org


--e5bfZ/T2xnjpUIbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 04, 2012 at 12:40:56PM +0200, Rafael J. Wysocki wrote:

> Well, if arch-wide, then perhaps we don't need REGULATOR_FIXED_VOLTAGE at all
> and we can just make things depending on it depend on REGULATOR directly?

> The meaning of what you're proposing above is pretty much
> "REGULATOR_FIXED_VOLTAGE should be set whenever REGULATOR is" and I guess
> REGULATOR_FIXED_VOLTAGE depends on REGULATOR, so they appear to be equivalent.

> How much code does really depend on REGULATOR_FIXED_VOLTAGE which is not build
> when REGULATOR is set?

No, that won't help - the problem is that we want a specific regulator
driver to be built in order to ensure that the services it provides are
available.

--e5bfZ/T2xnjpUIbw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9B0YAAoJEBus8iNuMP3dvxYP/j9L/fdg7f8bF55HhMmbl0Sn
8ZliWW7tNJiSWdoxlxsx/xDHCXGHZO+S/wVie/zj+Xp88PEKcCxKuAhOcGBWELYf
mlMCiWIc6jZu95LIQPvJTy6aYs5Waz1RCdMkhDVwMkarR6HGp0qCyQNimOEf+Mpl
eRYpXbIAE+KJh6yuZTO6ScSgaM0L3+VokalB9InkzD3hM4cKlhPp3/UR8BmQNJr5
wySOeb7mdJuQW9JxDjGTxvsQMgxaCTzSNk+3YveyV/83mhMpgn5JjwntymJUsS+e
xDOZrUpRksrZ5+zV9PoOtKoJBIJ5C/T2eV4PTA3E8q8gST62+h7tI4AmBmVR0XHF
ztkSQb5bkKMNKtJlAh6Z8zuVbcGHcoSFqtqVi+BfBYkXm0IS5JXGz9vYp5Q35273
KoOYvvFJBBIaZTX69X6a6QGDlEg1G9/M/mgH6oqK6z24eh+NxUuuSV89qZCoUbqK
q/BVO+6WOMbibQaSTg9qDrLG7DgWoCfrc6IPcyjwxxmHMP4ItV4tfUCQHAbCcY8B
xt/2ndBBjgYcdg7D1SqQQsppD6XZ7mVgDujmFefweTNL/zb9dNGwSuXzn7ZXYHTz
U0KEwIyUQ4HY+rd/Fza4QE0dFumiyv6hWnDcJquuFtbCr3OkCHOf52d9EUx1wauc
wgeLIkoazp7OTK9h2Gf4
=yfKc
-----END PGP SIGNATURE-----

--e5bfZ/T2xnjpUIbw--
