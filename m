From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 03 Nov 2011 23:07:42 +0000
Subject: Re: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
Message-Id: <201111031907.46434.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart36684412.BmYt919zzi"
List-Id: <linux-sh.vger.kernel.org>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
	<201111031816.37427.vapier@gentoo.org>
	<20111103224452.GS12913@n2100.arm.linux.org.uk>
In-Reply-To: <20111103224452.GS12913@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--nextPart36684412.BmYt919zzi
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 03 November 2011 18:44:52 Russell King - ARM Linux wrote:
> On Thu, Nov 03, 2011 at 06:16:33PM -0400, Mike Frysinger wrote:
> > On Thursday 03 November 2011 13:00:44 Peter De Schrijver wrote:
> > > This patchset converts ARCH_NR_GPIO to a Kconfig variable as suggested
> > > by Russel King. It also converts some platforms to the new model.
> > >=20
> > > Peter De Schrijver (3):
> > >   ARM: ARCH_NR_GPIO: Make ARCH_NR_GPIO a Kconfig variable
> > >   ARM: mach-shmobile: Use CONFIG_ARCH_NR_GPIO
> > >   ARM: mach-ux500 Use CONFIG_ARCH_NR_GPIO
> > > =20
> > >  arch/arm/Kconfig                           |   10 ++++++++++
> > >  arch/arm/include/asm/gpio.h                |    4 ++++
> > >  arch/arm/mach-shmobile/include/mach/gpio.h |    2 --
> > >  arch/arm/mach-ux500/include/mach/gpio.h    |    5 -----
> > >  4 files changed, 14 insertions(+), 7 deletions(-)
> >=20
> > i'm not sure how this is an improvement.  we go from declaring the defi=
ne
> > in the right mach-specific subdir
> > (arch/arm/mach-xxx/include/mach/gpio.h) to an arm-global file
> > (arm/Kconfig).  i'd think the ideal would be to keep all the mach cruft
> > in the mach-xxx/ subdir.
>=20
> It most certainly is an improvement.
>=20
> One of the things that we (the ARM community as a whole) is focused on to
> is to reduce the amount of code in arch/arm through consolidation, removi=
ng
> as much duplication as practical between the various SoCs.
>=20
> One of the other factors that we're also focused on is:
> (a) reducing the number of configurations which have to be built to
> properly build-test ARM
> (b) reducing the number of kernels which have to be built to support a
>     range of ARM platforms

i'm aware of these efforts, but i don't see how this Kconfig solution gets =
you=20
there.  it's still a single define depending on arch-specific knobs.  now, =
if=20
this were treated as a max value that was based on all the arch needs, it's=
=20
now useful across SoCs.

> It's one reason why I won't be acking your patch which pushes new stuff
> into the mach/gpio.h headers at a time when we're trying to get rid of
> them.

i already described in the patch that it was an improvement, and that it ma=
kes=20
things even easier to move away from mach gpio.h.
=2Dmike

--nextPart36684412.BmYt919zzi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOsx7CAAoJEEFjO5/oN/WBwGoQAJuFqRtZEgpFTz/Vm4sdaATi
sYfqVgTf5fB+UgzGPV1gefa9DtepEPcwSQqOZX0hDux3aIb5Ra47JYRXSQbIU7ha
mz+8ujO+UJJU9lLago9zl1mql3myxfs89q3oJXuL77BskHudPRDfj68ntt0fLuZ9
AM48cAtnadK3bKPfSb/RUeC2vjFeZLyP+5BKnkUM2EuK66oePQTSg55nXe4+Jqhu
0JvkKC3nft+nzLqwKTyFoUPWoSUYLIIodNqyVYuLNeTzKdFQHfPEpQzFM2mApCJK
+hTcq1iOc49KKVQliOyVeFO6se0Qem2p6zsLbCFdtCGoDAM9OlGRXND/AuNLiRnL
nmZjtd3N0hTgRRUrne++n8mgGcgD3gSGoggrqdQ8dV2wHffN0tlmDFey5jgORbsm
TzaL7tfrOlpzmJYHyuflpt0IguYPKaX+jSIDUP5BUBUaWQjPPxvvDLkHr6qmpwUE
CNM4RnyFZl8Pb3WL06yHdC2IeK3be3XLoTYxH8PKPAtZdfVwusgJdp0ZJHEBqoxM
RTkKTcOn4BuFzR8DpGqDuN7iyYEyDsRW0WP/drWpGeuSDrPGV5qinYD2LlVCnYCg
ZcTWV8C7II2JgYfDtD2JqpL1XkAb0DsN28vE0y+/iamBInz3ivOdv750MKesafY6
Ala5rAzHeYf3cUce6T0b
=WVlm
-----END PGP SIGNATURE-----

--nextPart36684412.BmYt919zzi--
