From: Rich Felker <dalias@libc.org>
Date: Wed, 25 May 2016 04:29:15 +0000
Subject: Re: [PATCH v2 08/12] irqchip: add J-Core AIC driver
Message-Id: <20160525042915.GQ21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <2afd392ff334c996970e3a9eacdd5ec5d839b608.1463708766.git.dalias@libc.org>
 <573EC7BC.6070709@arm.com>
In-Reply-To: <573EC7BC.6070709@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>

On Fri, May 20, 2016 at 09:15:56AM +0100, Marc Zyngier wrote:
> On 20/05/16 03:53, Rich Felker wrote:
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> > My previous post of the patch series accidentally omitted omitted
> > Cc'ing of subsystem maintainers for the necessary clocksource,
> > irqchip, and spi drivers. Please ack if this looks ok because I want
> > to get it merged as part of the arch/sh pull request for 4.7.
> 
> For a start, a decent commit message wouldn't hurt.

Adding it.

> >  drivers/irqchip/Kconfig         |  6 +++
> >  drivers/irqchip/Makefile        |  1 +
> >  drivers/irqchip/irq-jcore-aic.c | 95 +++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 102 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-jcore-aic.c
> > 
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 3e12479..3cb37d6 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -149,6 +149,12 @@ config PIC32_EVIC
> >  	select GENERIC_IRQ_CHIP
> >  	select IRQ_DOMAIN
> >  
> > +config JCORE_AIC
> > +	bool "J-Core integrated AIC"
> > +	select IRQ_DOMAIN
> > +	help
> > +	  Support for the J-Core integrated AIC.
> > +
> >  config RENESAS_INTC_IRQPIN
> >  	bool
> >  	select IRQ_DOMAIN
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index b03cfcb..5a1f1bf 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -37,6 +37,7 @@ obj-$(CONFIG_I8259)			+= irq-i8259.o
> >  obj-$(CONFIG_IMGPDC_IRQ)		+= irq-imgpdc.o
> >  obj-$(CONFIG_IRQ_MIPS_CPU)		+= irq-mips-cpu.o
> >  obj-$(CONFIG_SIRF_IRQ)			+= irq-sirfsoc.o
> > +obj-$(CONFIG_JCORE_AIC)			+= irq-jcore-aic.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)	+= irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)		+= irq-renesas-irqc.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
> > diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
> > new file mode 100644
> > index 0000000..68178fb
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-jcore-aic.c
> > @@ -0,0 +1,95 @@
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
> > +#include <linux/module.h>
> > +#include <linux/cpu.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +
> > +#define AIC1_INTPRI 8
> > +
> > +struct aic_data {
> > +	unsigned char __iomem *base;
> > +	u32 cpu_offset;
> > +	struct irq_chip chip;
> > +	struct irq_domain *domain;
> > +	struct notifier_block nb;
> > +} aic_data;
> > +
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
> > +static void aic1_localenable(struct aic_data *aic)
> > +{
> > +	unsigned cpu = smp_processor_id();
> > +	pr_info("Local AIC enable on cpu %u\n", cpu);
> > +	writel(0xffffffff, aic->base + cpu * aic->cpu_offset + AIC1_INTPRI);
> > +}
> > +
> > +static int aic1_cpu_notify(struct notifier_block *self, unsigned long action, void *hcpu)
> > +{
> > +	switch (action & ~CPU_TASKS_FROZEN) {
> > +	case CPU_STARTING:
> > +		aic1_localenable(container_of(self, struct aic_data, nb));
> > +		break;
> > +	}
> 
> And nothing happens when the CPU goes down?

There is no support for bringing down CPUs (SMP support isn't even
going upstream yet in this patch series, but I didn't want to
gratuitously rip the SMP support out of the drivers only to add it
back later). If/when that's added it will have to be determined at
that point whether any action is required.

> > +	return NOTIFY_OK;
> > +}
> > +
> > +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> > +{
> > +	struct aic_data *aic = &aic_data;
> > +
> > +	aic->base = of_iomap(node, 0);
> > +	of_property_read_u32(node, "cpu-offset", &aic->cpu_offset);
> > +
> > +	pr_info("Initializing J-Core AIC at %p\n", aic->base);
> > +
> > +	if (of_device_is_compatible(node, "jcore,aic1")) {
> > +		/* For aic1, need to enabled zero-priority-by-default irqs */
> > +		aic->nb.notifier_call = aic1_cpu_notify;
> > +		register_cpu_notifier(&aic->nb);
> > +		aic1_localenable(aic);
> > +	}
> > +
> > +	aic->chip.name = node->name;
> > +	aic->chip.irq_mask = noop;
> > +	aic->chip.irq_unmask = noop;
> 
> So this driver is doing exactly nothing. Not even an EOI. How does it
> work? How is this driver involved in the interrupt flow?

For aic1, the driver is setting non-zero priorities, without which no
interrupts will ever arrive. For aic2, this is not needed. Aside from
that, the driver is providing an irq domain, without which nothing in
the DT could get an irq.

Right now the whole arch/sh irq framework lacks a good abstraction for
arbitrary interrupt controllers. By default the cpu trap number is
taken as the interrupt number and passed into generic_handle_irq;
legacy board files can hook this, but there's no way yet to do that
for systems described by DT.

When that's improved (a long project because it involves getting
legacy hardware, testing on it, and converting over support for legacy
hardware to use new frameworks) the AIC driver will do something to
register a top-level interrupt handling function, and hopefully by
then the conventions for such registration will no longer be
arch-specific.

> > +
> > +	aic->domain = irq_domain_add_linear(node, 128, &aic_irqdomain_ops, aic);
> 
> The DT binding says that aic1 has 8 interrupts, and aic2 has 64. Why are
> you allocating 128 of them?

Because the 64 are 64-127, while the 8 are 17-24, which are really 8+1
because the timer interrupt can be programmed to any cpu trap number,
not necessarily in any restricted range. The irq domain has to map
these numbers which will appear in the DT. I mapped 16-127 because
trap numbers lower than 16 are reserved for exceptions. Some of that
range is also reserved for syscalls and not usable; I can omit those
if desirable.

> > +	irq_create_strict_mappings(aic->domain, 16, 16, 112);
> 
> What are the first 16 interrupts for? By the look of it, this is a
> legacy domain in disguise.

The first 16 trap numbers (and others) are reserved for non-interrupt
use. As far as I know there's no compelling reason there needs to be a
one-to-one mapping between these trap numbers and virtual irq numbers,
and I can probably change that if you really like, but it doesn't seem
to hurt.

> > +
> > +	return 0;
> > +}
> > +
> > +IRQCHIP_DECLARE(jcore_aic2, "jcore,aic2", aic_irq_of_init);
> > +IRQCHIP_DECLARE(jcore_aic1, "jcore,aic1", aic_irq_of_init);
> 
> To be honest, this doesn't look like an irqchip driver. More like a
> glorified probe function. Maybe this is a property of the architecture,
> but I'd really like at least a comment explaining this.

Yes, I think that's a correct assessment. I have a v3 series I'm
posting now but I can add comments following that.

Rich
