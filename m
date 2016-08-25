From: Mark Rutland <mark.rutland@arm.com>
Date: Thu, 25 Aug 2016 16:38:06 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160825163805.GA8524@remoulade>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1608250947120.5714@nanos>
 <20160825145650.GA15995@brightrain.aerifal.cx>
In-Reply-To: <20160825145650.GA15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Marc Zyngier <Marc.Zyngier@arm.com>

On Thu, Aug 25, 2016 at 10:56:50AM -0400, Rich Felker wrote:
> On Thu, Aug 25, 2016 at 10:07:08AM +0200, Thomas Gleixner wrote:
> > On Wed, 24 Aug 2016, Rich Felker wrote:
> As for this topic, what happened is that, after the first and second
> time of expressing confusion about how the infrastructure did not make
> sense and whether I should even be using it, I did not get anything
> resembling an explanation of why it's the way it is or why I might be
> wrong in thinking it's a bug, and so I went forward with the
> assumption that is was just a bug. Now that Mark Rutland has explained
> it well (and with your additional explanation below in your email), I
> see what the motivation was, but I still think it could be done in a
> less-confusing and more-consistent way that doesn't assume ARM-like
> irq architecture.

The fun this is that right until the point you sent this patch, it was
consistent for all hardware that we support and were aware of. For others, it
is your hardware that is the confusing case. ;)

In future, it's better to state 'this doesn't seem to match my hardware' rather
than 'this is misdesigned'. Ideally, with a description of how your hardware
works, as that's the thing no-one else is familiar with.

> > If your particular hardware has the old scheme of seperate interrupt numbers
> > for per cpu interrupts, then you can simply use the normal interrupt scheme
> > and request a seperate interrupt per cpu.
> 
> Nominally it uses the same range of hardware interrupt numbers for all
> (presently both) cpus, but some of them get delivered to a specific
> cpu associated with the event (presently, IPI and timer; IPI is on a
> fixed number at synthesis time but timer is runtime configurable)
> while others are conceptually deliverable to either cpu (presently
> only delivered to cpu0, but that's treated as an implementation
> detail).

Given you say it's delivered to the CPU associated with the event (and you have
different PIT bases per-cpu), it sounds like your timer interrupt is percpu,
it's just that the hwirq number can be chosen by software.

> It currently works requesting the irq with flags that ensure the
> handler runs on the same cpu it was delivered on, without using any
> other percpu irq framework. If you have concerns about ways this could
> break and want me to make the drivers do something else, I'm open to
> suggestions.

As I suggested, I don't think that this is right, and you need some mechanism
to describe to the kernel that the interrupt is percpu (e.g. a flag in the
interrupt-specifier in DT).

Thanks,
Mark.
