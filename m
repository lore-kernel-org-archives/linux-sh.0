From: Rich Felker <dalias@libc.org>
Date: Fri, 08 Jan 2016 18:21:45 +0000
Subject: Re: [PATCH 2/2] MAINTAINERS: remove linux-sh list from non-arch/sh sections
Message-Id: <20160108182145.GA22240@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20160108043907.GA7005@brightrain.aerifal.cx>
 <20160108044054.GA7130@brightrain.aerifal.cx>
 <20160108065642.GA1215@verge.net.au>
 <CAMuHMdXkK68wM0D2-auNskSDv2ni6R4GabA90We8PbYXikO9Pw@mail.gmail.com>
In-Reply-To: <CAMuHMdXkK68wM0D2-auNskSDv2ni6R4GabA90We8PbYXikO9Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uclinux.org>, Rob Landley <rob@landley.net>

On Fri, Jan 08, 2016 at 10:01:25AM +0100, Geert Uytterhoeven wrote:
> > Dropping linux-sh@vger.kernel.org from portions of the MAINTAINERS file=
 as
> > you suggest would essentially leave the Renesas ARM work without a mail=
ing
> > list or patchwork instance. Both of which are actively used for that wo=
rk..
> >
> > Off-hand I can think of three solutions to this problem:
> >
> > 1. Live with the noise
> > 2. Establish a new list (and possibly patchwork instance) for the SH wo=
rk..
> > 3. Establish a new list and patchwork instance for the ARM work.
>=20
> Personally, I'd go for option 1.
> I would even like to propose H8/300 to join, as they share IP cores, too
> (m32r doesn't, AFAIK).
>=20
> Many old ARM/SH-Mobile SoCs look like SH SoCs with an ARM CPU core bolted=
 on.
> Recent Renesas ARM SoCs still share many IP cores with older SH SoCs; mos=
t of
> them even have a secondary SH4 CPU core. Using the SH4 CPU core could be =
useful
> for doing SH4 work, until J4 becomes mainstream (cfr. old prototype in
> http://www.spinics.net/lists/linux-sh/msg07188.html).
> Probably the Jx series won't share IP cores with SH/ARM, but as arch/sh/
> maintainers you have to care about older Renesas SH platforms, too.
>=20
> For patchwork, that would mean some more delegation needs to be put in pl=
ace.
>=20
> So far my 0.05=E2=82=AC...

Is that actually the case? I can't find any current support in the
kernel for running on these SH4 cores, and I was under the impression
that they were being phased out, if not already gone. And the bulk of
the driver-related discussion I've seen on linux-sh over the past year
does not seem to be related to hardware that's present/usable on
boards where you can run Linux/SH. If this is incorrect, I'd like to
hear some views on how/why such hardware is relevant to arch/sh.

Rich
