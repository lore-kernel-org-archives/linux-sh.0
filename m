From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 09 Oct 2016 23:27:56 +0000
Subject: Re: [PATCH] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <alpine.DEB.2.20.1610100125200.7166@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <41fc74d0bdea4c0efc269150b78d72b2b26cb38c.1475992312.git.dalias@libc.org> <alpine.DEB.2.20.1610091301390.5222@nanos> <20161009144715.GB19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610092121460.7166@nanos>
 <20161009220616.GD19318@brightrain.aerifal.cx>
In-Reply-To: <20161009220616.GD19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Sun, 9 Oct 2016, Rich Felker wrote:
> On Sun, Oct 09, 2016 at 09:23:58PM +0200, Thomas Gleixner wrote:
> > Well, you can use handle_percpu_irq() for your device interrupts if you
> > guarantee at the hardware level that there is no reentrancy.
> 
> Reentrancy is possible of course if the kernel enables irqs during the
> irq handler. Is not doing so a stable part of the kernel irq
> subsystem? My understanding is that modern kernels keep irqs disabled
> for the full duration of (hard) irq handlers.

If you enable lockdep then it will yell at offenders which enable irqs in
the interrupt handler. So yes, hard irq handlers are not allowed to
reenable interrupts.
 
> > Once you make
> > the hardware capable of delivering them on either core the picture changes.
> 
> *nod* Perhaps if/when we do that, the path of least resistence would
> be to adjust the irq numbering so that percpu (i.e., hard-routed to a
> particular cpu) and global irqs (deliverable on any core) are in
> different ranges and the existing kernel frameworks work.

That's very much what ARM and others do.

Thanks,

	tglx
