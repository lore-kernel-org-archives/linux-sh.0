From: Rich Felker <dalias@libc.org>
Date: Fri, 15 Jul 2016 18:19:35 +0000
Subject: Re: [PATCH v3 08/12] irqchip: add J-Core AIC driver
Message-Id: <20160715181934.GU15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <05a5be0a4f1471272dcdd2259e4d97642ee43759.1464148904.git.dalias@libc.org>
 <20160715012750.GQ15995@brightrain.aerifal.cx>
In-Reply-To: <20160715012750.GQ15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Thu, Jul 14, 2016 at 09:27:50PM -0400, Rich Felker wrote:
> On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> > There are two versions of the J-Core interrupt controller in use, aic1
> > which generates interrupts with programmable priorities, but only
> > supports 8 irq lines and maps them to cpu traps in the range 17 to 24,
> > and aic2 which uses traps in the range 64-127 and supports up to 128
> > irqs, with priorities dependent on the interrupt number. The Linux
> > driver does not make use of priorities anyway.
> > 
> > For simplicity, there is no aic1-specific logic in the driver beyond
> > setting the priority register, which is necessary for interrupts to
> > work at all. Eventually aic1 will likely be phased out, but it's
> > currently in use in deployments and all released bitstream binaries.
> 
> Any comments on changes I should make in resubmitting this for the 4.8
> merge window? I could somewhat restrict the possible irqs, but aic1
> allows the pit to be programmed to generate any trap number you want,
> despite the hard-wired interrupts being limited to the range 17-24.
> 
> It might make sense to do something to allow percpu irq requests, but
> I couldn't figure out how to make them work and the current timer
> driver (that needs per-cpu irq delivery) just requests its irq through
> normal request_irq and lets the hardware do the right thing.

I've looked into this some more, and the request_percpu_irq system
looks misdesigned and unusable. It requires the IRQ controller driver
to know in advance, before it knows what devices/drivers are connected
to it, whether each irq will be used with a __percpu dev_id, and this
is not a property of the irq controller hardware or the connected
peripheral device hardware, but rather of the _driver_ for the
connected hardware. This is because the irq controller driver must, at
irqdomain mapping time, decide whether to register the handler as
handle_percpu_devid_irq (which interprets dev_id as a __percpu pointer
and remaps it for the local cpu before invoking the driver's handler)
or one of the other handlers that does not perform any percpu
remapping.

The right way for this to work would be for handle_irq_event_percpu to
be responsible for the remapping, but do it conditionally on whether
the irq was requested via request_irq or request_percpu_irq.

In the mean time until this is overhauled correctly, I believe drivers
(in my case, the J-Core timer driver and IPI "driver") should just
call request_irq with the IRQF_PERCPU flag (to ensure the handler runs
on the cpu the irq was received for) and should do their own
this_cpu_ptr(dev_id) as needed.

Rich
