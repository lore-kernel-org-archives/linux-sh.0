From: Rich Felker <dalias@libc.org>
Date: Wed, 27 Jul 2016 13:06:06 +0000
Subject: Re: [PATCH v4 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160727130606.GA15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469595860.git.dalias@libc.org>
 <862a5642f4a30f062171bbc14fe95a729eab8ba2.1469595861.git.dalias@libc.org>
 <20160727101235.GC12880@leverpostej>
In-Reply-To: <20160727101235.GC12880@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

On Wed, Jul 27, 2016 at 11:12:36AM +0100, Mark Rutland wrote:
> On Wed, Jul 27, 2016 at 05:35:09AM +0000, Rich Felker wrote:
> > +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> > +{
> > +	struct aic_data *aic = &aic_data;
> > +	unsigned min_irq = 64;
> > +
> > +	pr_info("Initializing J-Core AIC\n");
> > +
> > +	if (!of_device_is_compatible(node, "jcore,aic2")) {
> > +		unsigned cpu;
> > +		for_each_possible_cpu(cpu) {
> > +			void __iomem *base = of_iomap(node, cpu);
> > +			if (!base)
> > +				continue;
> 
> This sounds like it would be a critical error.
> 
> It would be best to at least pr_warn() if you can't map a CPU's AI
> interface.

It's looping over possible cpus (per the kernel configuration for max
cpus) so it's expected that a system with fewer cpus will also have
fewer reg ranges for the aic. This is not an error. If you think
there's a different/better way I should write this code, I'm open to
suggestions.

> > +			pr_info("Local AIC1 enable for cpu %u at %p\n",
> > +				cpu, base + AIC1_INTPRI);
> > +			__raw_writel(0xffffffff, base + AIC1_INTPRI);
> > +		}
> 
> Here base goes out of scope. If you don't need it, it would be best
> practice to iounmap it (even if that happens to be a no-op on your
> arch).

OK. I can add that.

> > +		min_irq = 16;
> > +	}
> > +
> > +	aic->chip.name = node->name;
> 
> It's probably best to give the name explicitly in the driver (e.g.
> "AIC"), rather than taknig whatever happens to be in the DT (which
> should be 'interrupt-controller@<addr>'.

OK.

> > +	aic->chip.irq_mask = noop;
> > +	aic->chip.irq_unmask = noop;
> 
> If the core code wants to mask IRQs, how do you handle that? Can you
> mask your CPU traps?

There's a global imask in the cpu that masks all interrupts that's
used in the trap entry point, spinlocks, etc. already. This is a cpu
standard feature and not logically part of the AIC. My understanding
is that the kernel already keeps a logical mask of disabled irqs in
addition to mask/disable at the irqchip level so there's a fairly fast
path for ignoring/holding (potentially spurious) irqs while they're
supposed to be disabled and deferring them until they're enabled
again.

Rich
