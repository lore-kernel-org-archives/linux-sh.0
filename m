From: Mark Brown <broonie@kernel.org>
Date: Mon, 20 Jan 2014 15:56:43 +0000
Subject: Re: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <20140120155643.GQ17314@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="apqMg07LpBOyFFAR"
List-Id: <linux-sh.vger.kernel.org>
References: <1389707776-23306-1-git-send-email-ben.dooks@codethink.co.uk>
 <20140120125436.GN17314@sirena.org.uk>
 <52DD224B.1050502@codethink.co.uk> <1482392.XFeYNLvUZH@avalon>
In-Reply-To: <1482392.XFeYNLvUZH@avalon>
To: linux-arm-kernel@lists.infradead.org


--apqMg07LpBOyFFAR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2014 at 04:48:10PM +0100, Laurent Pinchart wrote:

> The problem isn't as simple as it seems, and more advanced implementation=
s=20
> that would allow listing clocks that should be managed automatically (or =
the=20
> other way around) would also add another level of complexity. The require=
d=20
> information is platform-dependent, but we currently don't express it as s=
uch=20
> in DT.

Well, the set of clocks an IP requires will tend to be the same - it's
normally just that integrators may have done things like tie them
together or decide to spread confusion by renaming them.

--apqMg07LpBOyFFAR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3Uc4AAoJELSic+t+oim9F3QP/1Fqx6+KjKpnKAzcTypCWTFW
MvyiFPVmFGnRpaLqeQeBfWp6IFzYp70uYqghGwMkBHptTy7jui9MSphL9rRg/EmZ
TndCpmAx8vOY6cdLwwL17+uVcJ2hWOdtfHP1kHIVXat1jdrrJtoFHXABdUI3oY8e
taEmfdr6J2q3GA9o9Tw5pck9qUOLe96/eksu3cLqaVD+fmx+CutNPZ380u2VnYJh
3qObbG1ZzpRE47DQGwL2aLZ3T16RfIn4egaR/9PMxxFFm1I8CSVlh4vIQu+2Sp90
TbfWe0v5cmWvyVfOd7URc8JXrO62krPl4GcNjUq9eC3fbeNHLkoBCb1xo6FlyOVt
lECETM952mRKR6NYP+d7pXLpet0SEVs8QiooIqI7JyZlggaPAmBao3kIVhGUAqNn
2ja9AyGxPhuQlU0Y4Gb1LU24inp3EkRkLa00NYvvcnOc/pq/SiAnt+jDFVAzBFzJ
MtDzlbvyu1iaQirqCdtPBhxXci77MUrxfeS/DJYk2vjAEbR6U0nN4LxBvYB1UEnj
qAWnzYglEHHCpCF9G+sgoego5GvEf0/nTEFO+pe0Z6Yj6Uuk61TZY40Va4XeTKKv
WlFa8HOpS85FSgxVA38i5M1wGqjG2Vrlbmh3qjGYRg4nUOdf4rSNMCVO9iz/hPvA
ydgxEAympX/M9K1hjkUA
=VqjL
-----END PGP SIGNATURE-----

--apqMg07LpBOyFFAR--
