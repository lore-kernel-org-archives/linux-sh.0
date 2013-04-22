From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Apr 2013 05:36:59 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: r8a7778: add GPIO support
Message-Id: <20130422053655.GD16026@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvyos5ob.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvyos5ob.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 18, 2013 at 10:41:16PM +0900, Simon Horman wrote:
> On Thu, Apr 18, 2013 at 12:05:50AM -0700, Kuninori Morimoto wrote:
> > 
> > Hi Simon again
> > 
> > these are based on renesas-next-20130417 tags
> > 
> > > These patches add GPIO support for R8A7778
> > > I tested these patches on Bock-W board.
> > > 
> > > When I tested GPIO-IRQ, I used SMSC (by local-hack, I don't send it to ML).
> > > Current SMSC is using IRQ0 (= Function1 of GPIO(1, 12) pin) interrupt now,
> > > then, I put this pin as "GPIO" and "interrupt mode".
> > > It works well for me
> > > 
> > > Kuninori Morimoto (3):
> > >       gpio-rcar: R-Car GPIO IRQ share interrupt
> > >       ARM: shmobile: add GPIO IRQ macro
> > >       ARM: shmobile: r8a7778: add GPIO support
> > > 
> > >  arch/arm/mach-shmobile/include/mach/irqs.h |    5 ++++
> > >  arch/arm/mach-shmobile/setup-r8a7778.c     |   36 +++++++++++++++++++++++++++-
> > >  drivers/gpio/gpio-rcar.c                   |    2 +-
> > >  3 files changed, 41 insertions(+), 2 deletions(-)
> 
> Thanks Morimoto-san,
> 
> these patches seem reasonable to me.
> 
> Magnus, as this driver is your work could you review these changes?

I have queued-up this series for v3.11.

"gpio-rcar: R-Car GPIO IRQ share interrupt" is queued-up
in the gpio-rcar branch.

"ARM: shmobile: add GPIO IRQ macro" is queued-up
in the soc-common branch.

I have merged the soc-common branch into the soc-r8a7778 branch
and queued-up "ARM: shmobile: r8a7778: add GPIO support" there.
