From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 27 Jul 2016 13:22:52 +0000
Subject: Re: [PATCH v4 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160727132252.GB17195@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
 <862a5642f4a30f062171bbc14fe95a729eab8ba2.1469595861.git.dalias@libc.org>
 <20160727101235.GC12880@leverpostej>
 <20160727130606.GA15995@brightrain.aerifal.cx>
In-Reply-To: <20160727130606.GA15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jul 27, 2016 at 09:06:06AM -0400, Rich Felker wrote:
> On Wed, Jul 27, 2016 at 11:12:36AM +0100, Mark Rutland wrote:
> > On Wed, Jul 27, 2016 at 05:35:09AM +0000, Rich Felker wrote:
> > > +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> > > +{
> > > +	struct aic_data *aic = &aic_data;
> > > +	unsigned min_irq = 64;
> > > +
> > > +	pr_info("Initializing J-Core AIC\n");
> > > +
> > > +	if (!of_device_is_compatible(node, "jcore,aic2")) {
> > > +		unsigned cpu;
> > > +		for_each_possible_cpu(cpu) {
> > > +			void __iomem *base = of_iomap(node, cpu);
> > > +			if (!base)
> > > +				continue;
> > 
> > This sounds like it would be a critical error.
> > 
> > It would be best to at least pr_warn() if you can't map a CPU's AI
> > interface.
> 
> It's looping over possible cpus (per the kernel configuration for max
> cpus) so it's expected that a system with fewer cpus will also have
> fewer reg ranges for the aic. This is not an error. If you think
> there's a different/better way I should write this code, I'm open to
> suggestions.

In your arch code, set possible cpus based on the DT, before
initialising irqchips. i.e. mark any CPUs not in the DT as not possible.

That will also net you savings in other areas (e.g. per-cpu maps not
having to be allocated for CPUs which don't exist).

Otherwise, you're missing real error cases, e.g. two CPUs with only one
AIC region.

> > > +	aic->chip.irq_mask = noop;
> > > +	aic->chip.irq_unmask = noop;
> > 
> > If the core code wants to mask IRQs, how do you handle that? Can you
> > mask your CPU traps?
> 
> There's a global imask in the cpu that masks all interrupts that's
> used in the trap entry point, spinlocks, etc. already. This is a cpu
> standard feature and not logically part of the AIC.

Just to check, is that a single bit that masks all IRQs, or is there a
mark per-IRQ?

> My understanding is that the kernel already keeps a logical mask of
> disabled irqs in addition to mask/disable at the irqchip level so
> there's a fairly fast path for ignoring/holding (potentially spurious)
> irqs while they're supposed to be disabled and deferring them until
> they're enabled again.

While we can ignore suprious IRQs, there are cases where that's
insufficient (e.g. screaming interrupts, suspend).

Can your CPU mask IRQs individually?

Thanks,
Mark.
