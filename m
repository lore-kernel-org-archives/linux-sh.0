From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 28 Jul 2016 13:15:09 +0000
Subject: Re: [PATCH v5 2/2] irqchip: add J-Core AIC driver
Message-Id: <alpine.DEB.2.11.1607281500340.19896@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469688756.git.dalias@libc.org> <83d2b655baaaa387203a0432f0b52c1deb9d64e4.1469688756.git.dalias@libc.org>
In-Reply-To: <83d2b655baaaa387203a0432f0b52c1deb9d64e4.1469688756.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

On Thu, 17 Mar 2016, Rich Felker wrote:
> @@ -0,0 +1,86 @@
> +/*
> + * J-Core SoC AIC driver
> + *
> + * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/irq.h>
> +#include <linux/io.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqdomain.h>
> +#include <linux/cpu.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define AIC1_INTPRI 8
> +
> +static struct aic_data {
> +	struct irq_chip chip;
> +	struct irq_domain *domain;
> +	struct notifier_block nb;

Please align the struct members for readability sake:

	struct irq_chip		chip;
	struct irq_domain	*domain;

domain is just used in the init function as a replacement for a local
variable. 

	struct notifier_block	nb;

nb is not used anywhere in the code.

So what's the purpose of this data structure at all?

> +} aic_data;

Please seperate the struct definition and the variable declaration.

> +
> +static int aic_irqdomain_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	struct aic_data *aic = d->host_data;
> +
> +	irq_set_chip_data(irq, aic);
> +	irq_set_chip_and_handler(irq, &aic->chip, handle_simple_irq);
> +	irq_set_probe(irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops aic_irqdomain_ops = {
> +	.map = aic_irqdomain_map,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +static void noop(struct irq_data *data)
> +{
> +}
> +
> +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> +{
> +	struct aic_data *aic = &aic_data;
> +	unsigned min_irq = 64;

Magic constant. Please use a proper define with a proper explanation.

> +
> +	pr_info("Initializing J-Core AIC\n");
> +
> +	/* Only the AIC1 needs priority initialization in order to receive
> +	 * interrupts, but the DT may declare a newer AIC as being
> +	 * fallback-compatible with AIC1, so use incompatibility with AIC2
> +	 * as the condition for actually being AIC1 and needing setup. */

Please use proper multi line comment style:

       /*
        * First line.
	* ...
	* Last line.
	*/

> +	if (!of_device_is_compatible(node, "jcore,aic2")) {

This should really be

	if (of_device_is_compatible(node, "jcore,aic1")) {

as you want it explicitely for AIC1 only

> +		unsigned cpu;

Missing newline between declaration and code.

> +		for_each_present_cpu(cpu) {
> +			void __iomem *base = of_iomap(node, cpu);
> +			if (!base) {
> +				pr_err("Unable to map AIC for cpu %u\n", cpu);
> +				return -ENOMEM;
> +			}
> +			pr_info("Local AIC1 enable for cpu %u at %p\n",
> +				cpu, base + AIC1_INTPRI);
> +			__raw_writel(0xffffffff, base + AIC1_INTPRI);
> +			iounmap(base);
> +		}
> +		min_irq = 16;

Please use a proper define and not hardcoded magic numbers which are
completely undocumented.

> +	}
> +
> +	aic->chip.name = "AIC";
> +	aic->chip.irq_mask = noop;
> +	aic->chip.irq_unmask = noop;

So how is that going to work when an irq is raised and there is no handler or
the interrupt is disabled? That's going to end up in an eternal interrupt
storm except when that interrupt line is level type.

If all your interrupts are edge type, then you want to add at least a comment
which explains WHY this won't end up in a complete disaster.

> +	aic->domain = irq_domain_add_linear(node, 128, &aic_irqdomain_ops, aic);

Again. 128 is a magic number pulled out of thin air, right?

> +	irq_create_strict_mappings(aic->domain, min_irq, min_irq, 128-min_irq);

  	s/128-min_irq/128 - min_irq/

Thanks,

	tglx
