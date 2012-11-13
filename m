From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 13 Nov 2012 10:01:48 +0000
Subject: Re: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8 #2
Message-Id: <20121113100144.GX18224@opensource.wolfsonmicro.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="xi8lRpXYeGgNnUjs"
List-Id: <linux-sh.vger.kernel.org>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <201211122111.03440.arnd@arndb.de>
 <20121113053651.GB18224@opensource.wolfsonmicro.com>
 <201211130848.03800.arnd@arndb.de>
In-Reply-To: <201211130848.03800.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org


--xi8lRpXYeGgNnUjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 13, 2012 at 08:48:03AM +0000, Arnd Bergmann wrote:
> On Tuesday 13 November 2012, Mark Brown wrote:

> > Please never pull anything from me unless there's a signed tag for it,
> > anything else I won't know about and may be rebased or vanish or
> > something.

> Ok, thanks for the reminder. Do you have a signed tag containing ab6f6d8521?

Nope, your e-mail was the first I'd heard of the cross-merge.  I guess I
could create one if this is going to get redone for some reason...

> > > I have taken Mark on Cc to let him know about the dependency now, and I've
> > > merged ab6f6d85210c4d0265cf48e9958c04e08595055a (which has only shmobile
> > > specific ASoC patches) into the next/boards2 branch before merging your
> > > branch. This is still not perfect because it breaks bisection, but it's
> > > the best I could do aside from forcing you do do another round-trip.

> > What's the bisection problem?

> I merged ab6f6d8521 first, and then Simon's branch, which means that the
> linear (first-parent) history is ok, but bisecting the entire state of
> the tree may end up in a commit in his branch in a state before it was
> merged into mine, where it doesn't contain the patches it depends on,
> and as Simon mentioned in his pull request, that will cause a build
> failure.

Oh, I'd missed the fact that this wasn't coming in via a merge into
Simon's tree.

--xi8lRpXYeGgNnUjs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQohprAAoJELSic+t+oim97UAP/3Tz9xzTjMdhENuElL6ks6hZ
kBaG9zGDR0G/q1UOE1MbkJ/ZLGikfHnHm97R7J41s8nIeiDBpb9l0iYIZQgbTVlQ
KYoumrDrhJgruy7I4RHHEy8HdYxeMh5htUYGa7nswO/54ibK3nx2vFTiwIgvIz14
phRHP7eClvR+UR3e2vAX+v/ZzgsKgCgoIia1FLkXSu/BuncHCoBJsPuHIMCZD10g
222gP3hUy8Dnb51JXggqk+P9yC7PWSQfXcObQARifll8l8HvtZUfjTGtMSGOaE2f
1/4rIY0B3xCWTXnGu2M/HwyF1JUwTJ8kDMmVWy4dSzAwtheRg0VAWTnDxDBFw3i4
DAAPla23r4h7sVw0XAYlF48P0ErYX9BNJ/8NU4Vzx5Lw35KWAuRe9s9be8r82g3h
rQgT4XiW0zvok8xHMe9W2+zB5FsxH5bz2dWrxNcEZu2aFPJemfYg4cLUCl1DAvHN
heu1XDYB1DBXpZwyNxvY2cl77eLUBFO1nfsXBUjVnZRlfU5m1g1q3XHUjokpfHUl
I7ox1a1WqBbHhQodDaPkCoJPEBn9nI4IZt8VrckLT0z75YoMfOUxAbe5qg/MfpMq
EIC+V84xcTd8SxQKArKo1iM+iEx+G2rTv3ZJ+DxBB46Wd/sIBpvcYRrcqNzmEVlD
fMgkfI1BEyo1/xPLB0Fz
=OFUN
-----END PGP SIGNATURE-----

--xi8lRpXYeGgNnUjs--
