From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 11 Jul 2011 04:30:04 +0000
Subject: Re: [PATCH 0/6] clk: Initial feedback for off-SoC slow bus clocks
Message-Id: <201107110030.06399.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2007026.UEfBvSiGjA"
List-Id: <linux-sh.vger.kernel.org>
References: <20110711025344.GA27497@opensource.wolfsonmicro.com>
	<20110711035732.GA5040@opensource.wolfsonmicro.com>
In-Reply-To: <20110711035732.GA5040@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org

--nextPart2007026.UEfBvSiGjA
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday, July 10, 2011 23:57:40 Mark Brown wrote:
> On Mon, Jul 11, 2011 at 11:53:44AM +0900, Mark Brown wrote:
>=20
> Linus, CCing you in as apparently you're taking over the clock API work.
> Do you need me to forward all the patches to you?

along these lines, i dont think the new people on the cc noticed my earlier=
 e-
mail:
for future series, could you cc uclinux-dist-devel@blackfin.uclinux.org ?  =
we=20
dont do clock management on Blackfin parts atm, but it's something we would=
=20
like to start doing.  our hardware can easily benefit from this.
=2Dmike

--nextPart2007026.UEfBvSiGjA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOGnxOAAoJEEFjO5/oN/WBNDEP/RwIRhml5mn6OWM6vyPZ8dBe
2iPdpMd08MmfRkWD55z8d7tlI+akKZUxFUflV5ta4YRDoMPJPR4y1trSWDad3GJJ
wjZ6K5UP0S3tbRXXx0bms7v4X08uNXMuSGxR5tzbke7niNKrLW1A3cRTJ3yI93tZ
t+cXmaLqujuWzjX29yHuMVSvLqEI9EQvLUoK4VPrxifph2vqZhe1XQxqhSIhRmNE
nLyg0BoYGuFI/lMQto02xZlYExCGrWU/TjmuAXVKoe+sKEy93jiaQbp1wbVOnmOz
eUKxltLRhnzPxx86yVdMLU2VjAeIhAOYBbNJHSsrh55mVWset3p5gDnBhbCYrvU4
Qx54JAoO1Gt0BfWnINzN23eJiIRFVoWSi0fkoKUaZZ02XrW7oXvKH6mFucBDLqUh
xRyQhWJ+BbJQDSF8AltCf3ROdahilCCXkBnf1lJ+Ncjqr4h7ytuUqmFK9h5KfSnE
qHJQgI1NZxp/dBzSzyUQtIF8DNSDsmKIXpfLC340U+4CWArytZTOQEM4bg981JM0
tBIDXg0RES8Qxiis9pDG0ck0cIPrltjBlmDCf53BKA4Q7jpWQixHZtzH1vwAW4wV
ttcJR4WyZeMphj0RTVMw+ZxzYWbkR2FdOb2Ox3wnDdJl/49RuNvrBdFncfPVGSIl
yV6RAPFT/uFstbqLNeMD
=pFEx
-----END PGP SIGNATURE-----

--nextPart2007026.UEfBvSiGjA--
