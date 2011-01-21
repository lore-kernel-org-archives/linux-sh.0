From: Nicolas Pitre <nico@fluxnic.net>
Date: Fri, 21 Jan 2011 23:50:06 +0000
Subject: Re: Locking in the clk API
Message-Id: <alpine.LFD.2.00.1101211833080.8580@xanadu.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary_(ID_UFWoRoUh6Pn/9Q/tBN7Yhw)"
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org> <4D3862DB.5000708@fluff.org>
	<20110120185617.GI6335@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101201623480.8580@xanadu.home>
	<AANLkTimwBruVgGQWs5NQG7U3PcF6RQHZ6Pd1hjxyGpcA@mail.gmail.com>
	<4D3907BD.4040900@codeaurora.org>
	<AANLkTik53zyXytvuAd5zK0_zExfQT3FmOgTr8BexmGeT@mail.gmail.com>
	<alpine.LFD.2.00.1101211618170.8580@xanadu.home>
	<20110121220238.GE23151@n2100.arm.linux.org.uk>
	<AANLkTimT+vfg9p4GSnn1jGW9r_gVom7xEUzMVJDscPg2@mail.gmail.com>
In-Reply-To: <AANLkTimT+vfg9p4GSnn1jGW9r_gVom7xEUzMVJDscPg2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_UFWoRoUh6Pn/9Q/tBN7Yhw)
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jan 2011, Colin Cross wrote:

> On Fri, Jan 21, 2011 at 2:02 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jan 21, 2011 at 04:53:44PM -0500, Nicolas Pitre wrote:
> >> So I think that the API must be augmented with more methods, such as:
> >>
> >> clk_slow_enable():
> >> =A0 - may sleep
> >> =A0 - may be a no-op if the clk_fast_enable() is supported
> >>
> >> clk_fast_enable():
> >> =A0 - may not sleep, used in atomic context
> >> =A0 - may be a no-op if controlling the clock takes time, in which case
> >> =A0 =A0 clk_slow_enable() must have set the clock up entirely
> >>
> >> ... and similar for clk_slow_disable() and clk_fast_disable().
> >
> > Isn't this along the same lines as my clk_prepare() vs clk_enable()
> > suggestion?
> >
> > I suggested that clk_prepare() be callable only from non-atomic context=
s,
> > and do whatever's required to ensure that the clock is available. =A0Th=
at
> > may end up enabling the clock as a result.
> >
> > clk_enable() callable from atomic contexts, and turns the clock on if
> > the hardware supports such an operation.
> >
> > So, if you have something like:
> >
> > Xtal--->PLL--->Routing/Masking--->Device
> >
> > clk =3D clk_get() returns the clock for the device.
> >
> > clk_prepare(clk) would walk up the clock tree, selecting the routing and
> > preparing each clock. =A0Clocks prior to _and_ including the PLL would =
need
> > to be enabled.
> >
> > clk_enable(clk) would walk up the tree if the clock isn't already enabl=
ed,
> > calling clk_enable() on the parent clock. =A0As we require prepared clo=
cks
> > to already be enabled, this automatically stops at the PLL.
> >
> > To encourage correct usage, we just need to make sure that clk_prepare()
> > has a might_sleep() thing, and clk_enable() throws a fit if it's used
> > on a clk without prepare being used first. =A0The second point is not e=
asy
> > to do in a foolproof manner though, but doing _something_ is better than
> > nothing.
>=20
> I like this proposal, and I prefer the clk_prepare naming over
> clk_slow_enable - too many people would call clk_slow_enable instead
> of, and not as well as, clk_fast_enable.

I do prefer those names too.  My clk_slow/fast_enable() was just an=20
example for illustration purpose.

> On Tegra, I currently use the ugly conditional mutex or spinlock
> method to deal with voltage scaling based on clock frequency.  Clocks
> that have a voltage dependency, or depend on a clock that has a
> voltage dependency, are non-atomic, everything else is atomic.  PLLs
> are atomic because they lock very fast (300 uS or 1ms) and are shared
> by so many clocks that they realistically don't get turned off very
> often, and if I made them non-atomic, all clocks would be non-atomic.

That's of course implementation details.  The API should define purpose,=20
and then you get to decide how your hardware will behave.  If you=20
consider that 300us is short enough to busy wait for, and that the=20
likelyhood for that PLL to be disabled is low, then you can make it into=20
the clk_enable() and make clk_prepare() empty.  But if you are going to=20
use a driver with aggressive power saving through frequent usage of=20
clk_enable()/clk_disable() then it is probably best to lock the PLLs in=20
clk_prepare() instead.


Nicolas

--Boundary_(ID_UFWoRoUh6Pn/9Q/tBN7Yhw)--
