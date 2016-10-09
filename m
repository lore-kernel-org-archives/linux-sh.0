From: Rich Felker <dalias@libc.org>
Date: Sun, 09 Oct 2016 14:35:06 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161009143506.GA19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.20.1609261936130.4915@nanos>
 <20160927004258.GF19318@brightrain.aerifal.cx>
 <20160927220820.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609301319410.4799@nanos>
 <20161008013210.GX19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610081312190.5222@nanos>
 <20161008162614.GY19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610081827170.5222@nanos>
 <20161009012810.GZ19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610091050500.5222@nanos>
In-Reply-To: <alpine.DEB.2.20.1610091050500.5222@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Sun, Oct 09, 2016 at 11:14:20AM +0200, Thomas Gleixner wrote:
> Rich,
> 
> On Sat, 8 Oct 2016, Rich Felker wrote:
> > On Sat, Oct 08, 2016 at 07:03:30PM +0200, Thomas Gleixner wrote:
> > > Because you drop out the idle spin due to an interrupt, but no interrupt is
> > > handled according to the trace. You just go back to sleep and the trace is
> > > full of this behaviour.
> > 
> > Found the problem. IRQD_IRQ_INPROGRESS is causing the interrupt to be
> > ignored if the same interrupt is being handled on the other cpu.
> > Modifying the jcore aic driver to call handle_percpu_irq rather than
> > handle_simple_irq when the irq was registered as percpu solves the
> > problem, but I'm actually concerned that handle_simple_irq would also
> > be wrong in the case of non-percpu irqs if they could be delivered on
> > either core -- if another irq arrives after the driver is finished
> > checking for new device status, but before the IRQD_IRQ_INPROGRESS
> > flag is removed, it seems handle_simple_irq loses the irq. This is not
> > a problem for the current hardware since non-percpu irqs always arrive
> > on cpu0, but I'd rather improve the driver to properly handle possible
> > future hardware that allows irq delivery on any core.
> 
> We guarantee no-rentrancy for the handlers. That's why we have special
> treatment for per cpu interrupts and edge type interrupts, where we mark
> the interrupt pending when it arrives before the in progress flag is
> cleared and then call the handler again when it returns. For level type
> interrupts this is not required because level is going to stay raised in
> the hardware.

I understand the no-reentrancy guarantee, but it seems that, for a
"simple" irq with no ack/etc. mechanisms, if another interrupt has
arrives during handling, a flag for that has to be kept and the
interrupt handler re-invoked after the first return. Otherwise
interrupts are lost. Perhaps handle_simple_irq is written with the
intent that individual drivers have to do something ack-like with
their hardware. If so then it's not the right handler (although it
works at present as long as non-percpu interrupts are bound to a
single cpu at the hardware level) and I should probably write an
appropriate handle function.

Or, if we want to consider the current behavior a guarantee so that
changing it would require a new compatible string, then
handle_percpu_irq or an equivalently simpler function could be used
even for non-percpu irqs and avoid all the locking overhead. This
would save a lot more time in the hot path than eliminating the one
conditional (as discussed below below).

> > request_irq ends up working fine still because IRQF_PERCPU causes
> > __setup_irq to mark the irqdesc/irq_data as percpu, so that my handle
> > function can treat it differently. Here's the patch that has it working:
>  
> > diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
> > index 5e5e3bb..b53a8a5 100644
> > --- a/drivers/irqchip/irq-jcore-aic.c
> > +++ b/drivers/irqchip/irq-jcore-aic.c
> > @@ -25,12 +25,20 @@
> >  
> >  static struct irq_chip jcore_aic;
> >  
> > +static void handle_jcore_irq(struct irq_desc *desc)
> > +{
> > +	if (irq_is_percpu(irq_desc_get_irq(desc)))
> > +		handle_percpu_irq(desc);
> > +	else
> > +		handle_simple_irq(desc);
> > +}
> > +
> >  static int jcore_aic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >  				   irq_hw_number_t hwirq)
> >  {
> >  	struct irq_chip *aic = d->host_data;
> >  
> > -	irq_set_chip_and_handler(irq, aic, handle_simple_irq);
> > +	irq_set_chip_and_handler(irq, aic, handle_jcore_irq);
> 
> What you should do is:
> 
>      	if (jcore_irq_per_cpu(hwirq))
> 		irq_set_chip_and_handler(irq, aic, handle_percpu_irq);
> 	else
> 		irq_set_chip_and_handler(irq, aic, handle_simple_irq);
> 	
> That avoids the conditional in the irq delivery path,

I'll follow up on this in the thread on the patch.

> which is overly
> expensive as you end up looking up the irq descriptor which you already
> have. You can avoid the lookup by using:
> 
>       if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
> 
> but that's still a conditional in the hotpath which you can avoid entirely
> by setting up the proper handler when you map it.

Indeed that helps. Having CONFIG_FRAME_POINTER on was making both
versions huge (because of the implicit -fno-optimize-sibling-calls)
but with that off, it's much more reasonable.

Rich
