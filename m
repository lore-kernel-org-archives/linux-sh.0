From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 09 Oct 2016 09:14:20 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <alpine.DEB.2.20.1610091050500.5222@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org> <20160926222352.GE19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1609261936130.4915@nanos> <20160927004258.GF19318@brightrain.aerifal.cx> <20160927220820.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609301319410.4799@nanos> <20161008013210.GX19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610081312190.5222@nanos> <20161008162614.GY19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610081827170.5222@nanos>
 <20161009012810.GZ19318@brightrain.aerifal.cx>
In-Reply-To: <20161009012810.GZ19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Rich,

On Sat, 8 Oct 2016, Rich Felker wrote:
> On Sat, Oct 08, 2016 at 07:03:30PM +0200, Thomas Gleixner wrote:
> > Because you drop out the idle spin due to an interrupt, but no interrupt is
> > handled according to the trace. You just go back to sleep and the trace is
> > full of this behaviour.
> 
> Found the problem. IRQD_IRQ_INPROGRESS is causing the interrupt to be
> ignored if the same interrupt is being handled on the other cpu.
> Modifying the jcore aic driver to call handle_percpu_irq rather than
> handle_simple_irq when the irq was registered as percpu solves the
> problem, but I'm actually concerned that handle_simple_irq would also
> be wrong in the case of non-percpu irqs if they could be delivered on
> either core -- if another irq arrives after the driver is finished
> checking for new device status, but before the IRQD_IRQ_INPROGRESS
> flag is removed, it seems handle_simple_irq loses the irq. This is not
> a problem for the current hardware since non-percpu irqs always arrive
> on cpu0, but I'd rather improve the driver to properly handle possible
> future hardware that allows irq delivery on any core.

We guarantee no-rentrancy for the handlers. That's why we have special
treatment for per cpu interrupts and edge type interrupts, where we mark
the interrupt pending when it arrives before the in progress flag is
cleared and then call the handler again when it returns. For level type
interrupts this is not required because level is going to stay raised in
the hardware.

> > which is the wrong thing to do. You need request_percpu_irq() here, but of
> > course with the irq chip you are using, which has every callback as a noop,
> > it does not matter at all. So that's not an issue and not the reason for
> > this wreckage.
> 
> Mentioning this was helpful to get me looking at the right things
> tracking from the irq entry point to where the irq was lost/dropped,
> so thanks for bringing it up.

Duh, forgot about reentrancy. I should have thought about it when staring
at the traces. I noticed that the irq on the other cpu was handled exactly
at the same point, but I did not make the connection. In all hte
problematic cases there is this sequence:

          <idle>-0     [000] d.s.   150.861703: tick_irq_enter: update jiffies via irq
          <idle>-0     [001] d.h.   150.861827: irq_handler_entry: irq name=jcore_pit

i.e. the handler on cpu1 is invoked before cpu0 has reached
handle_simple_irq(). 

> request_irq ends up working fine still because IRQF_PERCPU causes
> __setup_irq to mark the irqdesc/irq_data as percpu, so that my handle
> function can treat it differently. Here's the patch that has it working:
 
> diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
> index 5e5e3bb..b53a8a5 100644
> --- a/drivers/irqchip/irq-jcore-aic.c
> +++ b/drivers/irqchip/irq-jcore-aic.c
> @@ -25,12 +25,20 @@
>  
>  static struct irq_chip jcore_aic;
>  
> +static void handle_jcore_irq(struct irq_desc *desc)
> +{
> +	if (irq_is_percpu(irq_desc_get_irq(desc)))
> +		handle_percpu_irq(desc);
> +	else
> +		handle_simple_irq(desc);
> +}
> +
>  static int jcore_aic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>  				   irq_hw_number_t hwirq)
>  {
>  	struct irq_chip *aic = d->host_data;
>  
> -	irq_set_chip_and_handler(irq, aic, handle_simple_irq);
> +	irq_set_chip_and_handler(irq, aic, handle_jcore_irq);

What you should do is:

     	if (jcore_irq_per_cpu(hwirq))
		irq_set_chip_and_handler(irq, aic, handle_percpu_irq);
	else
		irq_set_chip_and_handler(irq, aic, handle_simple_irq);
	
That avoids the conditional in the irq delivery path, which is overly
expensive as you end up looking up the irq descriptor which you already
have. You can avoid the lookup by using:

      if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))

but that's still a conditional in the hotpath which you can avoid entirely
by setting up the proper handler when you map it.

> Apologies for this big distraction for what was ultimately a driver
> bug on my side. I was misled by the way it seemed to be a regression,
> since the symptoms did not appear in earlier kernel versions for
> whatever reason (likely just chance).

No problem. Glad that I was able to help.

Thanks,

	tglx
