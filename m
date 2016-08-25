From: Rich Felker <dalias@libc.org>
Date: Thu, 25 Aug 2016 19:20:11 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160825192011.GD15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1608250947120.5714@nanos>
 <20160825145650.GA15995@brightrain.aerifal.cx>
 <20160825163805.GA8524@remoulade>
 <20160825175135.GC15995@brightrain.aerifal.cx>
 <20160825182053.GA15000@remoulade>
In-Reply-To: <20160825182053.GA15000@remoulade>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>

On Thu, Aug 25, 2016 at 07:21:13PM +0100, Mark Rutland wrote:
> On Thu, Aug 25, 2016 at 01:51:35PM -0400, Rich Felker wrote:
> > On Thu, Aug 25, 2016 at 05:38:06PM +0100, Mark Rutland wrote:
> > > On Thu, Aug 25, 2016 at 10:56:50AM -0400, Rich Felker wrote:
> > > > On Thu, Aug 25, 2016 at 10:07:08AM +0200, Thomas Gleixner wrote:
> > > > Nominally it uses the same range of hardware interrupt numbers for all
> > > > (presently both) cpus, but some of them get delivered to a specific
> > > > cpu associated with the event (presently, IPI and timer; IPI is on a
> > > > fixed number at synthesis time but timer is runtime configurable)
> > > > while others are conceptually deliverable to either cpu (presently
> > > > only delivered to cpu0, but that's treated as an implementation
> > > > detail).
> > > 
> > > Given you say it's delivered to the CPU associated with the event (and you have
> > > different PIT bases per-cpu), it sounds like your timer interrupt is percpu,
> > > it's just that the hwirq number can be chosen by software.
> > 
> > It's what I would call percpu in the hardware, but I'm not convinced
> > that the Linux irq subsystem's "percpu" stuff models it in a way
> > that fits the hw, nor that it's in any way necessary.
> 
> My understanding was that you used the same hwirq number to handle interrupts
> from per-cpu resources being delivered to their relevant CPUs, independently of
> each other.
> 
> That in my mind is a perfect match.
> 
> The only difference, as I've stated a number of times, seems to be that you can
> choose the hwirq number from software.

I don't understand where you're getting that from. The timer irq
number can be chosen from software, but by convention the device tree
provides an otherwise-unoccupied irq number to be used. The IPI irq
cannot be chosen by software; it's hard-coded at synthesis time.
Either way, though, I don't see how being able to choose the number
from software would impact the situation.

The reason I don't think the current percpu irq request framework is
well-suited is that, unlike ARM, we don't have any particular set of
irq numbers that are designated as percpu vs global. In theory the DT
could be extended to provide that information somehow, but it's not
information you need to actually be able to use the hardware; if it
were added, it would just be satisfying the Linux irq subsystem's (imo
gratuitous) desire to know.

From my perspective, a hwirq being percpu is logically a property that
only the driver for the attached hardware needs to be aware of. In
fact the drivers using the percpu request already encode this, but
there's an unnecessary requirement that the irqchip driver also have
this knowledge.

> > > > It currently works requesting the irq with flags that ensure the
> > > > handler runs on the same cpu it was delivered on, without using any
> > > > other percpu irq framework. If you have concerns about ways this could
> > > > break and want me to make the drivers do something else, I'm open to
> > > > suggestions.
> > > 
> > > As I suggested, I don't think that this is right, and you need some mechanism
> > > to describe to the kernel that the interrupt is percpu (e.g. a flag in the
> > > interrupt-specifier in DT).
> > 
> > Thomas seemed to think it's okay as-is. Can you describe what you
> > expect could go wrong by using request_irq rather than the ARM-style
> > percpu irq framework?
> 
> The percpu irq code is designed to expect a hwirq number being shared by
> banked, cpu-local interrupts, the regular request_irq code is not. Even if the
> latter happens to work today for your use-case, that is not by design.
> 
> Relying on non-deliberate properties of request_irq makes it far harder for the
> generic code to be altered in future, with global vs percpu locking,
> synchronisation, accounting, etc being broken.

I can see how the irq subsystem wrongly thinking an irq is percpu when
it's actually global could cause problems (missing locking, etc.) but
I fail to see how the opposite could. In an abstract sense, percpu
irqs are just a special case of global ones. The general
infrastructure has no reason to care whether it was delivered on cpuN
because the event was associated with cpuN, or because cpuN happened
to be where the hw decided to deliver it. Only the actual
driver/handler needs to know that the cpu on which it was delivered is
meaningful.

Rich
