From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Aug 2016 17:40:01 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160824174001.GW15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
In-Reply-To: <57BDCE5D.2050609@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <Marc.Zyngier@arm.com>

On Wed, Aug 24, 2016 at 06:42:05PM +0200, Daniel Lezcano wrote:
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 5677886..3210ca5 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -407,6 +407,15 @@ config SYS_SUPPORTS_SH_TMU
> >  config SYS_SUPPORTS_EM_STI
> >          bool
> >  
> > +config CLKSRC_JCORE_PIT
> > +	bool "J-Core PIT timer driver"
> > +	depends on OF && (SUPERH || COMPILE_TEST)
> 
> Even if this is correct, for the sake of consistency, it is preferable
> to change it to:
> 
> 	bool "J-Core PIT timer driver" if COMPILE_TEST
> 	depends on SUPERH
> 	select CLKSRC_OF

Is this functionally equivalent? If so that's non-obvious to me. What
about the dropped OF dependency? The intent is that the option should
always be available for SUPERH targets using OF, otherwise only
available with COMPILE_TEST.

> > +static int jcore_pit_set(unsigned long delta, struct jcore_pit *pit)
> > +{
> > +	jcore_pit_disable(pit);
> > +	__raw_writel(delta, pit->base + REG_THROT);
> > +	__raw_writel(pit->enable_val, pit->base + REG_PITEN);
> > +	return 0;
> 
> Why do you need to use __raw_writel ?
> 
> s/__raw_writel/writel/

I actually tried multiple times to find good resources on policy for
which form to prefer, but didn't have much luck. My understanding is
that __raw_writel/__raw_readl always performs a native-endian
load/store, whereas writel/readl behavior depends on cpu endianness
and whether the arch declares that "pci bus" (that was the term I
found in the source, not relevant here) io is endian-swapped or not.
Can you give me a better explanation of why we might prefer one form
or the other?

> > +	freq = DIV_ROUND_CLOSEST(NSEC_PER_SEC, buspd);
> > +	pit->periodic_delta = DIV_ROUND_CLOSEST(NSEC_PER_SEC, HZ*buspd);
> 
> --->					HZ * buspd

OK.

> > +	clockevents_config_and_register(&pit->ced, freq, 1, ULONG_MAX);
> > +
> > +	return 0;
> > +}
> > +
> > +static int jcore_pit_local_shutdown(unsigned cpu)
> > +{
> > +	return 0;
> > +}
> 
> This function is useless I think. AFAIU, cpuhp_setup_state can have a
> NULL function for the cpu teardown.

OK, I wasn't sure if that was permitted.

> > +	jcore_cs.name = "jcore_pit_cs";
> > +	jcore_cs.rating = 400;
> > +	jcore_cs.read = jcore_clocksource_read;
> > +	jcore_cs.mult = 1;
> > +	jcore_cs.shift = 0;
> > +	jcore_cs.mask = CLOCKSOURCE_MASK(32);
> > +	jcore_cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
> > +
> > +	err = clocksource_register_hz(&jcore_cs, NSEC_PER_SEC);
> > +	if (err) {
> > +		pr_err("Error registering clocksource device: %d\n", err);
> > +		return err;
> > +	}
> 
> May be you can consider by replacing the above by:
> 
> 	clocksource_mmio_init(jcore_pit_base, "jcore_pit_cs",
> 				NSEC_PER_SEC, 32,
> 				jcore_clocksource_read);

I think you're missing the rating argument. Otherwise it should work,
but is there a good reason to prefer it? The code is slightly simpler;
I'm not sure if using kzalloc vs static storage is better or worse.

> > +	sched_clock_register(jcore_sched_clock_read, 32, NSEC_PER_SEC);
> > +
> > +	jcore_pit_percpu = alloc_percpu(struct jcore_pit);
> > +	if (!jcore_pit_percpu) {
> > +		pr_err("Failed to allocate memory for clock event device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	err = request_irq(pit_irq, jcore_timer_interrupt,
> > +			  IRQF_TIMER | IRQF_PERCPU,
> > +			  "jcore_pit", jcore_pit_percpu);
> > +	if (err) {
> > +		pr_err("pit irq request failed: %d\n", err);
> > +		return err;
> > +	}
> 
> That is my major concern. Regarding the description of this timer, it
> appears there is one timer per cpu but we use request_irq instead of
> request_percpu_irq.
> 
> IIUC, there is a problem with the interrupt controller where the per irq
> line are not working correctly. Is that correct ?

I don't think that's a correct characterization. Rather the percpu
infrastructure just means something completely different from what you
would expect it to mean. It has nothing to do with the hardware but
rather with kernel-internal choice of whether to do percpu devid
mapping inside the irq infrastructure, and the choice at the
irq-requester side of whether to do this is required to match the
irqchip driver's choice. I explained this better in another email
which I could dig up if necessary, but the essence is that
request_percpu_irq is a misnamed and unusably broken API.

> Regarding Marc Zyngier comments about the irq controller driver being
> almost empty, I'm wondering if something in the irq controller driver
> which shouldn't be added before submitting this timer driver with SMP
> support (eg. irq domain ?).

I don't think so. At most I could make the driver hard-code the percpu
devid model for certain irqs, but that _does not reflect_ anything
about the hardware. Rather it just reflects bad kernel internals. It
would also require writing a new percpu devid version of
handle_simple_irq.

In the other thread where I discussed this, I suggested irq framework
changes that would clean this all up and make the percpu devid stuff
work the way someone trying to use the API would expect, but such
changes are not necessary for the J-Core drivers (or other existing
drivers) to work.

> > +	/*
> > +	 * The J-Core PIT is not hard-wired to a particular IRQ, but
> > +	 * integrated with the interrupt controller such that the IRQ it
> > +	 * generates is programmable. The programming interface has a
> > +	 * legacy field which was an interrupt priority for AIC1, but
> > +	 * which is OR'd onto bits 2-5 of the generated IRQ number when
> > +	 * used with J-Core AIC2, so set it to match these bits.
> > +	 */
> > +	hwirq = irq_get_irq_data(pit_irq)->hwirq;
> 
> 	irq_hw_number_t hwirq;
> 	hwirq = irqd_to_hwirq(irq_get_irq_data(pit_irq));

OK.

> > +	irqprio = (hwirq >> 2) & PIT_PRIO_MASK;
> > +	enable_val = (1U << PIT_ENABLE_SHIFT)
> > +		   | (hwirq << PIT_IRQ_SHIFT)
> > +		   | (irqprio << PIT_PRIO_SHIFT);
> 
> 
> I'm missing the connection between the description above and the enable
> value computed here. Can you elaborate ?

The irqprio field is filled in using a value that matches bits 2 and
up of hwirq; this is what the comment says and what the code does. Can
you elaborate on what you don't understand?

Rich
