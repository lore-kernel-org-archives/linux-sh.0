From: Rich Felker <dalias@libc.org>
Date: Sun, 09 Oct 2016 14:47:15 +0000
Subject: Re: [PATCH] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <20161009144715.GB19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <41fc74d0bdea4c0efc269150b78d72b2b26cb38c.1475992312.git.dalias@libc.org>
 <alpine.DEB.2.20.1610091301390.5222@nanos>
In-Reply-To: <alpine.DEB.2.20.1610091301390.5222@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Sun, Oct 09, 2016 at 01:03:10PM +0200, Thomas Gleixner wrote:
> On Sun, 9 Oct 2016, Rich Felker wrote:
> > Ideas for improvement are welcome -- for example the
> > irq_is_percpu(irq_desc_get_irq(desc)) thing looks rather silly but I
> 
> See the other mail.
> 
> > didn't see a better way without poking through abstractions -- but
> > overall I think this both solves the timer stall issue that I wasted
> > other people's time on, and addresses the concerns about the J-Core
> > AIC driver being oblivious to whether an irq is per-cpu.
> 
> You could put that knowledge into the device tree so you can decide at
> mapping time whether it is per cpu or not.

As discussed in the previous thread(s?) on the percpu topic, I'd
really rather avoid doing this. There's both the conceptual aspect
that it's redundant information in the DT that's only there for the
sake of making the kernel irq system happier (i.e. if there were a
code path to allow it, the handler type could be set at request_irq
time with knowledge of the flags rather than requiring the irqchip
driver to already have duplicate knowledge of this), and a couple
practical issues.

One simply relates back to redundancy -- I'd like to avoid making the
DT bigger since it's likely desirable to have the DT embedded in
internal ROM in ASICs. But the other big issue is that we already have
devices in the field using the existing DT bindings.

My preference would just be to keep the branch, but with your improved
version that doesn't need a function call:

	irqd_is_per_cpu(irq_desc_get_irq_data(desc))

While there is some overhead testing this condition every time, I can
probably come up with several better places to look for a ~10 cycle
improvement in the irq code path without imposing new requirements on
the DT bindings.

If that's really not acceptable, an alternative proposal would be a
new optional DT property that would give the irqchip driver sufficient
knowledge to bind the proper handler directly at mapping time, and
then handle_jcore_irq would be needed only in the fallback case where
this property is missing.

As noted in my followup to the clocksource stall thread, there's also
a possibility that it might make sense to consider the current
behavior of having non-percpu irqs bound to a particular cpu as part
of what's required by the compatible tag, in which case
handle_percpu_irq or something similar/equivalent might be suitable
for both the percpu and non-percpu cases. I don't understand the irq
subsystem well enough to insist on that but I think it's worth
consideration since it looks like it would improve performance of
non-percpu interrupts a bit.

Rich
