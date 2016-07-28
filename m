From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 28 Jul 2016 14:44:05 +0000
Subject: Re: [PATCH v5 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <alpine.DEB.2.11.1607281515330.19896@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469688975.git.dalias@libc.org> <ed156509aed631486decf1828acb4f0afa61dd31.1469688975.git.dalias@libc.org>
In-Reply-To: <ed156509aed631486decf1828acb4f0afa61dd31.1469688975.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

> +
> +#define PIT_IRQ_SHIFT 12
> +#define PIT_PRIO_SHIFT 20
> +#define PIT_ENABLE_SHIFT 26
> +#define PIT_IRQ_MASK 0x3f
> +#define PIT_PRIO_MASK 0xf

Can you please align the numbers as nicely as you did below and please use
TABS not spaces to seperate them.

> +#define REG_PITEN 0x00
> +#define REG_THROT 0x10
> +#define REG_COUNT 0x14
> +#define REG_BUSPD 0x18
> +#define REG_SECHI 0x20
> +#define REG_SECLO 0x24
> +#define REG_NSEC  0x28
> +
> +struct jcore_clocksource {
> +	struct clocksource cs;
> +	__iomem void *base;
> +};
> +
> +struct jcore_pit {
> +	struct clock_event_device ced;
> +	__iomem void *base;
> +	unsigned long periodic_delta;
> +	unsigned cpu;
> +	u32 enable_val;
> +};

Again. Please align the struct members as I asked in the other mail.

> +
> +struct jcore_pit_nb {
> +	struct notifier_block nb;
> +	struct jcore_pit __percpu *pit_percpu;
> +};
> +
> +static struct clocksource *jcore_cs;
> +
> +static cycle_t jcore_clocksource_read(struct clocksource *cs)
> +{
> +	__iomem void *base > +		container_of(cs, struct jcore_clocksource, cs)->base;
> +	u32 sechi, seclo, nsec, sechi0, seclo0;

It would be way simpler to read if you avoid that line break by doing:

	u32 sechi, seclo, nsec, sechi0, seclo0;
	__iomem void *base;
   
	base = container_of(cs, struct jcore_clocksource, cs)->base; 

Hmm?

> +
> +	sechi = __raw_readl(base + REG_SECHI);
> +	seclo = __raw_readl(base + REG_SECLO);
> +	do {
> +		sechi0 = sechi;
> +		seclo0 = seclo;
> +		nsec  = __raw_readl(base + REG_NSEC);
> +		sechi = __raw_readl(base + REG_SECHI);
> +		seclo = __raw_readl(base + REG_SECLO);
> +	} while (sechi0 != sechi || seclo0 != seclo);
> +
> +	return ((u64)sechi << 32 | seclo) * NSEC_PER_SEC + nsec;

Wow, that's an expensive thing for a hotpath operation. You really don't have
binary readout register for that clock thingy?

> +}
> +
> +static notrace u64 jcore_sched_clock_read(void)
> +{
> +	return jcore_clocksource_read(jcore_cs);

Why don't you stuff the above code into this function?

> +}
> +
> +static int jcore_pit_disable(struct jcore_pit *pit)
> +{
> +	__raw_writel(0, pit->base + REG_PITEN);
> +	return 0;
> +}
> +
> +static int jcore_pit_set(unsigned long delta, struct jcore_pit *pit)
> +{
> +	jcore_pit_disable(pit);
> +	__raw_writel(delta, pit->base + REG_THROT);
> +	__raw_writel(pit->enable_val, pit->base + REG_PITEN);
> +	return 0;
> +}
> +
> +static int jcore_pit_set_state_shutdown(struct clock_event_device *ced)
> +{
> +	struct jcore_pit *pit = container_of(ced, struct jcore_pit, ced);

Newline between declaration and code please....

> +	return jcore_pit_disable(pit);
> +}

> +static int jcore_pit_cpu_notify(struct notifier_block *self,
> +			unsigned long action, void *hcpu)
> +{
> +	struct jcore_pit_nb *nb = container_of(self, struct jcore_pit_nb, nb);
> +	switch (action & ~CPU_TASKS_FROZEN) {
> +	case CPU_STARTING:
> +		jcore_pit_local_init(this_cpu_ptr(nb->pit_percpu));
> +		break;
> +	}
> +	return NOTIFY_OK;

Please convert this to the new state machine model of cpu
hotplug. CPU_STARTING will be gone very soon. Here is an example:

http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=smp/hotplug&id~86e8bd8dd67649d176e08d8dfb90039f0a1e98

> +static int __init jcore_pit_init(struct device_node *node)
> +{
> +	int err;
> +	__iomem void *pit_base;
> +	unsigned pit_irq;
> +	unsigned cpu;

Please put the same data types into a single line

> +	struct jcore_pit_nb *nb = 0;

  = NULL;

Please

> +	struct jcore_clocksource *cs = 0;
> +	struct jcore_pit __percpu *pit_percpu = 0;
> +
> +	err = request_irq(pit_irq, jcore_timer_interrupt,
> +		IRQF_TIMER | IRQF_PERCPU, "jcore_pit", pit_percpu);

If you need line breaks, then please keep the arguments aligned:

	err = request_irq(pit_irq, jcore_timer_interrupt,
			  IRQF_TIMER | IRQF_PERCPU, "jcore_pit", pit_percpu);

> +	/* The J-Core PIT is not hard-wired to a particular IRQ, but
> +	 * integrated with the interrupt controller such that the IRQ it
> +	 * generates is programmable. The programming interface has a
> +	 * legacy field which was an interrupt priority for AIC1, but
> +	 * which is OR'd onto bits 2-5 of the generated IRQ number when
> +	 * used with J-Core AIC2, so set it to match these bits. */

Proper multiline comments please

> +	return 0;
> +
> +out:
> +	pr_err("Could not initialize J-Core PIT driver\n");

So you have a pr_err in every error path and that goto just to pr_err the
obvious? Well, yes ...

Thanks,

	tglx
