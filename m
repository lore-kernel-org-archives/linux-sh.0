From: Rich Felker <dalias@libc.org>
Date: Thu, 26 Apr 2018 15:47:40 +0000
Subject: Re: Board support for NextVoD - pdk7105
Message-Id: <20180426154740.GI3094@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <406f18f4-33df-04f8-919b-5f431dd2229b@physik.fu-berlin.de>
In-Reply-To: <406f18f4-33df-04f8-919b-5f431dd2229b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Apr 26, 2018 at 03:23:45PM +0200, John Paul Adrian Glaubitz wrote:
> Hi!
>=20
> On 04/25/2018 08:30 PM, Rich Felker wrote:
> >I've got my replacement NextVoD setup more properly now and ready for
> >development work.
>=20
> Cool \o/.
>=20
> >Is this the source for the kernel you're using and
> >shipped with it? The repo does not seem to be based off upstream
> >kernel git at all, but rather a new repo starting with some
> >already-modified 2.6.32 tree as the initial commit.
>=20
> The kernel on the device is based on this source:
>=20
> >https://github.com/dlintw/kernel-pdk7105
>=20
> which is based on the ST-Linux kernel from:
>=20
> >http://archive.stlinux.com/stlinux/2.4/SRPMS/index.html
>=20
> There also is a 3.4 version:
>=20
> >https://github.com/dlintw/pdk7105-3.4
>=20
> But I haven't got it to build yet.
>=20
> >If this is the right starting point, I'll pull the initial commit from
> >it and start diffing it against STlinux 2.4's "2.6.32" (which is
> >itself already modified and probably contains a lot of prereqs; src is
> >available as srpm at http://archive.stlinux.com/stlinux/2.4/SRPMS/),
> >and see if I can determine what the actual changes are.
>=20
> Yeah. I think that sounds reasonable.
>=20
> FWIW, the ST-40 stuff was already part of the Linux kernel but
> it was removed at some point:
>=20
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=F96691872439ab2071171d4531c4a95b5d493ae5

Thanks. This info is all very helpful. Especially the removal commit
gives a good idea what the minimal subset of the STlinux fork needed
to get something to work might be.

> >This could be a good direction for future of arch/sh -- presumably all
> >the ST SoCs have a lot in common and could probably be a good first
> >target for supporting with device tree rather than legacy-style board
> >files full of platform devices.
>=20
> Device tree would be really cool to have for more SH devices.
>=20
> @Yoshinori: Is there any chance the LANDISK device tree patches can
>             get merged at some point?

I'd like to move forward with them; the main thing that blocked me was
that some of the device tree changes were incompatible with how we're
using DT already on J2. One I recall was just changes in how the boot
commandline is handled, which can probably be omitted or made
non-breaking with minor changes.

The big issue I think we need to resolve consistently is what
"physical addresses" mean on models with MMU -- P1 (or whichever one
it is) segment-based addresses, or physical addresses in the sense of
what goes in the TLB entries. I think it should probably be the latter
but I'm not sure.

Rich
