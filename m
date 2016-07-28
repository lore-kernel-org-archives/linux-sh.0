From: Rich Felker <dalias@libc.org>
Date: Thu, 28 Jul 2016 14:26:15 +0000
Subject: Re: [PATCH v5 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160728142615.GH15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469688756.git.dalias@libc.org>
 <83d2b655baaaa387203a0432f0b52c1deb9d64e4.1469688756.git.dalias@libc.org>
 <alpine.DEB.2.11.1607281500340.19896@nanos>
In-Reply-To: <alpine.DEB.2.11.1607281500340.19896@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Thu, Jul 28, 2016 at 03:15:09PM +0200, Thomas Gleixner wrote:
> On Thu, 17 Mar 2016, Rich Felker wrote:
> > @@ -0,0 +1,86 @@
> > +/*
> > + * J-Core SoC AIC driver
> > + *
> > + * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
> > + *
> > + * This file is subject to the terms and conditions of the GNU General Public
> > + * License.  See the file "COPYING" in the main directory of this archive
> > + * for more details.
> > + */
> > +
> > +#include <linux/irq.h>
> > +#include <linux/io.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/cpu.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +
> > +#define AIC1_INTPRI 8
> > +
> > +static struct aic_data {
> > +	struct irq_chip chip;
> > +	struct irq_domain *domain;
> > +	struct notifier_block nb;
> 
> Please align the struct members for readability sake:
> 
> 	struct irq_chip		chip;
> 	struct irq_domain	*domain;
> 
> domain is just used in the init function as a replacement for a local
> variable. 

Indeed, I thought there would be reason to want to keep it around, but
it doesn't seem necessary. I'll change this to a local var.

> 	struct notifier_block	nb;
> 
> nb is not used anywhere in the code.
> 
> So what's the purpose of this data structure at all?

That code was removed since the last version since it's no longer
needed but I didn't notice I'd left it behind. Will remove.

> > +} aic_data;
> 
> Please seperate the struct definition and the variable declaration.

OK.

> > +static int aic_irqdomain_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hwirq)
> > +{
> > +	struct aic_data *aic = d->host_data;
> > +
> > +	irq_set_chip_data(irq, aic);
> > +	irq_set_chip_and_handler(irq, &aic->chip, handle_simple_irq);
> > +	irq_set_probe(irq);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aic_irqdomain_ops = {
> > +	.map = aic_irqdomain_map,
> > +	.xlate = irq_domain_xlate_onecell,
> > +};
> > +
> > +static void noop(struct irq_data *data)
> > +{
> > +}
> > +
> > +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> > +{
> > +	struct aic_data *aic = &aic_data;
> > +	unsigned min_irq = 64;
> 
> Magic constant. Please use a proper define with a proper explanation.

OK.

> > +	pr_info("Initializing J-Core AIC\n");
> > +
> > +	/* Only the AIC1 needs priority initialization in order to receive
> > +	 * interrupts, but the DT may declare a newer AIC as being
> > +	 * fallback-compatible with AIC1, so use incompatibility with AIC2
> > +	 * as the condition for actually being AIC1 and needing setup. */
> 
> Please use proper multi line comment style:
> 
>        /*
>         * First line.
> 	* ...
> 	* Last line.
> 	*/

OK.

> > +	if (!of_device_is_compatible(node, "jcore,aic2")) {
> 
> This should really be
> 
> 	if (of_device_is_compatible(node, "jcore,aic1")) {
> 
> as you want it explicitely for AIC1 only

As stated in the comment, my intent was that
of_device_is_compatible(node, "jcore,aic1") might be true for aic2,
but Mark Rutland's latest follow-up suggests that's not a good idea,
so I can change it. Two people have found it confusing now so that's
probably a good sign it was actually confusing.

> > +		unsigned cpu;
> 
> Missing newline between declaration and code.

OK, will fix.

> > +		for_each_present_cpu(cpu) {
> > +			void __iomem *base = of_iomap(node, cpu);
> > +			if (!base) {
> > +				pr_err("Unable to map AIC for cpu %u\n", cpu);
> > +				return -ENOMEM;
> > +			}
> > +			pr_info("Local AIC1 enable for cpu %u at %p\n",
> > +				cpu, base + AIC1_INTPRI);
> > +			__raw_writel(0xffffffff, base + AIC1_INTPRI);
> > +			iounmap(base);
> > +		}
> > +		min_irq = 16;
> 
> Please use a proper define and not hardcoded magic numbers which are
> completely undocumented.

OK.

> > +	}
> > +
> > +	aic->chip.name = "AIC";
> > +	aic->chip.irq_mask = noop;
> > +	aic->chip.irq_unmask = noop;
> 
> So how is that going to work when an irq is raised and there is no handler or
> the interrupt is disabled? That's going to end up in an eternal interrupt
> storm except when that interrupt line is level type.

No, because the hardware does not need or even provide any sort of
software ack/eoi. The pending status for an interrupt is cleared when
the interrupt is accepted by the cpu, which can only happen when the
cpu imask is clear.

Anyway the framework seems to allow either mask/unmask or
enable/disable to be null, but has semi-hidden assumptions that all
four aren't null. Can you offer any feedback on whether I should
prefer (as I currently have it) to provide the noop function for
mask/unmask, or leave them null and provide a noop enable/disable? I
think Mark Rutland was unclear on this too so I'm waiting for feedback
from someone else who understands the topic.

> If all your interrupts are edge type, then you want to add at least a comment
> which explains WHY this won't end up in a complete disaster.
> 
> > +	aic->domain = irq_domain_add_linear(node, 128, &aic_irqdomain_ops, aic);
> 
> Again. 128 is a magic number pulled out of thin air, right?
> 
> > +	irq_create_strict_mappings(aic->domain, min_irq, min_irq, 128-min_irq);
> 
>   	s/128-min_irq/128 - min_irq/

OK, I'll change this with the other and write them as expressione
based on descriptive macros.

Rich
