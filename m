From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 26 Apr 2018 13:23:45 +0000
Subject: Re: Board support for NextVoD - pdk7105
Message-Id: <05070629-9baf-8945-6d47-60ca526f0370@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <406f18f4-33df-04f8-919b-5f431dd2229b@physik.fu-berlin.de>
In-Reply-To: <406f18f4-33df-04f8-919b-5f431dd2229b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi!

On 04/25/2018 08:30 PM, Rich Felker wrote:
> I've got my replacement NextVoD setup more properly now and ready for
> development work.

Cool \o/.

> Is this the source for the kernel you're using and
> shipped with it? The repo does not seem to be based off upstream
> kernel git at all, but rather a new repo starting with some
> already-modified 2.6.32 tree as the initial commit.

The kernel on the device is based on this source:

> https://github.com/dlintw/kernel-pdk7105

which is based on the ST-Linux kernel from:

> http://archive.stlinux.com/stlinux/2.4/SRPMS/index.html

There also is a 3.4 version:

> https://github.com/dlintw/pdk7105-3.4

But I haven't got it to build yet.

> If this is the right starting point, I'll pull the initial commit from
> it and start diffing it against STlinux 2.4's "2.6.32" (which is
> itself already modified and probably contains a lot of prereqs; src is
> available as srpm at http://archive.stlinux.com/stlinux/2.4/SRPMS/),
> and see if I can determine what the actual changes are.

Yeah. I think that sounds reasonable.

FWIW, the ST-40 stuff was already part of the Linux kernel but
it was removed at some point:

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=F96691872439ab2071171d4531c4a95b5d493ae5

> This could be a good direction for future of arch/sh -- presumably all
> the ST SoCs have a lot in common and could probably be a good first
> target for supporting with device tree rather than legacy-style board
> files full of platform devices.

Device tree would be really cool to have for more SH devices.

@Yoshinori: Is there any chance the LANDISK device tree patches can
             get merged at some point?

Adrian

--=20
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
