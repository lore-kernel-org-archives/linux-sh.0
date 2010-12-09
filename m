From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 09 Dec 2010 21:14:24 +0000
Subject: Re: [PATCH (sh-2.6) 1/2] sh: add stack smashing protection support
Message-Id: <201012091614.26353.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1369475.LfC8q9HC8B"
List-Id: <linux-sh.vger.kernel.org>
References: <1291717254-17455-1-git-send-email-filippo.arcidiacono@st.com>
	<201012091232.31577.vapier@gentoo.org>
	<alpine.LFD.2.00.1012091313270.10437@xanadu.home>
In-Reply-To: <alpine.LFD.2.00.1012091313270.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org

--nextPart1369475.LfC8q9HC8B
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday, December 09, 2010 13:23:55 Nicolas Pitre wrote:
> On Thu, 9 Dec 2010, Mike Frysinger wrote:
> > On Thursday, December 09, 2010 11:45:30 Carmelo AMOROSO wrote:
> > > On 12/9/2010 5:07 PM, Mike Frysinger wrote:
> > > > On Thursday, December 09, 2010 10:56:26 Carmelo AMOROSO wrote:
> > > >> I agree with you that the Kconfig and Makefile changes are not arch
> > > >> specific, so these changes can be moved to a common code (even if I
> > > >> don't know if other archs do support SSP).
> > > >> In the current kernel, only x86 and ARM added this support, so I'm
> > > >> wondering if, moving SSP to the common Makefile, it needs to depend
> > > >> on x86, ARM, SH being configured ?
> > > >=20
> > > > i'm not sure it does.  ssp is designed to be arch independent, so
> > > > really you only need a new enough gcc version.  which means i dont
> > > > think it needs to depend on any arch code and you can simply add to
> > > > the Makefile a compiler check.
> > >=20
> > > agreed, but if arch wants to implement the per-task canary feature,
> > > some change into arch specific code is required.
> >=20
> > yes, but that doesnt mean the common symbol definition needs to be
> > duplicated
>=20
> We are talking about only one symbol here, which symbol is also
> dependent on the way this feature is implemented in gcc (e.g. on x86 the
> implementation is totally different and this symbol isn't used).  So I
> don't see a huge gain by defining this symbol in generic code, given the
> number of lines involved in the addition of a new file, just for a
> single symbol.

you're right, a few targets dont have any symbol at all and do it through T=
LS. =20
although that is more of an exception than a rule, so i'd still like to see=
=20
the symbol in a common file.  perhaps reverse selected by the arch Kconfig=
=20
like "select ARCH_WANT_STACK_CHK_GUARD".  or perhaps invert the logic so on=
ly=20
the funky arches get punished.

i might highlight that the way gcc/i386 manages its canary is dependent upo=
n=20
the C library it was compiled against, but i dont want to poke that nest as=
=20
i'm not interested in making it work on that arch ;).

> > i think you only need to test that gcc accepts -fstack-protector
> > and then assume the rest ... i dont think you need to come up with rand=
om
> > pieces of code and cajole the symbol references out of gcc.
>=20
> Would you care to elaborate?

i simply mean that any makefile code checking for support need only look fo=
r=20
gcc supporting -fstack-protector.
=2Dmike

--nextPart1369475.LfC8q9HC8B
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNAUayAAoJEEFjO5/oN/WBLjIQALlf+vmjVTaXBfh0D0aCE+oT
rSVkPcKD5PQ838RaUlGZRwn3fOv7A+XNh+YGOZuBiRitNJ3nD5iTLXyz+TZkrVdR
inshH1Zb8euTaHge4teQiNsNXMhVjJ0auU6qkDhoOeAN7z9CkZo1RPTbovLvPCNu
CewkAlx+XU56UgGg78cqduEOSxRu2kh/J8ZD80fn0nCiZKv+EjdLLXs3DeX09uFL
gvJ70jfSmp8CZsovVuCiUKC0XThIpBFRwFtwZSVzj1WjlTZKzPGJBBC3OpNH1X9r
db4fba0v2FC7+SL3KdVxpztusIfTIcmlpMPS77l1skr+et5WqW9OLNW211Hv++JI
Lr+S6u7Gjtg0FslPlMo6Oq5D7MY6Xl+gX1nRC8zczItg21imoMXf8aGB9pqQ9eQZ
wT61d1HBwtZz3Sd1InSTYp5/yk7JhFdW9Rfh2mfgXQiiQk4FPfjO4tp34hAUP4uy
Lv3yGkiWaCOeY5p7oi09y6d9/ilq6bdblAMt69EmUylwjbtP2hHsHRtF5Lsj0Kqo
mdFcrm74E9pttHwKgtE7LVa5hj/42zlDPJYVKq5Bz+l4MKB0t+7NgiTNCvn353cJ
0wiWJKXJHgCbnnxXYHwuHWCCVDvE7eNWQABGe9Wv+Xvel7+7LyeUHYzE5qgkkgwY
amk1V5qUE65ogYL9N8Fa
=q6wO
-----END PGP SIGNATURE-----

--nextPart1369475.LfC8q9HC8B--
