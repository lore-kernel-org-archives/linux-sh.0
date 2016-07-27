From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 27 Jul 2016 17:31:52 +0000
Subject: Re: [PATCH v4 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160727173152.GH17195@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
 <862a5642f4a30f062171bbc14fe95a729eab8ba2.1469595861.git.dalias@libc.org>
 <20160727101235.GC12880@leverpostej>
 <20160727130606.GA15995@brightrain.aerifal.cx>
 <20160727132252.GB17195@leverpostej>
 <20160727170709.GC15995@brightrain.aerifal.cx>
In-Reply-To: <20160727170709.GC15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Jul 27, 2016 at 01:07:09PM -0400, Rich Felker wrote:
> On Wed, Jul 27, 2016 at 02:22:52PM +0100, Mark Rutland wrote:
> > On Wed, Jul 27, 2016 at 09:06:06AM -0400, Rich Felker wrote:
> > > On Wed, Jul 27, 2016 at 11:12:36AM +0100, Mark Rutland wrote:
> > > > On Wed, Jul 27, 2016 at 05:35:09AM +0000, Rich Felker wrote:
> > > > > +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> > > > > +{
> > > > > +	struct aic_data *aic = &aic_data;
> > > > > +	unsigned min_irq = 64;
> > > > > +
> > > > > +	pr_info("Initializing J-Core AIC\n");
> > > > > +
> > > > > +	if (!of_device_is_compatible(node, "jcore,aic2")) {
> > > > > +		unsigned cpu;
> > > > > +		for_each_possible_cpu(cpu) {
> > > > > +			void __iomem *base = of_iomap(node, cpu);
> > > > > +			if (!base)
> > > > > +				continue;
> > > > 
> > > > This sounds like it would be a critical error.
> > > > 
> > > > It would be best to at least pr_warn() if you can't map a CPU's AI
> > > > interface.
> > > 
> > > It's looping over possible cpus (per the kernel configuration for max
> > > cpus) so it's expected that a system with fewer cpus will also have
> > > fewer reg ranges for the aic. This is not an error. If you think
> > > there's a different/better way I should write this code, I'm open to
> > > suggestions.
> > 
> > In your arch code, set possible cpus based on the DT, before
> > initialising irqchips. i.e. mark any CPUs not in the DT as not possible.
> > 
> > That will also net you savings in other areas (e.g. per-cpu maps not
> > having to be allocated for CPUs which don't exist).
> 
> Should it be done for possible or just present? I think the existing
> code already sets both possible and present true if and only if they
> have cpu nodes, so it should work as-is with either.

You'll want possible to be clear for the per-cpu maps case. 

I guess for the interrupt controller either is appropriate.

> > Otherwise, you're missing real error cases, e.g. two CPUs with only one
> > AIC region.
> 
> Sure, but do invalid DTBs need to be a diagnosable error?

To the extent that we can reasonably detect such issues, we should do
so. This case is trivial to detect, so I think we should do so.

This sort of logic helps to catch issues far earlier (e.g. when people
write their first DTs), and saves a fair amount of pain later down the
line.

> An invalid DTB can clearly cause the system to blow up arbitrarily
> badly with wrong memory regions, etc.

This is true, but in many cases such as with bad memory ranges we don't
have another source of truth to compare against, whereas we do for the
set of CPUs present/possible.

> > > > > +	aic->chip.irq_mask = noop;
> > > > > +	aic->chip.irq_unmask = noop;
> > > > 
> > > > If the core code wants to mask IRQs, how do you handle that? Can you
> > > > mask your CPU traps?
> > > 
> > > There's a global imask in the cpu that masks all interrupts that's
> > > used in the trap entry point, spinlocks, etc. already. This is a cpu
> > > standard feature and not logically part of the AIC.
> > 
> > Just to check, is that a single bit that masks all IRQs, or is there a
> > mark per-IRQ?
> 
> It's actually a 4-bit priority mask that masks all interrupts with
> priority <= the configured value, but Linux has no use for interrupt
> priorities and the kernel just sets the value to 0 or 15 for allowing
> or blocking interrupts

Ok.

IIUC, that means you *could* implement per-irq masking by having the
CPU's mask value set to 0, and flipping the priority of an IRQ between 0
and 1 to disable/enable.

Though from your prior comments it sounds like for AIC2 writes to the
MMIO priority registers are ignored, so that would not work for AIC2?

> > > My understanding is that the kernel already keeps a logical mask of
> > > disabled irqs in addition to mask/disable at the irqchip level so
> > > there's a fairly fast path for ignoring/holding (potentially spurious)
> > > irqs while they're supposed to be disabled and deferring them until
> > > they're enabled again.
> > 
> > While we can ignore suprious IRQs, there are cases where that's
> > insufficient (e.g. screaming interrupts, suspend).
> > 
> > Can your CPU mask IRQs individually?
> 
> No. If there's SoC hardware needing that capability it would need to
> be added, but I suspect off-SoC hardware generating interrupts might
> want to use a secondary chained interrupt controller anyway, which
> might have different functionality.

I was under the impression that the core IRQ code expected irq_mask and
irq_unmask to do what their names imply. I would be worried about what
might depend on that functionality.

I am far from an expert in that area, so I'll leave that to Marc,
Thomas, and Jason to comment on that.

Thanks,
Mark.
