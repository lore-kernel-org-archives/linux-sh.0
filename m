From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 31 May 2011 04:04:44 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Runtime PM support
Message-Id: <20110531040444.GA1745@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110425134026.4249.13858.sendpatchset@t400s> <20110523083005.GA11986@linux-sh.org>
In-Reply-To: <20110523083005.GA11986@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, linux-sh@vger.kernel.org

On Mon, May 23, 2011 at 05:30:06PM +0900, Paul Mundt wrote:
> On Mon, Apr 25, 2011 at 10:40:26PM +0900, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Add Runtime PM support to the TMU driver.
> > 
[snip]
> > 
> > +	/* wake up device and enable clock */
> > +	pm_runtime_get_sync(&p->pdev->dev);
> >  	ret = clk_enable(p->clk);
> >  	if (ret) {
> >  		dev_err(&p->pdev->dev, "cannot enable clock\n");
> > +		pm_runtime_put_sync(&p->pdev->dev);
> >  		return ret;
> >  	}
> >  
> At this point the spinlock hasn't been initialized yet, so any of the
> pm_runtime calls are pretty much unsafe. We could manually test
> pm_runtime_enabled() before any of the get/put_sync() calls, but that gets to
> be a bit ugly.

Note that I will be reverting these patches for -rc2 if no progress is
made here. This is a fundamental ordering issue with regards to locking,
and is completely bogus for every SMP platform we have.
