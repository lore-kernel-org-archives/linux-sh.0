From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 31 May 2011 06:22:22 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Runtime PM support
Message-Id: <20110531062222.GD1745@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110425134026.4249.13858.sendpatchset@t400s> <20110523083005.GA11986@linux-sh.org> <20110531040444.GA1745@linux-sh.org>
In-Reply-To: <20110531040444.GA1745@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

On Tue, May 31, 2011 at 01:04:44PM +0900, Paul Mundt wrote:
> On Mon, May 23, 2011 at 05:30:06PM +0900, Paul Mundt wrote:
> > On Mon, Apr 25, 2011 at 10:40:26PM +0900, Magnus Damm wrote:
> > > From: Magnus Damm <damm@opensource.se>
> > > 
> > > Add Runtime PM support to the TMU driver.
> > > 
> [snip]
> > > 
> > > +	/* wake up device and enable clock */
> > > +	pm_runtime_get_sync(&p->pdev->dev);
> > >  	ret = clk_enable(p->clk);
> > >  	if (ret) {
> > >  		dev_err(&p->pdev->dev, "cannot enable clock\n");
> > > +		pm_runtime_put_sync(&p->pdev->dev);
> > >  		return ret;
> > >  	}
> > >  
> > At this point the spinlock hasn't been initialized yet, so any of the
> > pm_runtime calls are pretty much unsafe. We could manually test
> > pm_runtime_enabled() before any of the get/put_sync() calls, but that gets to
> > be a bit ugly.
> 
> Note that I will be reverting these patches for -rc2 if no progress is
> made here. This is a fundamental ordering issue with regards to locking,
> and is completely bogus for every SMP platform we have.

Furthermore, I'm not convinced there's any sane way to support this
without further help from the runtime PM framework.

We can't even do a pm_runtime_enabled() check in the case of the early
platform devices because that assumes pm_runtime_init() has been run, and
if that were true, the spinlock would have already been initialized.

As it is now there is simply no sane way to have dev->power.lock
initialized and any of these pm_runtime_xxx() calls made safe via the
early timer path.

If pm_runtime_get/put_sync() and friends were modified to be no-ops or
simply toggle some refcount that could later be inherited by the
framework at late initialization time, then we could support this sort of
multiple entry via early and late probe stages that the early platform
devices depend on, but it's completely bogus otherwise.

As it is now this completely breaks SMP, which is not acceptable. It's
obvious this needs a bit more of a think and there's no easy or clean way
to hack around this in the driver without further framework changes, so
I'll be reverting the runtime PM changes for the TMU and CMT drivers.

They can be trivially re-added once the ordering issues have been
resolved (perhaps a good topic for the runtime PM BoF on friday?)
