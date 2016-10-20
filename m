From: Rich Felker <dalias@libc.org>
Date: Thu, 20 Oct 2016 15:15:52 +0000
Subject: Re: [PATCH v9 0/2] J-Core timer support
Message-Id: <20161020151552.GQ19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1476393790.git.dalias@libc.org>
 <20161017093013.GA1703@mai>
 <20161020012225.GK19318@brightrain.aerifal.cx>
 <20161020073240.GF1703@mai>
In-Reply-To: <20161020073240.GF1703@mai>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Oct 20, 2016 at 09:32:40AM +0200, Daniel Lezcano wrote:
> On Wed, Oct 19, 2016 at 09:22:25PM -0400, Rich Felker wrote:
> > On Mon, Oct 17, 2016 at 11:30:13AM +0200, Daniel Lezcano wrote:
> > > On Thu, Oct 13, 2016 at 09:51:06PM +0000, Rich Felker wrote:
> > > > This version of the patch makes the changes requested by Daniel
> > > > Lezcano in review of v8.
> > > > 
> > > > Rich Felker (2):
> > > >   of: add J-Core timer bindings
> > > >   clocksource: add J-Core timer/clocksource driver
> > > > 
> > > >  .../devicetree/bindings/timer/jcore,pit.txt        |  24 ++
> > > >  drivers/clocksource/Kconfig                        |  10 +
> > > >  drivers/clocksource/Makefile                       |   1 +
> > > >  drivers/clocksource/jcore-pit.c                    | 249 +++++++++++++++++++++
> > > >  include/linux/cpuhotplug.h                         |   1 +
> > > >  5 files changed, 285 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/timer/jcore,pit.txt
> > > >  create mode 100644 drivers/clocksource/jcore-pit.c
> > > 
> > > Hi Rich,
> > > 
> > > I applied your patches on my tree.
> > > 
> > > Thanks !
> > 
> > Thanks! Which is your current tree? 
> 
> http://git.linaro.org/people/daniel.lezcano/linux.git clockevents/4.10
> 
> > I was looking and couldn't find
> > it. This is the one thing (and it's a boot blocker) keeping Linux on
> > J2 from working out of the box and I'd really love to see it go in
> > 4.9.
> 
> Unfortunately it won't happen. v4.9-rc1 is already out. The driver will be
> in v4.10.
> 
> If you wanted patches merged for v4.9, they should have been merged in the
> downstream tree before v4.8-rc5, so they hit the upstream tree for v4.9's merge
> window.

I've been trying to get what's essentially the same patch merged since
before the 4.8 merge window. I would be more understanding if this
were something new that's not upstream, but broken support for the
hardware (that, from a user perspective, is a bug, since they can
select the target but then it doesn't boot) has already been in one
release due to missing core drivers, and the irq patches have already
been merged in this release (post-rc1 even).

Rich
