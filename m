From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Mon, 16 Mar 2009 12:00:47 +0000
Subject: Re: [PATCH 04/04] sh: prefetch early exception data on sh3/sh4/sh4a
Message-Id: <20090316130047.984f938b.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Mon__16_Mar_2009_13_00_47_+0100_kW5IYTJNVo.oAz3J"
List-Id: <linux-sh.vger.kernel.org>
References: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
To: linux-sh@vger.kernel.org

--Signature=_Mon__16_Mar_2009_13_00_47_+0100_kW5IYTJNVo.oAz3J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Mar 2009 11:30:13 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Fri, Feb 27, 2009 at 04:53:00PM +0900, Magnus Damm wrote:
> > On Fri, Feb 27, 2009 at 4:22 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > > On Mon, Feb 23, 2009 at 04:19:31PM +0900, Magnus Damm wrote:
> > >> From: Magnus Damm <damm@igel.co.jp>
> > >>
> > >> Prefetch early exception data. There is unused space in our
> > >> exception handler cache line anyway, so this is almost free.
> > >>
> > > Hmm, this won't work, 'pref' doesn't exist on SH-3. The binutils opco=
de
> > > table defines it as arch_sh2a_nofpu_or_sh4_nommu_nofpu_up, which excl=
udes
> > > SH-3. mova is ok, though.
> > >
> > > This does show how often SH-3 gets tested though, as asm/processor_32=
.h
> > > happily defines prefetch() for SH-3 when it shouldn't. I'll tidy this=
 up
> > > and drop in a PREF() macro.
> >=20
> > Right, I do recall building for hp6xx at some point. Thanks for fixing =
it up.
> >=20
> The fact that that didn't blow up on the opcode is likely because the
> toolchain you were using had no idea about SH-3 ISA tuning, and so fell
> back on an anything-goes tuning policy. If you are building for exotic
> combinations, always do a single run with V=3D1 to make sure that the
> CFLAGS are sticking and doing what you think they are doing.
>=20
> There are far more people building SH-3 targetted kernels with an SH-4+
> specific toolchain than there are actual SH-3 users, the latter of which
> tend to only provide feedback a few times a year. This unfortunately
> means that these sorts of bugs can be long lived and tedious to bisect at
> a later point in time, but there is not much that can be done about that.
> --

I usually build a couple of kernels per month for the hp6xx (sh3) so the bi=
ggest
stuff kernel wise usually gets caught there. I however use an old sh3 toolc=
hain so
gcc stuff often runs me by. Lack of time to fix the hd64461 mfd driver is p=
robably the main
reason why hp6xx isnt more in sync currently.
If theres anything specific you want to test just shout. I keep an close eye
on the mailinglists even if I dont say much :)



> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Signature=_Mon__16_Mar_2009_13_00_47_+0100_kW5IYTJNVo.oAz3J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkm+P28ACgkQPQls10ERAGc6/QCeKu4j0e3ikU2mLHcVNTv21GxU
gBYAn2Yb6RWeUOSa3rjMDP9WgRRkwhBK
=lWb3
-----END PGP SIGNATURE-----

--Signature=_Mon__16_Mar_2009_13_00_47_+0100_kW5IYTJNVo.oAz3J--
