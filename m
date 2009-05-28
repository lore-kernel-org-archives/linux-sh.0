From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 28 May 2009 12:40:16 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in
Message-Id: <1243514416.6600.74.camel@laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <20090526061532.GD9188@linux-sh.org>
	 <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>
	 <1243348681.23657.14.camel@twins>
	 <alpine.LFD.2.00.0905262209160.1762@localhost.localdomain>
	 <20090526230855.GA27218@linux-sh.org>
	 <alpine.LFD.2.00.0905270140030.1762@localhost.localdomain>
	 <20090527001543.GA8493@linux-sh.org> <1243441525.28705.19.camel@desktop>
	 <20090528091936.GA27545@linux-sh.org> <1243503281.23657.80.camel@twins>
	 <20090528110902.GA27884@linux-sh.org>
	 <alpine.LFD.2.00.0905281417500.3397@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0905281417500.3397@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul Mundt <lethal@linux-sh.org>, Daniel Walker <dwalker@fifo99.com>, Linus Walleij <linus.ml.walleij@gmail.com>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, John Stultz <johnstul@linux.vnet.ibm.com>

On Thu, 2009-05-28 at 14:22 +0200, Thomas Gleixner wrote:
> On Thu, 28 May 2009, Paul Mundt wrote:
> > @@ -437,10 +441,19 @@ void clocksource_unregister(struct clocksource *cs)
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&clocksource_lock, flags);
> > +
> > +	if (sched_clocksource = cs) {
> > +		printk(KERN_WARNING "Refusing to unregister "
> > +		       "scheduler clocksource %s", cs->name);
> 
>   Hmm, isn't that dangerous ? The clocksource might be in a module or
>   in kmalloced memory which is going to be freed.

One could play dirty tricks with 'leaking' module ref counts and such so
as to avoid that. The alternative is making sched_clock() look something
like:

u64 __weak sched_clock(void)
{
  struct clocksource *clock;
  u64 time;

  rcu_read_lock();
  clock = rcu_dereference(sched_clocksource);
  time = cyc2ns(clock, read_clocksource(clock));
  rcu_read_unlock;

  return time;
}

and make the module unload do a sync_rcu -- but this might be a little
overkill

