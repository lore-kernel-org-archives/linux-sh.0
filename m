From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 26 May 2009 20:39:42 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in fallback
Message-Id: <alpine.LFD.2.00.0905262233560.1762@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20090526061532.GD9188@linux-sh.org>  <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>  <1243348681.23657.14.camel@twins> <1243369423.3275.5.camel@localhost>
In-Reply-To: <1243369423.3275.5.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john stultz <johnstul@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, John Stultz <johnstul@linux.vnet.ibm.com>

On Tue, 26 May 2009, john stultz wrote:

> On Tue, 2009-05-26 at 16:38 +0200, Peter Zijlstra wrote:
> > Added the generic clock and timer folks to CC.
> > 
> > On Tue, 2009-05-26 at 16:31 +0200, Linus Walleij wrote:
> > > 2009/5/26 Paul Mundt <lethal@linux-sh.org>:
> > > 
> > > >  */
> > > >  unsigned long long __attribute__((weak)) sched_clock(void)
> > > >  {
> > > > +       /*
> > > > +        * Use the current clocksource when it becomes available later in
> > > > +        * the boot process, and ensure that it has a high enough rating
> > > > +        * to make it suitable for general use.
> > > > +        */
> > > > +       if (clock && clock->rating >= 100)
> > > > +               return cyc2ns(clock, clocksource_read(clock));
> 
> I'm not super familiar with the recent sched_clock changes, but how will
> this work if the clocksource wraps (ACPI PM wraps every 2-5 seconds).

You don't want to use ACPI PM for sched_clock, never ever.
 
> Also there's no locking here, so the clocksource could change under you.
> 
> Further, checking for rating being greater then 100 really doesn't mean
> anything. Probably need to check if the clocksource is continuous
> instead.

I'd like to have an explicit flag for this, so we can avoid that stuff
like pmtimer and other slow access clock sources are used.
 
> Overall, I'd probably suggest thinking this through a bit more. At some
> point doing this right will cause sched_clock() to be basically the same
> as ktime_get(). So why not just use that instead of remaking it?

ktime_get() involves xtime lock and the scheduler does not care about
a slightly wrong value. sched_clock does not have the accuracy
requirements of time keeping,

If we have an explicit flag we can replace lots of arch/embedded
sched_clock implementations with a generic one which is a Good Thing.

There is a world beside the broken x86 timers :)

Thanks,

	tglx
