From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 22 Mar 2010 05:26:26 +0000
Subject: Re: [uClinux-dev] QUESTION- Codesurgery toolchain is usable
Message-Id: <201003220626.26378.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Sorry for the error; I'lll be more carefull in the future.
The question is:
my cpu is sh2a 7203; it has not MMU; in this condition, or building an=20
userspace application do I need to link use elf2flt; or the use spece=20
allpication will work also if I like using sh-linnux-gnu-ld without passing=
=20
trought elf2flt?

Thanks



In data luned=C3=AC 22 marzo 2010 03:43:42, g4@novadsp.com ha scritto:
: > Ciao Fabio
>=20
> Excuse the pedantic posting. It is CodeSorcery, not CodeSurgery. Though
> the English in me likes the proximity :)
>=20
> Sorcery: Stregoneria
>=20
> Surgery: Chirurgia
>=20
>=20
> CSLite is fine for compiling user apps.
> Why are you messing with elf2flt?
>=20
> ATB
>=20
> On 21/03/2010 20:56, Fabio Giovagnini wrote:
> > Hi all,
> > I have used codesurgery lite 4.4-43 and  I can build the kernel and boot
> > it successfully.
> >
> > Can I use teh same toolchain for building an userspace application using
> > uclibc? Is it necessary I link that application as BFLT (using elf2flt)
> > or not?
> >
> > Thanks a lot
>=20

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
