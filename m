From: Rich Felker <dalias@libc.org>
Date: Sun, 09 Oct 2016 22:06:16 +0000
Subject: Re: [PATCH] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <20161009220616.GD19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <41fc74d0bdea4c0efc269150b78d72b2b26cb38c.1475992312.git.dalias@libc.org>
 <alpine.DEB.2.20.1610091301390.5222@nanos>
 <20161009144715.GB19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610092121460.7166@nanos>
In-Reply-To: <alpine.DEB.2.20.1610092121460.7166@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Sun, Oct 09, 2016 at 09:23:58PM +0200, Thomas Gleixner wrote:
> On Sun, 9 Oct 2016, Rich Felker wrote:
> > On Sun, Oct 09, 2016 at 01:03:10PM +0200, Thomas Gleixner wrote:
> > My preference would just be to keep the branch, but with your improved
> > version that doesn't need a function call:
> > 
> > 	irqd_is_per_cpu(irq_desc_get_irq_data(desc))
> >
> > While there is some overhead testing this condition every time, I can
> > probably come up with several better places to look for a ~10 cycle
> > improvement in the irq code path without imposing new requirements on
> > the DT bindings.
> 
> Fair enough. Your call.

Thanks.

> > As noted in my followup to the clocksource stall thread, there's also
> > a possibility that it might make sense to consider the current
> > behavior of having non-percpu irqs bound to a particular cpu as part
> > of what's required by the compatible tag, in which case
> > handle_percpu_irq or something similar/equivalent might be suitable
> > for both the percpu and non-percpu cases. I don't understand the irq
> > subsystem well enough to insist on that but I think it's worth
> > consideration since it looks like it would improve performance of
> > non-percpu interrupts a bit.
> 
> Well, you can use handle_percpu_irq() for your device interrupts if you
> guarantee at the hardware level that there is no reentrancy.

Reentrancy is possible of course if the kernel enables irqs during the
irq handler. Is not doing so a stable part of the kernel irq
subsystem? My understanding is that modern kernels keep irqs disabled
for the full duration of (hard) irq handlers.

> Once you make
> the hardware capable of delivering them on either core the picture changes.

*nod* Perhaps if/when we do that, the path of least resistence would
be to adjust the irq numbering so that percpu (i.e., hard-routed to a
particular cpu) and global irqs (deliverable on any core) are in
different ranges and the existing kernel frameworks work.

Rich
