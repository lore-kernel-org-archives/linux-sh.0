From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 03 Jul 2012 19:33:35 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <20120703193334.GI29030@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yxUjl2uTvAeSG6i1"
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
To: linux-sh@vger.kernel.org


--yxUjl2uTvAeSG6i1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 03, 2012 at 05:35:34PM +0200, Guennadi Liakhovetski wrote:
> On Tue, 3 Jul 2012, Mark Brown wrote:

> > But in general I'm not sure we're requiring that .configs
> > that people can generate do more than build.

> Well, you could have a kernel configuration with REGULATOR=3Dy for some=
=20
> reason with fixed regulator disabled. It would work with earlier kernels.=
=20
> Now it would begin to fail... Do we want to allow that?

Well, it does happen from time to time; for example when moving from
forcing some GPIOs on to making them software managed.  It's only going
to affect boards which were previously using regulators but not the
fixed one, I'm not sure if that is common for these systems...

> Well, I suspect, other boards must have had the same exact problem, as=20
> they added regulator support. It seems some boards to that, but not all...

Handling this really needs some kind of "set on upgrade" thing but I'm
not sure that's worth the trouble, especially since it's not that common.

--yxUjl2uTvAeSG6i1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP80kDAAoJEBus8iNuMP3dCZwQAIi7ymGcwtq5leQkBfU7Xovq
mkn3abDpoC1qoxCLkQIhXcwOCVLzHQsJu8NGm7MT0Ye/dskSsmtdduB9CSm1dE5V
u9TGtczjYHRwCsacM4OYQipvh+Js9uU9U/JM5SzyZe8IYNL+RnKdtWPvdqAv8K3b
mYfAiRA7Y/JZdrG++sJK+JA3itrHmovSdZxvaJdljevuA2ZcPRP+QOXZE7A2Mwk0
E3eMCpAsx4J+Ol8FDlmyrexOpntMTO8UBV39zjsKtYbEsZj+2RxYKS6xWhPBExSN
OzIpskxNoBH+EJwXUSbQ0ht9b/G9gqsNnH7clb5MM1Tvle2AF+qJWJjesBJBEiVT
u5Ab9iH2n2HprlqRVmfg3IC05QaQP7DMlwnYmxk+6VC90FD28kzQ2iQaONl/0pbp
ohkCTXMfl66oL7ZF4MuUtr7ZfZUotlIR0o1r77bDzTyPR6OU9SIK6qfF6MUQArIg
x7d30lpj1QZTC8ZeSzeVRQ4DwMRu6xOf2FNGEBqcyWUjEvOLve1r3/vkZUrLByjE
9PsrLdqU5LwtnsOWf06iuJ8G923+NMHWbhsL/phanw4cmrIwtw3/DSTZgzkwkJCd
nF6iM43OvFfx808635kPS0xtoCrurNJac1+6evrBxBjaBVewWDtItI7xJUCdXUul
A3i30movw7XXl4cYqxeQ
=V0vm
-----END PGP SIGNATURE-----

--yxUjl2uTvAeSG6i1--
