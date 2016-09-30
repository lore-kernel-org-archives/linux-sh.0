From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Fri, 30 Sep 2016 13:48:35 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160930134835.GT14933@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org>
 <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20160926222352.GE19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609261936130.4915@nanos>
 <20160927004258.GF19318@brightrain.aerifal.cx>
 <20160927220820.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609301319410.4799@nanos>
In-Reply-To: <alpine.DEB.2.20.1609301319410.4799@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

On Fri, Sep 30, 2016 at 03:15:11PM +0200, Thomas Gleixner wrote:
> On Tue, 27 Sep 2016, Rich Felker wrote:
> > I've managed to get a trace with a stall. I'm not sure what the best
> > way to share the full thing is, since it's large, but here are the
> > potentially interesting parts.

[ . . . ]

Some RCU commentary, on the off-chance that it helps...

> So that should kick rcu_sched-7 in 10ms, latest 20ms from now and CPU1 goes
> into a NOHZ idle sleep.
> 
> >           <idle>-0     [001] d...   109.953436: tick_stop: success=1 dependency=NONE
> >           <idle>-0     [001] d...   109.953617: hrtimer_cancel: hrtimer9f449c
> >           <idle>-0     [001] d...   109.953818: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires9880000000 softexpires9880000000
> 
> which is (using the 0.087621us delta between the trace clock and clock
> MONO) at: 109.880 + 0.087621 = 109.968
> 
> Which is about correct as we expect the RCU timer to fire at:
>       
>       109.952633 + 0.01 = 109.963633
> 
> or latest at
> 
>       109.952633 + 0.02 = 109.983633
>    
> There is another caveat. That nohz stuff can queue the rcu timer on CPU0, which
> it did not because:

Just for annoying completeness, the location of the timer depends on how
the rcuo callback-offload kthreads are constrained.  And yes, in the most
constrained case where all CPUs except for CPU 0 are nohz CPUs, they will
by default all run on CPU 0.

> >        rcu_sched-7     [001] d...   109.952633: timer_start: timer0a9eb0 function=process_timeout expiresB94948284 [timeout=1] flags=0x00000001
> 
> The CPU nr encoded in flags is: 1
> 
> Now we cancel and restart the timer w/o seing the interrupt expiring
> it. And that expiry should have happened at 109.968000 !?!
> 
> >           <idle>-0     [001] d...   109.968225: hrtimer_cancel: hrtimer9f449c
> >           <idle>-0     [001] d...   109.968526: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires9890000000 softexpires9890000000
> 
> So this advances the next tick even further out. And CPU 0 sets the timer to
> the exact smae value:
> 
> >           <idle>-0     [000] d.h.   109.969104: hrtimer_start: hrtimer9e949c function=tick_sched_timer expires9890000000 softexpires9890000000
> 
> 
> >           <idle>-0     [000] d.h.   109.977690: irq_handler_entry: irq name=jcore_pit
> >           <idle>-0     [000] d.h.   109.977911: hrtimer_cancel: hrtimer9e949c
> >           <idle>-0     [000] d.h.   109.978053: hrtimer_expire_entry: hrtimer9e949c function=tick_sched_timer now9890434160
> 
> Which expires here. And CPU1 instead of getting an interrupt and expiring
> the timer does the cancel/restart to the next jiffie again:
> 
> >           <idle>-0     [001] d...   109.978206: hrtimer_cancel: hrtimer9f449c
> >           <idle>-0     [001] d...   109.978495: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires9900000000 softexpires9900000000
> 
> And this repeats;
> 
> >           <idle>-0     [000] d.h.   109.987726: irq_handler_entry: irq name=jcore_pit
> >           <idle>-0     [000] d.h.   109.987954: hrtimer_cancel: hrtimer9e949c
> >           <idle>-0     [000] d.h.   109.988095: hrtimer_expire_entry: hrtimer9e949c function=tick_sched_timer now9900474620
> 
> >           <idle>-0     [001] d...   109.988243: hrtimer_cancel: hrtimer9f449c
> >           <idle>-0     [001] d...   109.988537: hrtimer_start: hrtimer9f449c fun9c
> 
> There is something badly wrong here.
> 
> >           <idle>-0     [000] ..s.   110.019443: softirq_entry: vec=1 [action=TIMER]
> >           <idle>-0     [000] ..s.   110.019617: softirq_exit: vec=1 [action=TIMER]
> >           <idle>-0     [000] ..s.   110.019730: softirq_entry: vec=7 [action=SCHED]
> >           <idle>-0     [000] ..s.   110.020174: softirq_exit: vec=7 [action=SCHED]
> >           <idle>-0     [000] d.h.   110.027674: irq_handler_entry: irq name=jcore_pit
> > 
> > The rcu_sched process does not run again after the tick_stop until
> > 132s, and only a few RCU softirqs happen (all shown above). During
> > this time, cpu1 has no interrupt activity and nothing in the trace
> > except the above hrtimer_cancel/hrtimer_start pairs (not sure how
> > they're happening without any interrupts).
> 
> If you drop out of the arch idle into the core idle loop then you might end
> up with this. You want to add a few trace points or trace_printks() to the
> involved functions. tick_nohz_restart() tick_nohz_stop_sched_tick()
> tick_nohz_restart_sched_tick() and the idle code should be a good starting
> point.
> 
> > This pattern repeats until almost 131s, where cpu1 goes into a frenzy
> > of hrtimer_cancel/start:
> 
> It's not a frenzy. It's the same pattern as above. It arms the timer to the
> next tick, but that timer never ever fires. And it does that every tick ....
> 
> Please put a tracepoint into your set_next_event() callback as well. SO
> this changes here:
> 
> >           <idle>-0     [001] d...   132.198170: hrtimer_cancel: hrtimer9f449c
> >           <idle>-0     [001] d...   132.198451: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires2120000000 softexpires2120000000
> 
> >           <idle>-0     [001] dnh.   132.205860: irq_handler_entry: irq  name=ipi
> >           <idle>-0     [001] dnh.   132.206041: irq_handler_exit: irq  ret=handle
> 
> So CPU1 gets an IPI
> 
> >           <idle>-0     [001] dn..   132.206650: hrtimer_cancel: hrtimer9f449c
> 49c function=tick_sched_timer now2119115200
> >           <idle>-0     [001] dn..   132.206936: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires2120000000 softexpires2120000000
> 
> And rcu-sched-7 gets running magically, but we don't know what woke it
> up. Definitely not the timer, because that did not fire.
> 
> >        rcu_sched-7     [001] d...   132.207710: timer_cancel: timer0a9eb0

It could have been an explicit wakeup at the end of a grace period.  That
would explain its cancelling the timer, anyway.

> > - During the whole sequence, hrtimer expiration times are being set to
> >   exact jiffies (@ 100 Hz), whereas before it they're quite arbitrary.
> 
> When a CPU goes into NOHZ idle and the next (timer/hrtimer) is farther out
> than the next tick, then tick_sched_timer is set to this next event which
> can be far out. So that's expected.
> 
> > - The CLOCK_MONOTONIC hrtimer times do not match up with the
> >   timestamps; they're off by about 0.087s. I assume this is just
> >   sched_clock vs clocksource time and not a big deal.
> 
> Yes. You can tell the tracer to use clock monotonic so then they should match.
> 
> > - The rcu_sched process is sleeping with timeout=1. This seems
> >   odd/excessive.
> 
> Why is that odd? That's one tick, i.e. 10ms in your case. And that's not
> the problem at all. The problem is your timer not firing, but the cpu is
> obviously either getting out of idle and then moves the tick ahead for some
> unknown reason.

And a one-jiffy timeout is in fact expected behavior when HZ0.
You have to be running HZ%0 or better to have two-jiffy timeouts,
and HZP0 or better for three-jiffy timeouts.

							Thanx, Paul

