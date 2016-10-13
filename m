From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Thu, 13 Oct 2016 07:30:36 +0000
Subject: Re: [PATCH] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <20161013073036.GO29518@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <41fc74d0bdea4c0efc269150b78d72b2b26cb38c.1475992312.git.dalias@libc.org>
 <alpine.DEB.2.20.1610091301390.5222@nanos>
 <20161009144715.GB19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610092121460.7166@nanos>
 <20161011152140.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610121015080.5032@nanos>
 <20161012163543.GN19318@brightrain.aerifal.cx>
 <20161012203417.GA8847@linux.vnet.ibm.com>
 <20161012221927.GR19318@brightrain.aerifal.cx>
In-Reply-To: <20161012221927.GR19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Wed, Oct 12, 2016 at 06:19:27PM -0400, Rich Felker wrote:
> On Wed, Oct 12, 2016 at 01:34:17PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 12, 2016 at 12:35:43PM -0400, Rich Felker wrote:
> > > On Wed, Oct 12, 2016 at 10:18:02AM +0200, Thomas Gleixner wrote:
> > > > On Tue, 11 Oct 2016, Rich Felker wrote:
> > > > > On Sun, Oct 09, 2016 at 09:23:58PM +0200, Thomas Gleixner wrote:
> > > > > > On Sun, 9 Oct 2016, Rich Felker wrote:
> > > > > > > On Sun, Oct 09, 2016 at 01:03:10PM +0200, Thomas Gleixner wrote:
> > > > > > > My preference would just be to keep the branch, but with your improved
> > > > > > > version that doesn't need a function call:
> > > > > > > 
> > > > > > > 	irqd_is_per_cpu(irq_desc_get_irq_data(desc))
> > > > > > >
> > > > > > > While there is some overhead testing this condition every time, I can
> > > > > > > probably come up with several better places to look for a ~10 cycle
> > > > > > > improvement in the irq code path without imposing new requirements on
> > > > > > > the DT bindings.
> > > > > > 
> > > > > > Fair enough. Your call.
> > > > > >  
> > > > > > > As noted in my followup to the clocksource stall thread, there's also
> > > > > > > a possibility that it might make sense to consider the current
> > > > > > > behavior of having non-percpu irqs bound to a particular cpu as part
> > > > > > > of what's required by the compatible tag, in which case
> > > > > > > handle_percpu_irq or something similar/equivalent might be suitable
> > > > > > > for both the percpu and non-percpu cases. I don't understand the irq
> > > > > > > subsystem well enough to insist on that but I think it's worth
> > > > > > > consideration since it looks like it would improve performance of
> > > > > > > non-percpu interrupts a bit.
> > > > > > 
> > > > > > Well, you can use handle_percpu_irq() for your device interrupts if you
> > > > > > guarantee at the hardware level that there is no reentrancy. Once you make
> > > > > > the hardware capable of delivering them on either core the picture changes.
> > > > > 
> > > > > One more concern here -- I see that handle_simple_irq is handling the
> > > > > soft-disable / IRQS_PENDING flag behavior, and irq_check_poll stuff
> > > > > that's perhaps important too. Since soft-disable is all we have
> > > > > (there's no hard-disable of interrupts), is this a problem? In other
> > > > > words, can drivers have an expectation of not receiving interrupts
> > > > > when the irq is disabled? I would think anything compatible with irq
> > > > > sharing can't have such an expectation, but perhaps the kernel needs
> > > > > disabling internally for synchronization at module-unload time or
> > > > > similar cases?
> > > > 
> > > > Sure. A driver would be surprised getting an interrupt when it is disabled,
> > > > but with your exceptionally well thought out interrupt controller a pending
> > > > (level) interrupt which is not handled will be reraised forever and just
> > > > hard lock the machine.
> > > 
> > > If you want to criticize the interrupt controller design (not my work
> > > or under my control) for limitations in the type of hardware that can
> > > be hooked up to it, that's okay -- this kind of input will actually be
> > > useful for designing the next iteration of it -- but I don't think
> > > this specific possibility is a concern.
> > 
> > Well, if this scenario does happen, the machine will likely either lock
> > up silently and hard, give you RCU CPU stall warning messages, or give
> > you soft-lockup messages.
> 
> The same situation can happen with badly-behaved hardware under
> software interrupt control too if it keeps generating interrupts
> rapidly (more quickly than the cpu can handle them), unless the kernel
> has some kind of framework for disabling the interrupt and only
> reenabling it later via a timer. It's equivalent to a realtime-prio
> process failing to block/sleep to give lower-priority processes a
> chance to run.

Indeed, there are quite a few scenarios that can lead to silent hard
lockups, RCU CPU stall warning messages, or soft-lockup messages.

							Thanx, Paul

