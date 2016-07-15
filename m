From: Rich Felker <dalias@libc.org>
Date: Fri, 15 Jul 2016 17:02:59 +0000
Subject: Re: [PATCH v3 08/12] irqchip: add J-Core AIC driver
Message-Id: <20160715170259.GT15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <05a5be0a4f1471272dcdd2259e4d97642ee43759.1464148904.git.dalias@libc.org>
 <20160715161917.GG31509@io.lakedaemon.net>
In-Reply-To: <20160715161917.GG31509@io.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Jul 15, 2016 at 04:19:17PM +0000, Jason Cooper wrote:
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
> > +	return NOTIFY_OK;
> > +}
> 
> Please take a look at the series posted by Anna-Maria Gleixner for
> recent changes to the cpu hp state machine.
> 
>   https://lkml.kernel.org/r/20160713153333.416260485@linutronix.de

I saw this but was utterly confused about what's going on. Is the
general notifier system that doesn't need to be aware of specific
devices actually being replaced by a huge enum table of all possible
devices that need special treatment as cpu starting/dying?? Or do I
misunderstand what's going on?

Rich
