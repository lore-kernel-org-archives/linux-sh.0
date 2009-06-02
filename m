From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 02 Jun 2009 20:21:23 +0000
Subject: Re: [PATCH] sched: sched_clock() clocksource handling.
Message-Id: <alpine.LFD.2.00.0906022218070.3419@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20090602071718.GA17710@linux-sh.org>  <1243927502.23657.5619.camel@twins> <20090602073515.GB17710@linux-sh.org>  <1243928495.23657.5642.camel@twins>  <20090602075409.GA19294@linux-sh.org> <1243943366.6592.434.camel@desktop>
In-Reply-To: <1243943366.6592.434.camel@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Walker <dwalker@fifo99.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Linus Walleij <linus.ml.walleij@gmail.com>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <johnstul@linux.vnet.ibm.com>, linux-arm-kernel@lists.arm.linux.org.uk, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2 Jun 2009, Daniel Walker wrote:
> On Tue, 2009-06-02 at 16:54 +0900, Paul Mundt wrote:
> >  unsigned long long __attribute__((weak)) sched_clock(void)
> >  {
> > -       return (unsigned long long)(jiffies - INITIAL_JIFFIES)
> > -                                       * (NSEC_PER_SEC / HZ);
> > +       unsigned long long time;
> > +       struct clocksource *clock;
> > +
> > +       rcu_read_lock();
> > +       clock = rcu_dereference(sched_clocksource);
> > +       time = cyc2ns(clock, clocksource_read(clock));
> > +       rcu_read_unlock();
> > +
> > +       return time;
> >  }
> 
> My concerns with the locking here still stand. Nothing you've said or
> done bolsters the clocksource in modules argument. I think what your

Can you please stop to belabor modules? Again, it is totally
_irrelevant_ whether the clocksource is in a module or not.

unregister_clocksource() can be called from compiled in code as well
to replace a clocksource which is physically shut down. We have to
deal with that modules or not.

Thanks,

	tglx
