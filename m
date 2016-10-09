From: Rich Felker <dalias@libc.org>
Date: Sun, 09 Oct 2016 01:28:10 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161009012810.GZ19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20160926222352.GE19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609261936130.4915@nanos>
 <20160927004258.GF19318@brightrain.aerifal.cx>
 <20160927220820.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609301319410.4799@nanos>
 <20161008013210.GX19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610081312190.5222@nanos>
 <20161008162614.GY19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610081827170.5222@nanos>
In-Reply-To: <alpine.DEB.2.20.1610081827170.5222@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Sat, Oct 08, 2016 at 07:03:30PM +0200, Thomas Gleixner wrote:
> On Sat, 8 Oct 2016, Rich Felker wrote:
> > On Sat, Oct 08, 2016 at 01:32:06PM +0200, Thomas Gleixner wrote:
> > > CPU spins and waits for an interrupt to happen
> > > 
> > > 
> > >           <idle>-0     [000] d...   150.841530: rcu_dyntick: End 0 1
> > > 
> > > Dropping out of the spin about the time we expect the PIT interrupt to
> > > fire. And an interrupt is the reason why we drop out because the 'need
> > > resched' flag is not set and we end up in:
> > 
> > OK, I missed that.
> > 
> > >           <idle>-0     [000] d.s.   150.841724: tick_irq_enter: update jiffies via irq
> > > 
> > > which is called from irq_enter()
> > > 
> > >           <idle>-0     [000] d.s.   150.841918: tick_do_update_jiffies64: finished do_timer(1)
> > >           <idle>-0     [000] d.s.   150.842348: tick_do_update_jiffies64: finished updating jiffies
> > > 
> > > 
> > > So here we would expect:
> > > 
> > >     	 irq_handler_entry: irq name=jcore_pit
> > > 	 ...
> > > 	 irq_handler_exit .....
> > >     	 
> > > 
> > > or any other interrupt being invoked. But we see this here:
> > 
> > According to the trace the 'irq' is soft ('s'). I couldn't find the
> > code path from the idle loop to softirq but so maybe this is a bug. Is
> > it possible that in some cases the arch irq entry does not get
> > identified as a hard irq or traced and then the subsequent tick code
> > thinks it's running in a softirq and behaves differently? I could add
> > more tracing around irq entry.
> 
> No.
> 
> irq_enter()
> 	if (is_idle_task(current) && !in_interrupt()) {
> 	   	local_bh_disable();
> 		tick_irq_enter();
> 		local_bh_enable();
> 	}
> 	__irq_enter()
> 		preempt_count_add(HARDIRQ_OFFSET);
> 
> So the 's' comes from local_bh_disable() and the code does not behave
> special because of that. It's just always that way. Look at all the other
> instances of tick_irq_enter() which do not show that issue.

Thank you -- that was really confusing me. Now that I know there's
actually a hardirq handling I know where to look for the problem.

> > >           <idle>-0     [000] d...   150.842603: __tick_nohz_idle_enter: can stop idle tick
> > > 
> > > And that's just wrong. 
> > 
> > Can you explain?
> 
> Because you drop out the idle spin due to an interrupt, but no interrupt is
> handled according to the trace. You just go back to sleep and the trace is
> full of this behaviour.

Found the problem. IRQD_IRQ_INPROGRESS is causing the interrupt to be
ignored if the same interrupt is being handled on the other cpu.
Modifying the jcore aic driver to call handle_percpu_irq rather than
handle_simple_irq when the irq was registered as percpu solves the
problem, but I'm actually concerned that handle_simple_irq would also
be wrong in the case of non-percpu irqs if they could be delivered on
either core -- if another irq arrives after the driver is finished
checking for new device status, but before the IRQD_IRQ_INPROGRESS
flag is removed, it seems handle_simple_irq loses the irq. This is not
a problem for the current hardware since non-percpu irqs always arrive
on cpu0, but I'd rather improve the driver to properly handle possible
future hardware that allows irq delivery on any core.

> > > Both CPUs have the same interrupt number for their per cpu PIT interrupt.
> > > 
> > > IIRC you said earlier when the percpu interrupt discussion happened, that
> > > your per cpu PITs have distinct interrupt numbers, but that does not seem
> > > the case here.
> > 
> > No, I said the opposite. They use the same irq number but they're each
> > wired to their own cpu, and there's no way for them to fire on the
> > wrong cpu.
> 
> Your patch does:
> 
> > +       err = request_irq(pit_irq, jcore_timer_interrupt,
> > +                         IRQF_TIMER | IRQF_PERCPU,
> > +                         "jcore_pit", jcore_pit_percpu);
> 
> which is the wrong thing to do. You need request_percpu_irq() here, but of
> course with the irq chip you are using, which has every callback as a noop,
> it does not matter at all. So that's not an issue and not the reason for
> this wreckage.

Mentioning this was helpful to get me looking at the right things
tracking from the irq entry point to where the irq was lost/dropped,
so thanks for bringing it up. request_irq ends up working fine still
because IRQF_PERCPU causes __setup_irq to mark the irqdesc/irq_data as
percpu, so that my handle function can treat it differently. Here's
the patch that has it working:

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5e5e3bb..b53a8a5 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -25,12 +25,20 @@
 
 static struct irq_chip jcore_aic;
 
+static void handle_jcore_irq(struct irq_desc *desc)
+{
+	if (irq_is_percpu(irq_desc_get_irq(desc)))
+		handle_percpu_irq(desc);
+	else
+		handle_simple_irq(desc);
+}
+
 static int jcore_aic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 				   irq_hw_number_t hwirq)
 {
 	struct irq_chip *aic = d->host_data;
 
-	irq_set_chip_and_handler(irq, aic, handle_simple_irq);
+	irq_set_chip_and_handler(irq, aic, handle_jcore_irq);
 
 	return 0;
 }

After some more testing I'll send this patch or something similar.

> But what you need to figure out is why this happens:
> 
> 100.00x	 hrtimer_start(expires = 100.01)
> 100.00x	 idle spin
> 100.01x	 tick_irq_enter()
> 100.01x	 tick_stop()
> 
> i.e. why do you drop out of your idle spin, take the low level interrupt
> entry path which calls irq_enter() -> tick_irq_enter() and then you do not
> handle any interrupt at all and drop back into the idle loop. That's the
> real question and that's a problem in your architecture low level interrupt
> entry code or some hardware related issue. But certainly not a bug in the
> core tick code.
> 
> You can come up with another boat load of weird theories about bugs in
> that code, but I won't even have a look _before_ you can explain why the
> above sequence happens and the PIT timer interrupt is not handled.

Apologies for this big distraction for what was ultimately a driver
bug on my side. I was misled by the way it seemed to be a regression,
since the symptoms did not appear in earlier kernel versions for
whatever reason (likely just chance).

Rich
