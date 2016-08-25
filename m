From: Rich Felker <dalias@libc.org>
Date: Thu, 25 Aug 2016 17:45:36 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160825174536.GB15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1608250947120.5714@nanos>
 <20160825145650.GA15995@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1608251727410.5714@nanos>
In-Reply-To: <alpine.DEB.2.20.1608251727410.5714@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>

On Thu, Aug 25, 2016 at 05:41:29PM +0200, Thomas Gleixner wrote:
> On Thu, 25 Aug 2016, Rich Felker wrote:
> > assumption that is was just a bug. Now that Mark Rutland has explained
> > it well (and with your additional explanation below in your email), I
> > see what the motivation was, but I still think it could be done in a
> > less-confusing and more-consistent way that doesn't assume ARM-like
> > irq architecture.
> 
> It's not only ARM. Some MIPS Octeon stuff has the same layout and requirements
> to use a single irq number for interrupts which are delivered on a per cpu
> basis.
> 
> Patches are welcome :)

I'm not opposed to working on changes, but based on your below
comments I think maybe this (percpu request) is just infrastructure I
shouldn't be using. I think the source of my frustration was the
repeated (maybe by different people; I don't remember now) suggestions
that I use it even when I found that it didn't currently match well
with the hardware.

> > > If your particular hardware has the old scheme of seperate interrupt numbers
> > > for per cpu interrupts, then you can simply use the normal interrupt scheme
> > > and request a seperate interrupt per cpu.
> > 
> > Nominally it uses the same range of hardware interrupt numbers for all
> > (presently both) cpus, but some of them get delivered to a specific
> > cpu associated with the event (presently, IPI and timer; IPI is on a
> > fixed number at synthesis time but timer is runtime configurable)
> > while others are conceptually deliverable to either cpu (presently
> > only delivered to cpu0, but that's treated as an implementation
> > detail).
> 
> If I understand correctly, then this is the classic scheme:
> 
>    CPU0		IPI0	   IRQ-N
>    CPU1		IPI1	   IRQ-M
> 
> These and the timers or whatever are strict per cpu and therefor not routable.
> Regular device interrupts can be routed to any CPU by setting the
> affinity. Correct?

IPI generates hw irq 97 on whichever cpu it's targeted at, and the
timer generates whatever hw irq you program it to generate (by
convention, currently 72) on the cpu associated with the timer that
expired. Treating "cpu0's irq 97" and "cpu1's irq 97" as separate hw
irq numbers would be possible at the kernel level (just by using the
cpu id as part of the logical hw irq number) but this would require
lots of (imo useless) infrastructure/overhead and hard-coded
assumptions about which irq numbers are used for percpu events, and it
would not model the hardware well.

> > It currently works requesting the irq with flags that ensure the
> > handler runs on the same cpu it was delivered on, without using any
> > other percpu irq framework.
> 
> Which special flag are you referring to? I'm not aware of one.
> 
> IRQF_PER_CPU is just telling the core that this is a non routable per cpu
> interrupt. It's excluded from affinity setting and also on cpu hot unplug the
> per cpu interrupts are not touched and nothing tries to reroute them to one of
> the still online cpus.
> 
> Regarding the interrupt handler. It runs on the CPU on which the interrupt is
> delivered and there is nothing you can influence with a flag.

OK, I was not clear on whether there was such a guarantee in general
but knew there must be one for IRQF_TIMER or IRQF_PER_CPU.

(Without knowing the system doesn't do this, it's possible that the
softirq/tasklet stuff could migrate handling to a different cpu than
the hardware irq was delivered on.)

> > If you have concerns about ways this could break and want me to make the
> > drivers do something else, I'm open to suggestions.
> 
> If I understand the hardware halfways right, then using request_irq() with
> IRQF_PER_CPU for these special interrupts is completely correct.
> 
> The handler either uses this_cpu_xxx() for accessing the per cpu data related
> to the interrupt or you can hand in a percpu pointer as dev_id to
> request_irq() which then is handed to the interrupt function as a cookie.

Yes, that's exactly what my driver is doing now, and I'm happy to
leave it that way. Can we move forward with that? If so I'll make the
other changes requested and submit a new version of the patch.

Rich
