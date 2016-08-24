From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 24 Aug 2016 22:21:01 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160824222059.GA2662@remoulade>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <20160824200152.33be0707@arm.com>
 <20160824192009.GX15995@brightrain.aerifal.cx>
In-Reply-To: <20160824192009.GX15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Hi,

On Wed, Aug 24, 2016 at 03:20:09PM -0400, Rich Felker wrote:
> On Wed, Aug 24, 2016 at 08:01:52PM +0100, Marc Zyngier wrote:
> > On Wed, 24 Aug 2016 13:40:01 -0400
> > Rich Felker <dalias@libc.org> wrote:
> > 
> > [...]
> > 
> > > > IIUC, there is a problem with the interrupt controller where
> > the per irq
> > > > line are not working correctly. Is that correct ?  
> > > 
> > > I don't think that's a correct characterization. Rather the percpu
> > > infrastructure just means something completely different from what you
> > > would expect it to mean. It has nothing to do with the hardware but
> > > rather with kernel-internal choice of whether to do percpu devid
> > > mapping inside the irq infrastructure, and the choice at the
> > > irq-requester side of whether to do this is required to match the
> > > irqchip driver's choice. I explained this better in another email
> > > which I could dig up if necessary, but the essence is that
> > > request_percpu_irq is a misnamed and unusably broken API.
> 
> For reference, here's the thread I was referring to:
> 
> https://lkml.org/lkml/2016/7/15/585

That reply seems to imply that the percpu_irq functionality is only there to
shift a percpu pointer, and that any IRQ can be treated either as a 'regular'
interrupt or a percpu one. That's not really the case, and I'm worried that
this implies that the way your hardware and driver behaves violates (implicit)
assumptions made by core code. Please see below for more details and questions.

The percpu IRQ infrastructure was added to handle things like SPI (Shared
Peripheral Interrupt) vs PPI (Private Peripheral Interrupt) on ARM GICs
(Generic Interrupt Controllers), where the two classses of interrupt are
distinct, and the latter is very much a per-cpu resource in hardware, while the
former is not. In the GIC, particular IRQ IDs are reserved for each class,
making them possible to distinguish easily.

Consider an ARM system with N CPUs, a GIC, some CPU-local timers (wired as
PPIs), and some other peripherals (wired as SPIs).

For each SPI, it is as if there is a single wire into the GIC. An SPI can be
programmatically configured to be routed to any arbitrary CPU (or several, if
one really wants that), but it's fundamentally a single interrupt, and there is
a single GIC state machine for it (even if it's routed to multiple CPUs
simultaneously). Any state for this class of interrupt can/must be protected by
some global lock or other synchronisation mechanism, as two CPUs can't take the
same SPI simultaneously, though the affinity might be changed at any point.

For each PPI, it is as if there are N wires into the GIC, each attached to a
CPU-affine device. It's effectively a group of N interrupts for a particular
purpose, sharing the same ID. Each wire is routed to a particular CPU (which
cannot be changed), and there is an independent GIC state machine per-cpu
(accessed through registers which are banked per-cpu). Any state for this class
of interrupt can/must be protected by some per-cpu lock or other
synchronisation mechanism, as the instances of the interrupt can be taken on
multiple CPUs simultaneously.

The above is roughly what Linux understands today as the distinction between a
'regular' and percpu interrupt. As above, you cannot freely treat either as the
other -- it is a hardware property. If you took the same regular interrupt on
different CPUs simultaneously, the core IRQ system is liable to be confused, as
it does not expect this to happen -- e.g. if for some reason we had some global
lock or accounting data structure.

Note that you could have some percpu resource using N SPIs. That would not be a
percpu irq, even if you only want to handle each interrupt on a particular CPU.

With contrast to the above, can you explain how your interrupts behave?

Is the routing to a CPU or CPUs fixed?

Are there independent state machines per-cpu for your timer interrupt in the
interrupt controller hardware?

> > Or just one that simply doesn't fit your needs, because other
> > architectures have different semantics than the ones you take for
> > granted?
> 
> I don't think so. The choice of whether to have the irq layer or the
> driver's irq handler be responsible for handling a percpu pointer has
> nothing to do with the hardware.

As above, percpu interrupts are not just about shifting pointers. Using the
correct class is critical to continued correct operation.

> Perhaps the intent was that the irqchip driver always knows whether a
> given hwirq[-range] is associated with per-cpu events or global events
> for which it doesn't matter what cpu they're delivered on.

So far, the assumption has been that the irqchip (driver) knows whether a
particular hwirq is regular or percpu.

> In this case, the situations where you may want percpu dev_id mapping line up
> with some property of the hardware. However that need not be the case, and
> it's not when the choice of irq is programmable.

I guess this depends on the behaviour of your HW. Does the timer interrupt
behave like the GIC PPI I explained above? I assume others behave like the GIC
SPI? What happens if you route one of those to multiple CPUs?

If the distinctions largely matches SPI/PPI, other than the lack of a fixed ID,
there are ways we can solve this, e.g. annotating percpu interrupts in the DT
with a flag, and deferring their initialisation to the first request.

> > > > Regarding Marc Zyngier comments about the irq controller driver being
> > > > almost empty, I'm wondering if something in the irq controller driver
> > > > which shouldn't be added before submitting this timer driver with SMP
> > > > support (eg. irq domain ?).  
> > > 
> > > I don't think so. At most I could make the driver hard-code the percpu
> > > devid model for certain irqs, but that _does not reflect_ anything
> > > about the hardware. Rather it just reflects bad kernel internals. It
> > 
> > I'd appreciate it if instead of ranting about how broken the kernel is,
> > you'd submit a patch fixing it, since you seem to have spotted
> > something that we haven't in several years of using that code on a
> > couple of ARM-related platforms.
> 
> I didn't intend for this to be a rant. I'm not demanding that it be
> changed; I'm only objecting to being asked to make the driver use a
> framework that it doesn't need and that can't model what needs to be
> done. But I'm happy to discuss whether you would be open to such a
> change, and if so, to write and submit a patch. The ideas for what it
> would involve are in the linked email, quoted here:
> 
>    "... This is because the irq controller driver must, at irqdomain
>     mapping time, decide whether to register the handler as
>     handle_percpu_devid_irq (which interprets dev_id as a __percpu
>     pointer and remaps it for the local cpu before invoking the
>     driver's handler) or one of the other handlers that does not
>     perform any percpu remapping.
> 
>     The right way for this to work would be for
>     handle_irq_event_percpu to be responsible for the remapping, but
>     do it conditionally on whether the irq was requested via
>     request_irq or request_percpu_irq."

As above, I don't think that this is quite the right approach, as this allows
one to erroneously handle distinct classes of interrupt as one another.

I agree that in the case that the percpu-ness of a hwirq number is not fixed
property of the interrupt-controller, we may need to defer initialisation until
the request (where we can query the DT, say).

Thanks,
Mark.
