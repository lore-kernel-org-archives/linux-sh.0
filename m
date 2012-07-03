From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 03 Jul 2012 14:45:14 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <20120703144513.GS29030@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8N5nZmKALFZnI1Hj"
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
To: linux-sh@vger.kernel.org


--8N5nZmKALFZnI1Hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 03:44:32PM +0200, Guennadi Liakhovetski wrote:
> On Tue, 3 Jul 2012, Mark Brown wrote:

> > This doesn't seem right.  If this is useful we should just remove the
> > configuration for the fixed voltage regulator entirely as there's
> > nothing platform specific about this, and we probably ought to be going
> > through all the boards using "real" regulators adding selects for their
> > drivers too.

> Hm, why? Let's take smsc911x. The driver needs "some" regulators for its=
=20
> two power pins. On different systems different regulators are used for=20
> those supplies. It just happens to be the case, that many sh and=20
> arm/mach-shmobile platform use the fixed voltage regulator for smsc911x=
=20

What I'm saying is that that statement is equally true if you replace
"sh and arm/mach-shmobile platform" with "systems".

--8N5nZmKALFZnI1Hj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP8wVyAAoJEBus8iNuMP3dBIYP/RM8moHoz9HOghdL5XXlqQYK
JzSzQxifdl1bHqFaZqud904AN10/699OYa0FNO4GIyFEAHYDdGlF0s699vbD8zy5
auivZjCuz5ELzIBZFOiFGnDXYE6jsAXnH+FmJ62j/Bnvjb9cuOzT0AEVcMnckIvL
KVTVe36x2jEHtgmPGhgz+6KgFnCPjUVu8HOoJQUhtnb/W9bQjuHfrFBqo+X1m7oX
A19DojPRSLFzxlAC5B+nl8z0whAXv4zCmhCJyXb4otAxX6FLmkGIVYd6Chdh3i6Q
W/D8N+Sq6pXw724TEHSe8/t/cJaXdrnchvmatrFfDhU51L4ZF5TX1CsOA/Nsc2oh
Dc5UTGSsVEtAlMDsf7I4cJd+HVhlcyexlIffZLxkWJe84tFhbIcw/thEr4Ub/Xs3
xv3m78FDXc4Chcqmhg+CDfIyUmY7w8L5/mJwFxjTD70N8r0bbiLz2gwoq+Z5QnfA
D3XXVDUfzd+Y7zEid1PnkZQ0bsqyqJZjDAb8JOZFQgoMHkFIR8u8Rmm+5WY9Et1L
FrEE7iW2uNjEtQCxxhrBMwiEVg7AwLF8jg0yPB+Weuh9f+318DCJeJlQHN2L8+vh
9jvBL9V/rweC2zYaiZvk35nUGeKGXEJjEbMO16fpMaBXiy3GvUpU8thVkn9APyYD
k6w637WUvwnWs+BaReF+
=53np
-----END PGP SIGNATURE-----

--8N5nZmKALFZnI1Hj--
