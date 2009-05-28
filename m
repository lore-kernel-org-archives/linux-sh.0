From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 28 May 2009 18:44:28 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in fallback
Message-Id: <alpine.LFD.2.00.0905282041460.3397@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20090528110902.GA27884@linux-sh.org>  <alpine.LFD.2.00.0905281417500.3397@localhost.localdomain>  <20090528124207.GA28830@linux-sh.org> <1243515570.6600.96.camel@laptop>  <1243527218.28705.35.camel@desktop> <1243528329.6645.77.camel@laptop> 
 <20090528164011.GA30104@linux-sh.org> <1243529547.28705.43.camel@desktop>  <20090528165816.GA31688@linux-sh.org> <1243532324.28705.75.camel@desktop>  <20090528175341.GA32118@linux-sh.org> <1243534252.28705.86.camel@desktop>
In-Reply-To: <1243534252.28705.86.camel@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Walker <dwalker@fifo99.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Peter Zijlstra <peterz@infradead.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, John Stultz <johnstul@linux.vnet.ibm.com>

On Thu, 28 May 2009, Daniel Walker wrote:
> On Fri, 2009-05-29 at 02:53 +0900, Paul Mundt wrote:
> 
> > As I already stated, yes.
> > 
> > We have multiple clock sources for most CPUs. These can be set up in any
> > sort of configuration, and there are pros and cons to using different
> > ones. The ones that are available can in turn be cycled between. I don't
> > know what exactly is difficult to understand about this.
> 
> I understand that cpu's can have multiple clocks, that's not a hard concept to grasp.
> 
> > Yes, we want to be able to use modular clocksources. The only reason we
> > don't right now is because some more preparatory work is needed first.
> > Any attempt to remove support for modular clocksources means we will just
> > have to add it in back later.
> 
> This is what's difficult to understand.. You have multiple clocks ok,
> fine.. You have multiple clocks that you want the kernel to switch
> between, ok that's fine too.. What's missing is the case where
> clocksource modules being loaded/unload via the user becomes a valuable
> use case..

Did you actually read what people wrote ? This is not about modules or
not, it's about safe switching of clocksources when they are used for
sched_clock as well.
 
> If you have a valuable use case for that, fine, I won't stand in the
> way ..

Sigh,

	tglx
