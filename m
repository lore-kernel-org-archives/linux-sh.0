From: Rich Felker <dalias@libc.org>
Date: Thu, 28 Jul 2016 19:34:48 +0000
Subject: Re: [PATCH v5 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160728193447.GJ15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469688975.git.dalias@libc.org>
 <ed156509aed631486decf1828acb4f0afa61dd31.1469688975.git.dalias@libc.org>
 <alpine.DEB.2.11.1607281515330.19896@nanos>
 <20160728163748.GI15995@brightrain.aerifal.cx>
 <alpine.DEB.2.11.1607281837450.19896@nanos>
In-Reply-To: <alpine.DEB.2.11.1607281837450.19896@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

On Thu, Jul 28, 2016 at 06:44:15PM +0200, Thomas Gleixner wrote:
> On Thu, 28 Jul 2016, Rich Felker wrote:
> > On Thu, Jul 28, 2016 at 04:44:05PM +0200, Thomas Gleixner wrote:
> > > > +	return ((u64)sechi << 32 | seclo) * NSEC_PER_SEC + nsec;
> > > 
> > > Wow, that's an expensive thing for a hotpath operation. You really don't have
> > > binary readout register for that clock thingy?
> > 
> > Unforunately the clock is in sec64.nsec32 format instead of a flat
> > nanoseconds count. Daniel Lezcano also suggested just using
> > nanoseconds, which would still need some retry and arithmetic for
> > adding seclo*NSEC_PER_SEC (otherwise it's problematic because it wraps
> > at NSEC_PER_SEC rather than at a power of two) but that does put a
> > hard upper bound on tickless sleep time of 4 sec. In practice it
> > probably doesn't matter. Should I try that instead?
> 
> Up to you. I was just wondering about the MUL.

Well 2 people have raised the issue now so I think I'll go ahead and
try changing it.

> > > > +static notrace u64 jcore_sched_clock_read(void)
> > > > +{
> > > > +	return jcore_clocksource_read(jcore_cs);
> > > 
> > > Why don't you stuff the above code into this function?
> > 
> > I was trying to avoid code duplication, but I could if you think it
> > really matters for performance.
> 
> Did not see where the other usage site was. Must have missed that. So keep it
> as is and please add notrace to jcore_clocksource_read().

Since we have to assume a singleton now anyway, I'm just going to
switch the caller/callee relationship the other way around and make
the sched version use static objects directly. This shought be
slightly faster/smaller.

> > > Please convert this to the new state machine model of cpu
> > > hotplug. CPU_STARTING will be gone very soon. Here is an example:
> > > 
> > > http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=smp/hotplug&id~86e8bd8dd67649d176e08d8dfb90039f0a1e98
> > 
> > I don't think that's the commit you wanted to link -- it doesn't show
> > a usage example.
>  
> It's the conversion of a driver from the old to the new style, So it's an
> example how to move your stuff to the new interface or am I missing something
> here?

I botched the link copy and paste. Sorry for the noise. I see it now.

> > I've asked about this before in another context but didn't get an
> > answer -- I'm a bit concerned that, from what I can tell, the new
> > framework is a big singleton does assumes singletons in all the
> > drivers that use it. In practice it doesn't matter as long as there's
> > only one instance of the pit driver, but this seems architecturally
> > really bad and like it's a time bomb waiting to blow up on us in the
> > future. Am I missing something?
> 
> Most of the users are single instance. We have a dynamic interface for the
> online callbacks and we might get one for the prep stage as well.
> 
> Now for the real core stuff like starting/dying we want explicit states and if
> a driver really is multi instance then having a private list there is not
> rocket science. Most of them have an instance list anyway.

For now I'll just remove some of the dynamic allocation I added and
simplify assuming a single instance. It doesn't make sense to be
incurring costs for the nominal ability to have multiple instances
when it doesn't actually work in the new framework (without a lot more
per-driver code duplication that really should be in the framework)
and when it's not needed anyway.

Rich
