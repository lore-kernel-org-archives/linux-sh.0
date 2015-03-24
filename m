From: Mark Brown <broonie@kernel.org>
Date: Tue, 24 Mar 2015 16:27:10 +0000
Subject: Re: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <20150324162710.GJ17265@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="4vpci17Ql0Nrbul2"
List-Id: <linux-sh.vger.kernel.org>
References: <550F6E10.8010907@jinso.co.jp>
In-Reply-To: <550F6E10.8010907@jinso.co.jp>
To: linux-sh@vger.kernel.org


--4vpci17Ql0Nrbul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 24, 2015 at 04:42:44PM +0100, Geert Uytterhoeven wrote:

> This seems to trigger a bug in the SPI trace code:

There was a use after free bug which should be fixed in current code.

--4vpci17Ql0Nrbul2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEZBdAAoJECTWi3JdVIfQfFUH/1DwDFIQcDfFle+dRqaOC4yO
YvUDUMEAZ50gSWSms//mZJiNe94nn/w5B3vbgk7J8oR5irMhumsAF8FxrcKjF46f
EnXjumsnm4q9tnKskKyZ+OGgzXPCoJIYyh/U7fPJx2hwHwVqgSt5gVQguzXdVmvg
Bmykjb6GTg2B3G8et0PZ9J8Jj03l+KUrV59WGfQfk50JNrQyEYhaylOH0X3WAlK+
nDXO9K+XJjQDJAlnUXV2OOTCV27EaG/wvltaxFa0J6Uj5em329z5xpQdR0HhB9s7
zUMu16Hj6RXxu4Es3HePzB6TWSpg8XTYhiZUmBjbAZ4J7JQZJxXEP2K//xvDXwg=
=e7qO
-----END PGP SIGNATURE-----

--4vpci17Ql0Nrbul2--
