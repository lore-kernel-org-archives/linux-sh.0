From: Rich Felker <dalias@libc.org>
Date: Thu, 28 Jul 2016 20:18:44 +0000
Subject: Re: [PATCH v5 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160728201844.GM15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469688975.git.dalias@libc.org>
 <ed156509aed631486decf1828acb4f0afa61dd31.1469688975.git.dalias@libc.org>
 <alpine.DEB.2.11.1607281515330.19896@nanos>
 <20160728200047.GL15995@brightrain.aerifal.cx>
In-Reply-To: <20160728200047.GL15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>

On Thu, Jul 28, 2016 at 04:00:47PM -0400, Rich Felker wrote:
> On Thu, Jul 28, 2016 at 04:44:05PM +0200, Thomas Gleixner wrote:
> > > +static int jcore_pit_cpu_notify(struct notifier_block *self,
> > > +			unsigned long action, void *hcpu)
> > > +{
> > > +	struct jcore_pit_nb *nb = container_of(self, struct jcore_pit_nb, nb);
> > > +	switch (action & ~CPU_TASKS_FROZEN) {
> > > +	case CPU_STARTING:
> > > +		jcore_pit_local_init(this_cpu_ptr(nb->pit_percpu));
> > > +		break;
> > > +	}
> > > +	return NOTIFY_OK;
> > 
> > Please convert this to the new state machine model of cpu
> > hotplug. CPU_STARTING will be gone very soon. Here is an example:
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=smp/hotplug&id~86e8bd8dd67649d176e08d8dfb90039f0a1e98
> 
> Trying this change now and I'm getting hangs inside
> cpuhp_invoke_ap_callback between wake_up_process and
> wait_for_completion. I suspect it's not possible to run a scheduled
> task yet because there's no timer yet, or something like that. Do I
> need further infrastructure from tip that's not upstream yet in order
> to test this? I just rebased on linus/master and still have the same
> problem, but none of the other driver changes are in Linus's tree yet.
> Following the other drivers in tip (again, I don't have any of these
> in my tree), I put the new state between CPUHP_AP_SCHED_STARTING and
> CPUHP_AP_NOTIFY_STARTING; is this correct?

I think it's this bug where the fix is not yet in Linus's tree:

http://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/kernel/cpu.c?h=smp/hotplug&idj4e24518c8a10f78f44da219835239cb5aca90d

Cherry-picking that made it work. FWIW, it's really hard to do
development on top of new infrastructure that's not yet working in any
tree that's intended for others to pull, but I made it work and I'll
have a new version of the patch for you soon.

Rich
