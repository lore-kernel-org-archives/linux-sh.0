From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 11 Dec 2014 21:47:32 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: add DMA support
Message-Id: <20141211214732.GC21482@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="dkEUBIird37B8yKS"
List-Id: <linux-sh.vger.kernel.org>
References: <1415355104-2031-1-git-send-email-wsa@the-dreams.de>
 <10746939.zT8Pinqvll@avalon>
 <20141210142314.GB8247@katana>
 <2462101.Er8OZg9N24@avalon>
In-Reply-To: <2462101.Er8OZg9N24@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, dmaengine@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Note that the I2C drives uses subsys_initcall() for historic reasons,
> > while the DMA driver uses module_init(). This is hard to revert without
> > introducing potential regressions on older boards. So, the I2C DMA
> > support needs to handle deferred probe definately. I am with Laurent, I
> > don't see any other way, but I'd be glad to be enlightened...
>=20
> While I believe that requesting the channel at transfer time is the good=
=20
> solution, I think we should still try to move to module initcalls where=
=20
> possible. The risk of regressions is real so proper testing is needed. My=
=20
> question is, have you tried it ?

I would need to test all boards using this driver to not fail booting.
Usually I2C drivers are moved to subsys_initcall because they need
access to something critical (PMIC, GPIOs...) early. I don't see a sane
way to do that testing.

Other than that, even if we move to module_init, we reduce the chance of
getting a deferred probe, but we do not eliminate it...


--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUihD0AAoJEBQN5MwUoCm2guQQAJ6hZ4BfeMG6jkDYg7oNhcQX
L1YWAho5nvObgmatd9MHqzSAhYIFPyZISLca6iGfv1+gmyNdhxcbo43xs14cv/2A
A4uYoxBDkxA1CmHm6zRQl5AkChkHYrjXeohTflSusYHeFOxXzILOQLkigSX6LrKB
X2mmmpAYrudy3puJnKWIf533F9S41+fVZJif6gZyiCes5eNS8iYQ/CQcxGuO6KC9
roQDA5Y4bNSW9+8IT5YdyGyxO0yG7blqgrsz4yCZYnEe1QJfyghFFqh/7SORwgD3
maB4sjcJoB3d5mzlgxOWalEP7Vxsv1KsJ82X/bJj0ZizWXh/PkkYtdYDyyBuk+Gc
XycpP0F2t3zJA/kUnXFtzTpdVKDZR+bSN95Pf7+w5RjxuYgYLBWQQU8iZWP6tOG3
7Cu3a7Km/4Z34AqI2pxYVtmaOu1z844KC+o6clZs2+PvTAxz1wyS4LOa4B2NQ/7X
QisQRgoCr+f6100yc3+20Z0xD9cX/X6OStyAb8uu4/BSyt4Nx9kLJiS6YGFLz2ho
JpplnYK369jAGXccLrztVDWOUahUW8wDxS3BefycEoJdkuyQ314EgMqualKsmk57
6gmxVFjWgCmSF2SGpcCsZDVv7Gw2CwsDw/pLNPUncYdEaYTvSulneJGz/JhH0NGJ
KYKMNZEgwQMGXEEoMZOw
=SoAm
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
