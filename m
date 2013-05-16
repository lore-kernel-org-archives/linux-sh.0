From: Simon Horman <horms@verge.net.au>
Date: Thu, 16 May 2013 01:05:16 +0000
Subject: Re: marzen-reference doesn't boot with CONFIG_PREEMPT
Message-Id: <20130516010516.GB12368@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <4961084.Cgj9yMUAgI@avalon>
In-Reply-To: <4961084.Cgj9yMUAgI@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[ Cc Magnus ]

On Wed, May 15, 2013 at 01:30:26PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 15 May 2013 12:47:16 Simon Horman wrote:
> > On Wed, May 15, 2013 at 10:29:42AM +0900, Simon Horman wrote:
> > > On Wed, May 15, 2013 at 03:05:18AM +0200, Laurent Pinchart wrote:
> > > > On Wednesday 15 May 2013 09:23:59 Simon Horman wrote:
> > > > > On Tue, May 14, 2013 at 09:08:07PM +0200, Laurent Pinchart wrote:
> > > > > > But marzen does (renesas-next-20130513). Is that a known issue ?
> > > > > 
> > > > > No, I was not aware of that.
> > > > > 
> > > > > I would suspect, based on work on the kzm9g, that the problem
> > > > > relates to driver initialisation order. In the case of kzm9g
> > > > > my recollection is that the problem was resolved by initialising
> > > > > clocksources earlier by changing their initcall level.
> > > > 
> > > > Did that reach mainline ? I've tried booting kzm9g-reference with
> > > > CONFIG_PREEMPT and have been unable to boot it as well with renesas-
> > > > next-20130513. Maybe we should enable CONFIG_PREEMPT by default to catch
> > > > similar issues in the future.
> > > 
> > > It made it into 3.10-rc1 and has been in next for a while now.
> > > So it seems that you have found a different problem.
> > > 
> > > I'm ambivalent to setting CONFIG_PREEMPT by default.
> > 
> > Hi Laurent,
> > 
> > I have not been able to pin-point the cause of this problem nor come up with
> > a fix. However, it does seem to be related to the early initialisation of
> > devices and the following work around does allow booting marzen-reference
> > with CONFIG_PREEMPT.
> 
> Thank you for the workaround. What prevents this patch (or a similar patch, as 
> it seems the SCIF and TMU devices would be instantiated twice) from being 
> applied to mainline ? Do we have a plan regarding what code we want to keep in 
> mach-shmobile and what we want to move to DT ?

Magnus has indicated several times that he would like to avoid
using early timers and devices unless they are absolutely necessary.
So it seems that this issue should be investigated more thoroughly before
pushing this workaround into mainline.

> 
> > diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c
> > b/arch/arm/mach-shmobile/board-marzen-reference.c index f83b6d1..ac24cd7
> > 100644
> > --- a/arch/arm/mach-shmobile/board-marzen-reference.c
> > +++ b/arch/arm/mach-shmobile/board-marzen-reference.c
> > @@ -72,10 +72,11 @@ void __init marzen_init_irq(void)
> >  DT_MACHINE_START(MARZEN, "marzen")
> >  	.smp		= smp_ops(r8a7779_smp_ops),
> >  	.map_io		= r8a7779_map_io,
> > -	.init_early	= r8a7779_init_delay,
> > +	.init_early	= r8a7779_add_early_devices,
> >  	.nr_irqs	= NR_IRQS_LEGACY,
> >  	.init_irq	= marzen_init_irq,
> >  	.init_machine	= marzen_init,
> >  	.init_time	= shmobile_timer_init,
> >  	.dt_compat	= marzen_boards_compat_dt,
> > +	.init_time      = r8a7779_earlytimer_init,
> >  MACHINE_END
> -- 
> Regards,
> 
> Laurent Pinchart
> 
