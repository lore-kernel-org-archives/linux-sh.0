From: "Mangalampalli, JayantX" <jayantx.mangalampalli@intel.com>
Date: Tue, 26 May 2009 23:24:00 +0000
Subject: RE: [PATCH] sched: Support current clocksource handling in fallback
Message-Id: <68887236814FB54BBC1D0E0556DD510D4CCB0F09E2@orsmsx509.amr.corp.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090526061532.GD9188@linux-sh.org>
	 <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>
	 <1243348681.23657.14.camel@twins>  <1243369423.3275.5.camel@localhost>
	 <1243369815.6600.2.camel@laptop>  <1243370439.3275.13.camel@localhost>
	 <1243371309.6600.8.camel@laptop> <1243378835.3275.30.camel@localhost>
In-Reply-To: <1243378835.3275.30.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: john stultz <johnstul@us.ibm.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, John Stultz <johnstul@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

Isn't rdtsc inherently dependent on CPU tick rate, which is somewhat variable? Shouldn't HPET be more reliable? Or can constant_tsc be relied on for important things like scheduler?

Thanks
Jayant

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of john stultz
Sent: Tuesday, May 26, 2009 4:01 PM
To: Peter Zijlstra
Cc: Linus Walleij; Paul Mundt; Ingo Molnar; Andrew Victor; Haavard Skinnemoen; Andrew Morton; linux-kernel@vger.kernel.org; linux-sh@vger.kernel.org; linux-arm-kernel@lists.arm.linux.org.uk; John Stultz; Thomas Gleixner
Subject: Re: [PATCH] sched: Support current clocksource handling in fallback sched_clock().

On Tue, 2009-05-26 at 22:55 +0200, Peter Zijlstra wrote:
> On Tue, 2009-05-26 at 13:40 -0700, john stultz wrote:
> > On Tue, 2009-05-26 at 22:30 +0200, Peter Zijlstra wrote:
> > > On Tue, 2009-05-26 at 13:23 -0700, john stultz wrote:
> > > > Overall, I'd probably suggest thinking this through a bit more. At some
> > > > point doing this right will cause sched_clock() to be basically the same
> > > > as ktime_get(). So why not just use that instead of remaking it?
> > > 
> > > simply because we don't require the strict global monotonicy for
> > > scheduling as we do from a regular time source (its nice to have
> > > though).
> > > 
> > > That means that on x86 we can always use TSC for sched_clock(), even
> > > when its quite unsuitable for ktime.
> > 
> > Right, but I guess what I'm asking is can this be a bit better defined? 
> > 
> > If we are going to use clocksources (or cyclecounters - an area I need
> > to clean up soon), it would be good to get an idea of what is expected
> > of the sched_clock() interface.
> > 
> > So TSC good, HPET bad. Why? 
> 
> Because TSC is a few cycles to read, and you can factorize a largish
> prime while doing an HPET read :-)
> 
> > Is latency all we care about? How bad would
> > the TSC have to be before we wouldn't want to use it?
> 
> Anything better than jiffies ;-)

Except HPET thought, right? :)

> For sched_clock() we want something high-res that is monotonic per cpu
> and has a bounded drift between cpus in the order of jiffies.
> 
> Look at kernel/sched_clock.c for what we do to make really shitty TSC
> conform to the above requirements.

Sure, I guess what I'm trying to pull out here is that should we try to
create some OK_FOR_SCHED_CLOCK flag for clocksources, and then we try to
make this generic so other arches can add that flag and be done, what is
the guidance we want to give to arch maintainers for setting that flag?

1) Has to be very very fast. Can we put a number on this? 50ns to read?

2) How long does it have to be monotonic for? Is it ok if it wraps every
few seconds?

If get_cycles() || jiffies is what we want, then lets leave it there. I
just want to avoid mixing the clocksource code into the sched clock code
until we really get this sort of definition sorted.

thanks
-john


--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
