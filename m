From: Rich Felker <dalias@libc.org>
Date: Thu, 25 Aug 2016 14:56:50 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160825145650.GA15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org>
 <20160824174001.GW15995@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1608250947120.5714@nanos>
In-Reply-To: <alpine.DEB.2.20.1608250947120.5714@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>

On Thu, Aug 25, 2016 at 10:07:08AM +0200, Thomas Gleixner wrote:
> Rich,
> 
> On Wed, 24 Aug 2016, Rich Felker wrote:
> > I don't think that's a correct characterization. Rather the percpu
> > infrastructure just means something completely different from what you
> > would expect it to mean. It has nothing to do with the hardware but
> > rather with kernel-internal choice of whether to do percpu devid
> > mapping inside the irq infrastructure, and the choice at the
> > irq-requester side of whether to do this is required to match the
> > irqchip driver's choice. I explained this better in another email
> > which I could dig up if necessary, but the essence is that
> > request_percpu_irq is a misnamed and unusably broken API.
> 
> I slowly get tired about your permanent ranting about misnamed, misdesigned
> and unusable code in the kernel.

This is the only instance I'm aware of, and my intent was not to rant.
If you're aware of other cases where I've done this and it's come
across abrasive to you or others, I'd appreciate it if you could point
them out so I can try to avoid doing so in the future.

As for this topic, what happened is that, after the first and second
time of expressing confusion about how the infrastructure did not make
sense and whether I should even be using it, I did not get anything
resembling an explanation of why it's the way it is or why I might be
wrong in thinking it's a bug, and so I went forward with the
assumption that is was just a bug. Now that Mark Rutland has explained
it well (and with your additional explanation below in your email), I
see what the motivation was, but I still think it could be done in a
less-confusing and more-consistent way that doesn't assume ARM-like
irq architecture.

> If your particular hardware has the old scheme of seperate interrupt numbers
> for per cpu interrupts, then you can simply use the normal interrupt scheme
> and request a seperate interrupt per cpu.

Nominally it uses the same range of hardware interrupt numbers for all
(presently both) cpus, but some of them get delivered to a specific
cpu associated with the event (presently, IPI and timer; IPI is on a
fixed number at synthesis time but timer is runtime configurable)
while others are conceptually deliverable to either cpu (presently
only delivered to cpu0, but that's treated as an implementation
detail).

It currently works requesting the irq with flags that ensure the
handler runs on the same cpu it was delivered on, without using any
other percpu irq framework. If you have concerns about ways this could
break and want me to make the drivers do something else, I'm open to
suggestions.

Rich
