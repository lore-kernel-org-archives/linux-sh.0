From: Rich Felker <dalias@libc.org>
Date: Thu, 04 Aug 2016 19:42:39 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160804194238.GL15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <20160804082451.GA2509@localhost>
In-Reply-To: <20160804082451.GA2509@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexnader Kuleshov <kuleshovmail@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Thu, Aug 04, 2016 at 02:24:51PM +0600, Alexnader Kuleshov wrote:
> Hello Rich,
> 
> On 08-04-16, Rich Felker wrote:
> > At the hardware level, the J-Core PIT is integrated with the interrupt
> > controller, but it is represented as its own device and has an
> > independent programming interface. It provides a 12-bit countdown
> > timer, which is not presently used, and a periodic timer. The interval
> > length for the latter is programmable via a 32-bit throttle register
> > whose units are determined by a bus-period register. The periodic
> > timer is used to implement both periodic and oneshot clock event
> > modes; in oneshot mode the interrupt handler simply disables the timer
> > as soon as it fires.
> >
> > Despite its device tree node representing an interrupt for the PIT,
> > the actual irq generated is programmable, not hard-wired. The driver
> > is responsible for programming the PIT to generate the hardware irq
> > number that the DT assigns to it.
> >
> > On SMP configurations, J-Core provides cpu-local instances of the PIT;
> > no broadcast timer is needed. This driver supports the creation of the
> > necessary per-cpu clock_event_device instances. The code has been
> > tested and works on SMP, but will not be usable without additional
> > J-Core SMP-support patches and appropriate hardware capable of running
> > SMP.
> >
> > A nanosecond-resolution clocksource is provided using the J-Core "RTC"
> > registers, which give a 64-bit seconds count and 32-bit nanoseconds.
> > The driver converts these to a 64-bit nanoseconds count.
> >
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ...
> > ...
> > ...
> > +
> > +static int jcore_pit_set_state_shutdown(struct clock_event_device *ced)
> > +{
> > +	struct jcore_pit *pit = container_of(ced, struct jcore_pit, ced);
> > +
> > +	return jcore_pit_disable(pit);
> > +}
> > +
> > +static int jcore_pit_set_state_oneshot(struct clock_event_device *ced)
> > +{
> > +	struct jcore_pit *pit = container_of(ced, struct jcore_pit, ced);
> > +
> > +	return jcore_pit_disable(pit);
> > +}
> 
> Maybe to use only jcore_pit_set_state_shutdown() for both shutdown/oneshot
> states as it is implemented for some of others clocksource drivers?
> 
> all the more so as described in your commit message, they do the same:
> 
> > in oneshot mode the interrupt handler simply disables the timer
> > as soon as it fires
> 
> right?

I separated these out semantically due to another request earlier in
this patch's life cycle. At this point I feel like issues like this
are really a bikeshed, and rather than changing trivial details back
and forth over and over I'd like to see it go upstream so that I don't
have to keep rebasing it on infrastructure that's changing underneath
it.

> > +static int __init jcore_pit_init(struct device_node *node)
> > +{
> > +	int err;
> > +	unsigned pit_irq, cpu;
> > +	unsigned long hwirq;
> > +	u32 irqprio, enable_val;
> > +
> > +	jcore_pit_base = of_iomap(node, 0);
> > +	if (!jcore_pit_base) {
> > +		pr_err("Error: Cannot map base address for J-Core PIT\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	pit_irq = irq_of_parse_and_map(node, 0);
> > +	if (!pit_irq) {
> > +		pr_err("Error: J-Core PIT has no IRQ\n");
> > +		return -ENXIO;
> > +	}
> > +
> > +	pr_info("Initializing J-Core PIT at %p IRQ %d\n",
> > +		jcore_pit_base, pit_irq);
> > +
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
> > +
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
> free_percpu() missed in a case when request_irq() failed.

Shall I submit a new version with this change? I don't think it's
particular useful since you're not going to have a working system if
the timer fails to initialize anyway, but I can do it if desired.

Rich
