From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sat, 12 May 2012 06:27:35 +0000
Subject: Re: [GIT PULL] Urgent fixes (for v3.4 if possible) for Renesas ARM-based platforms
Message-Id: <Pine.LNX.4.64.1205120823450.7233@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201205112025.13478.rjw@sisk.pl>
 <CAOesGMh3g-7oTNBoj2ZWGw+9P1Sf7V89etLb-iZiVoKDEvhO8w@mail.gmail.com>
 <CANqRtoSDN+vYet+9qiNZQq73BdSiqPL3K+95wCbNL29wDvT4EA@mail.gmail.com>
In-Reply-To: <CANqRtoSDN+vYet+9qiNZQq73BdSiqPL3K+95wCbNL29wDvT4EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi all

On Sat, 12 May 2012, Magnus Damm wrote:

> Hi Olof,
>=20
> [CC Guennadi]
>=20
> Thanks for your help!
>=20
> On Sat, May 12, 2012 at 7:41 AM, Olof Johansson <olof@lixom.net> wrote:
> > Hi,
> >
> > On Fri, May 11, 2012 at 11:25 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> Hi,
> >>
> >> Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a5233=
7a3
> >>
> >> =A0 =A0Linux 3.4-rc6
> >>
> >> with top-most commit 5fab7b501bf29c08c5b01627b496b6b766bd0165
> >>
> >> =A0 =A0ARM / mach-shmobile: Invalidate caches when booting secondary c=
ores
> >>
> >> from the git repository at:
> >>
> >> =A0git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fi=
xes
> >
> > No such branch (nor tag).
>=20
> I believe Rafael will get back to you about that when he gets to his comp=
uter.
>=20
> >> to receive urgent fixes for Renesas ARM-based platforms. =A0Four of th=
ese commits
> >> are fixes of regressions new in 3.4-rc and the last one is necessary f=
or SMP to
> >> work on those systems in general.
> > [...]
> >> Guennadi Liakhovetski (2):
> >> =A0 =A0 =A0ARM: mach-shmobile: convert ag5evm to use the generic MMC G=
PIO hotplug helper
> >> =A0 =A0 =A0ARM: mach-shmobile: convert mackerel to use the generic MMC=
 GPIO hotplug helper
> >
> > These seem to fix the long-standing build errors on the two platforms,
> > but that's impossible to tell from reading the commit messages (they
> > are empty). Care to add one describing why they're important to go in?
>=20
> I only know that a) some boards don't build without these fixes and b)
> they used to build just fine.
>=20
> Perhaps Guennadi [CC:ed] could be so kind to fill us in with the blanks?

Yes, they do fix modular mmc build on the two respective platforms.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
