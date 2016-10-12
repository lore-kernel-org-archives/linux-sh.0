From: Rich Felker <dalias@libc.org>
Date: Wed, 12 Oct 2016 16:35:43 +0000
Subject: Re: [PATCH] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <20161012163543.GN19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <41fc74d0bdea4c0efc269150b78d72b2b26cb38c.1475992312.git.dalias@libc.org>
 <alpine.DEB.2.20.1610091301390.5222@nanos>
 <20161009144715.GB19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610092121460.7166@nanos>
 <20161011152140.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610121015080.5032@nanos>
In-Reply-To: <alpine.DEB.2.20.1610121015080.5032@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, Oct 12, 2016 at 10:18:02AM +0200, Thomas Gleixner wrote:
> On Tue, 11 Oct 2016, Rich Felker wrote:
> > On Sun, Oct 09, 2016 at 09:23:58PM +0200, Thomas Gleixner wrote:
> > > On Sun, 9 Oct 2016, Rich Felker wrote:
> > > > On Sun, Oct 09, 2016 at 01:03:10PM +0200, Thomas Gleixner wrote:
> > > > My preference would just be to keep the branch, but with your improved
> > > > version that doesn't need a function call:
> > > > 
> > > > 	irqd_is_per_cpu(irq_desc_get_irq_data(desc))
> > > >
> > > > While there is some overhead testing this condition every time, I can
> > > > probably come up with several better places to look for a ~10 cycle
> > > > improvement in the irq code path without imposing new requirements on
> > > > the DT bindings.
> > > 
> > > Fair enough. Your call.
> > >  
> > > > As noted in my followup to the clocksource stall thread, there's also
> > > > a possibility that it might make sense to consider the current
> > > > behavior of having non-percpu irqs bound to a particular cpu as part
> > > > of what's required by the compatible tag, in which case
> > > > handle_percpu_irq or something similar/equivalent might be suitable
> > > > for both the percpu and non-percpu cases. I don't understand the irq
> > > > subsystem well enough to insist on that but I think it's worth
> > > > consideration since it looks like it would improve performance of
> > > > non-percpu interrupts a bit.
> > > 
> > > Well, you can use handle_percpu_irq() for your device interrupts if you
> > > guarantee at the hardware level that there is no reentrancy. Once you make
> > > the hardware capable of delivering them on either core the picture changes.
> > 
> > One more concern here -- I see that handle_simple_irq is handling the
> > soft-disable / IRQS_PENDING flag behavior, and irq_check_poll stuff
> > that's perhaps important too. Since soft-disable is all we have
> > (there's no hard-disable of interrupts), is this a problem? In other
> > words, can drivers have an expectation of not receiving interrupts
> > when the irq is disabled? I would think anything compatible with irq
> > sharing can't have such an expectation, but perhaps the kernel needs
> > disabling internally for synchronization at module-unload time or
> > similar cases?
> 
> Sure. A driver would be surprised getting an interrupt when it is disabled,
> but with your exceptionally well thought out interrupt controller a pending
> (level) interrupt which is not handled will be reraised forever and just
> hard lock the machine.

If you want to criticize the interrupt controller design (not my work
or under my control) for limitations in the type of hardware that can
be hooked up to it, that's okay -- this kind of input will actually be
useful for designing the next iteration of it -- but I don't think
this specific possibility is a concern. The controller is designed for
SoC-internal use with devices that behave well, and not for level
interrupts that require device-specific action to clear (the clearing
of pending status is non-device-specific and takes place at the time
the interrupt is accepted by the cpu). It might end up being that it
makes sense to keep the AIC2 as-is but attach a separate, more
general-purpose global interrupt cuntroller that can route to any
cpu's AIC and that's friendlier to diverse external hardware (like the
type of level interrupts you described) but the hardware team would
know better than me.

> > If you think any of these things are problems I'll switch back to the
> > conditional version rather than using handle_percpu_irq for
> > everything.
> 
> It might be the approach of least surprise, but it won't make a difference
> for the situation described above.

I'm not seeing any easily measurable performance difference with the
version using the conditional, so I'm going to submit that as a v3.
Whether or not there's actually a safety concern, I'm not sure, but
I'd rather use the functions the way they were intended to be used so
we don't have to worry about unexpected bugs or regressions if the
internals change.

Rich
