From: john stultz <johnstul@us.ibm.com>
Date: Tue, 26 May 2009 20:40:39 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in
Message-Id: <1243370439.3275.13.camel@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <20090526061532.GD9188@linux-sh.org>
	 <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>
	 <1243348681.23657.14.camel@twins>  <1243369423.3275.5.camel@localhost>
	 <1243369815.6600.2.camel@laptop>
In-Reply-To: <1243369815.6600.2.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, John Stultz <johnstul@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, 2009-05-26 at 22:30 +0200, Peter Zijlstra wrote:
> On Tue, 2009-05-26 at 13:23 -0700, john stultz wrote:
> > Overall, I'd probably suggest thinking this through a bit more. At some
> > point doing this right will cause sched_clock() to be basically the same
> > as ktime_get(). So why not just use that instead of remaking it?
> 
> simply because we don't require the strict global monotonicy for
> scheduling as we do from a regular time source (its nice to have
> though).
> 
> That means that on x86 we can always use TSC for sched_clock(), even
> when its quite unsuitable for ktime.

Right, but I guess what I'm asking is can this be a bit better defined? 

If we are going to use clocksources (or cyclecounters - an area I need
to clean up soon), it would be good to get an idea of what is expected
of the sched_clock() interface.

So TSC good, HPET bad. Why? Is latency all we care about? How bad would
the TSC have to be before we wouldn't want to use it?

thanks
-john


