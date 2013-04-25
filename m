From: Mark Brown <broonie@kernel.org>
Date: Thu, 25 Apr 2013 12:16:49 +0000
Subject: Re: [PATCH v2 2/4] sh-pfc: sh73a0: Add VCCQ MC0 regulator
Message-Id: <20130425121649.GT5019@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="CqxttG7JecUZZO5Y"
List-Id: <linux-sh.vger.kernel.org>
References: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366840828-17335-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--CqxttG7JecUZZO5Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2013 at 01:18:39PM +0200, Laurent Pinchart wrote:
> On Thursday 25 April 2013 12:07:18 Mark Brown wrote:

> > You could use an MMIO regmap providing the performance isn't critical
> > enough for that to cause problems.

> Can you share a regmap object between two separate drivers for two separa=
te=20
> platform devices ?

Yes, this is commonly done with MFDs for example.

--CqxttG7JecUZZO5Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJReR6qAAoJELSic+t+oim9z1kP/1QoeC50Ei2CS5icAI4np+as
wjpEC5MensEUZxDpLFlYJeuIz3Fdlhl9uJuIfy1eHoshmsuzt9z7L/7cCW3s5XdZ
NZrJHQagi4MngatKK8fmXzp6c17XDOUmXp0hWHll0MvLsIai57/C3pyXtfQbzptA
foQNMfNbo2hIclx5OflvAfyUu+xYFld08zTq6Plho7LIE+uYCnoR6fqiNKM3S6kP
F62f1/4okfOkEqeMnplCAsBm1PY9aiugQXxfemkfnGTRG0uBUj20r4VSCrkdAbZY
EzNLG4F7CZAA5YPo+ysg+4thVRMyZuh1eeN01OwGSAorlLg+IqfRDN5u4FChuXTp
3+zL+8Xv6Sk9eDIAQ6kD+m6g+gDR9KYTG65wZiSsNVUtBgWkAn9US4wAO9cfQjtv
rd/zoLCdj08bmt3FfH1S54QMKlhM0Nq0osny06XVBSpmwnwYZZ68XrG4Ih2/t4vH
pPSZxVcNBMhPtxdM4P9+9y0v6eNhv7WGLLzG9qimMgvcgG2+EsPBTeQ/j6u4FT99
Zwy5SFj5uqjx8IkeztSsR07AUzr82HqmTNs+NGs/JoKXN1GnngST+JJ7y7g/Ye0i
gnLUHa6Zdk+oqzi1RzUbj/QalngqtN5gukVYS3PzzalECFSfiJGRVNho0PrQjD1k
vE/zcgRV1uGSIbMIGg7F
=qrA5
-----END PGP SIGNATURE-----

--CqxttG7JecUZZO5Y--
