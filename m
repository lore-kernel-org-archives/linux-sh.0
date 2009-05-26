From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 26 May 2009 14:38:01 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in
Message-Id: <1243348681.23657.14.camel@twins>
List-Id: <linux-sh.vger.kernel.org>
References: <20090526061532.GD9188@linux-sh.org>
	 <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>
In-Reply-To: <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, John Stultz <johnstul@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

Added the generic clock and timer folks to CC.

On Tue, 2009-05-26 at 16:31 +0200, Linus Walleij wrote:
> 2009/5/26 Paul Mundt <lethal@linux-sh.org>:
> 
> >  */
> >  unsigned long long __attribute__((weak)) sched_clock(void)
> >  {
> > +       /*
> > +        * Use the current clocksource when it becomes available later in
> > +        * the boot process, and ensure that it has a high enough rating
> > +        * to make it suitable for general use.
> > +        */
> > +       if (clock && clock->rating >= 100)
> > +               return cyc2ns(clock, clocksource_read(clock));
> > +
> > +       /* Otherwise just fall back on jiffies */
> >        return (unsigned long long)(jiffies - INITIAL_JIFFIES)
> >                                        * (NSEC_PER_SEC / HZ);
> >  }
> 
> This seems like it would make the patch I sent the other day
> unnecessary (subject u300 sched_clock() implementation).
> 
> It would also trim off this solution found in all OMAP platforms in
> arch/arm/plat-omap/common.c
> 
> BUT Peter Zijlstra replied to my question about why this wasn't
> generic with:
> 
> [peterz]:
> > But that is the reason this isn't generic, non of the 'stable'
> > clocksources on x86 are fast enough to use as sched_clock.
> 
> Does that mean clock->rating for these clocksources is
> for certain < 100?
> 
> The definition of "rating" from the kerneldoc does not
> seem to imply that, it's a subjective measure AFAICT.
> 
> Else you might want an additional criteria, like
> cyc2ns(1) (much less than) jiffies_to_usecs(1)*1000
> (however you do that the best way)
> so you don't pick something
> that isn't substantially faster than the jiffy counter atleast?




