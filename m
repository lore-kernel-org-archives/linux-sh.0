From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 29 May 2009 18:18:38 +0000
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <200905292018.39247.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Friday 29 May 2009, Alan Stern wrote:
> On Fri, 29 May 2009, Magnus Damm wrote:
> 
> > > (And by the way, the _noirq ops don't run in atomic context.  They run
> > > in process context with most interrupt deliveries disabled.  It's not
> > > the same thing -- they are allowed to sleep.)
> > 
> > Huh, so if they are allowed to sleep then clock events are still
> > running. And probably some clocksource as well. I guess that's why you
> > say "most" interrupts disabled instead of all. Sharing the timer IRQ
> > is not allowed then?
> 
> Rafael can tell you.  But notice I didn't say the interrupts were
> disabled -- I said that interrupt _delivery_ was disabled.  In general
> the interrupts themselves _are_ enabled; the kernel fields them but
> then does not call the drivers' interrupt handler routines.

That's correct, except for the platforms where __disable_irq() actually masks
the IRQ.  I'm not sure if SuperH is one of these.

> (Except perhaps for IRQs which are explicitly marked as wakeup sources...)

No, they are treated just like the other ones except that we check if any of
them are pending right at the beginning of sysdev_suspend().

> > I wonder if the PM code assumes that the clock event is a sys device?

Yes, it does.

> > We use platform drivers for clock events on SuperH...

Argh.  This is going to hurt, but I'm not sure how badly.  At least on
multiprocessor.

Best,
Rafael
