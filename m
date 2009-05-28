From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 28 May 2009 17:00:30 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in fallback
Message-Id: <alpine.LFD.2.00.0905281857420.3397@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527001543.GA8493@linux-sh.org>  <1243441525.28705.19.camel@desktop> <20090528091936.GA27545@linux-sh.org>  <1243503281.23657.80.camel@twins> <20090528110902.GA27884@linux-sh.org>  <alpine.LFD.2.00.0905281417500.3397@localhost.localdomain>
  <20090528124207.GA28830@linux-sh.org> <1243515570.6600.96.camel@laptop>  <1243527218.28705.35.camel@desktop> <1243528329.6645.77.camel@laptop>  <20090528164011.GA30104@linux-sh.org> <1243529547.28705.43.camel@desktop>
In-Reply-To: <1243529547.28705.43.camel@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Walker <dwalker@fifo99.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Peter Zijlstra <peterz@infradead.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, John Stultz <johnstul@linux.vnet.ibm.com>

On Thu, 28 May 2009, Daniel Walker wrote:
> > > > Do any module based clocksources even exist right now?
> > > > clocksource_unregister only seems to be used 3 times..
> > > 
> > > Good point, it appears its not even exported.
> > > 
> > > Thomas mentioned modules, I assumed.
> > > 
> > The drivers/clocksource/ drivers in theory could be modular anyways.
> > Handling this transition properly is at least one less barrier to modular
> > clocksources, so I think it's progress regardless. I don't remember what
> > all of the other issues were though, John probably remembers.
> 
> I don't think it's an important case to consider right now ..
> clocksources are usually so integral to the system putting one in a
> module seems counterintuitive. 

That does not matter at all. If we have an unregister call then we
have to be prepared for 

     - the memory which contained the clocksource is freed 
     - the underlying hardware is going away. 

It does not matter at all if that happens in a compiled in or in a
modular driver.

Thanks,

	tglx
