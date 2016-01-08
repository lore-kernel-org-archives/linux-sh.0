From: Rich Felker <dalias@libc.org>
Date: Fri, 08 Jan 2016 20:52:21 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <20160108205221.GN238@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108044054.GA7130@brightrain.aerifal.cx>
 <20160108065642.GA1215@verge.net.au>
 <CAMuHMdXkK68wM0D2-auNskSDv2ni6R4GabA90We8PbYXikO9Pw@mail.gmail.com>
 <20160108182145.GA22240@brightrain.aerifal.cx>
 <CAMuHMdWkwXkFu6Uf-yYr7GiNc7OCvHXYPKGpOE7QhHY56F2rug@mail.gmail.com>
In-Reply-To: <CAMuHMdWkwXkFu6Uf-yYr7GiNc7OCvHXYPKGpOE7QhHY56F2rug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>, Rob Landley <rob@landley.net>

On Fri, Jan 08, 2016 at 09:35:11PM +0100, Geert Uytterhoeven wrote:
> Hi Rich,
>=20
> On Fri, Jan 8, 2016 at 7:21 PM, Rich Felker <dalias@libc.org> wrote:
> > On Fri, Jan 08, 2016 at 10:01:25AM +0100, Geert Uytterhoeven wrote:
> >> Many old ARM/SH-Mobile SoCs look like SH SoCs with an ARM CPU core bol=
ted on.
> >> Recent Renesas ARM SoCs still share many IP cores with older SH SoCs; =
most of
> >> them even have a secondary SH4 CPU core. Using the SH4 CPU core could =
be useful
> >> for doing SH4 work, until J4 becomes mainstream (cfr. old prototype in
> >> http://www.spinics.net/lists/linux-sh/msg07188.html).
> >> Probably the Jx series won't share IP cores with SH/ARM, but as arch/s=
h/
> >> maintainers you have to care about older Renesas SH platforms, too.
> >>
> >> For patchwork, that would mean some more delegation needs to be put in=
 place.
> >>
> >> So far my 0.05=E2=82=AC...
> >
> > Is that actually the case? I can't find any current support in the
> > kernel for running on these SH4 cores, and I was under the impression
> > that they were being phased out, if not already gone. And the bulk of
>=20
> There's no in-kernel support for these SH4 cores yet, just the prototype.

OK. Are they presently just running (non-Linux) firmware provided with
the boards? Or not being used at all? Also, is it correct that they're
all SH4, not SH5? I know on the gcc side there's interest in removing
SH5 support, and I'd probably like to do the same in the kernel if
it's not being used.

> > the driver-related discussion I've seen on linux-sh over the past year
> > does not seem to be related to hardware that's present/usable on
> > boards where you can run Linux/SH. If this is incorrect, I'd like to
> > hear some views on how/why such hardware is relevant to arch/sh.
>=20
> At least the following drivers are shared between ARM and SH:
>=20
> hspi
> rspi
> sh-cmt
> sh_fsi
> sh-mtu2
> sh-sci (covering sci, scif, scifa, scifb, hscif)
> sh-tmu
> tpu
>=20
> and of course the sh-pfc pinctrl subsystem.

Thanks for making this list.

> Probably I'm forgetting a few that haven't been converted to DT on ARM ye=
t,
> and where the ARM side thus could benefit from a DT conversion on SH.

That would be nice.

> Note that you can find "shmobile" SoCs under both arch/sh/
> (sh7723/sh7724/sh7343/sh7722/sh7366) and arch/arm/mach-shmobile/.
> Some of these used to share even more code (e.g. drivers/sh/clk/), until =
the
> ARM ones were converted to the Common Clock Framework.

Do you know how much is involved in converting the SH ones over to
Common Clock Framework? That seems to be one obstacle for full DT
conversion that supports the old boards.

Rich
