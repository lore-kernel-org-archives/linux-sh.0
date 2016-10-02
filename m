From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Sun, 02 Oct 2016 06:30:22 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161002063022.GV14933@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20160926222352.GE19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609261936130.4915@nanos>
 <20160927004258.GF19318@brightrain.aerifal.cx>
 <20160927220820.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609301319410.4799@nanos>
 <20160930134835.GT14933@linux.vnet.ibm.com>
 <20161001170508.GO19318@brightrain.aerifal.cx>
 <20161001175837.GP14933@linux.vnet.ibm.com>
 <20161002000049.GP19318@brightrain.aerifal.cx>
In-Reply-To: <20161002000049.GP19318-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>

On Sat, Oct 01, 2016 at 08:00:49PM -0400, Rich Felker wrote:
> On Sat, Oct 01, 2016 at 10:58:37AM -0700, Paul E. McKenney wrote:
> > On Sat, Oct 01, 2016 at 01:05:08PM -0400, Rich Felker wrote:
> > > On Fri, Sep 30, 2016 at 06:48:35AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Sep 30, 2016 at 03:15:11PM +0200, Thomas Gleixner wrote:
> > > > > On Tue, 27 Sep 2016, Rich Felker wrote:
> > > > > > I've managed to get a trace with a stall. I'm not sure what the best
> > > > > > way to share the full thing is, since it's large, but here are the
> > > > > > potentially interesting parts.
> > > > 
> > > > [ . . . ]
> > > > 
> > > > Some RCU commentary, on the off-chance that it helps...
> > > > 
> > > > > So that should kick rcu_sched-7 in 10ms, latest 20ms from now and CPU1 goes
> > > > > into a NOHZ idle sleep.
> > > > > 
> > > > > >           <idle>-0     [001] d...   109.953436: tick_stop: success=1 dependency=NONE
> > > > > >           <idle>-0     [001] d...   109.953617: hrtimer_cancel: hrtimer9f449c
> > > > > >           <idle>-0     [001] d...   109.953818: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires9880000000 softexpires9880000000
> > > > > 
> > > > > which is (using the 0.087621us delta between the trace clock and clock
> > > > > MONO) at: 109.880 + 0.087621 = 109.968
> > > > > 
> > > > > Which is about correct as we expect the RCU timer to fire at:
> > > > >       
> > > > >       109.952633 + 0.01 = 109.963633
> > > > > 
> > > > > or latest at
> > > > > 
> > > > >       109.952633 + 0.02 = 109.983633
> > > > >    
> > > > > There is another caveat. That nohz stuff can queue the rcu timer on CPU0, which
> > > > > it did not because:
> > > > 
> > > > Just for annoying completeness, the location of the timer depends on how
> > > > the rcuo callback-offload kthreads are constrained.  And yes, in the most
> > > > constrained case where all CPUs except for CPU 0 are nohz CPUs, they will
> > > > by default all run on CPU 0.
> > > 
> > > In default full nohz configuration, am I correct that all cpus except
> > > cpu0 willd be nohz and that the rcu callbacks then have to run on
> > > cpu0?
> > 
> > In recent kernels, it looks to me that the default is that none of the
> > CPUs will be nohz by default.  You have to build with both NO_HZ_FULL
> > and NO_HZ_FULL_ALL to get the everything-on-CPU-0 behavior.
> 
> Actually NO_HZ_FULL is not supported because
> HAVE_VIRT_CPU_ACCOUNTING_GEN and HAVE_CONTEXT_TRACKING are missing, so
> it's just normal NO_HZ. I listed the relevant config items somewhere
> earlier in this thread I think.

Very good.  Please feel free to go back and double-check, if you wish.

> > But are there rcu0 kthreads running on your system?
> 
> Apparently not:
> 
> # ps aux | grep rcu
>     7 root       0:00 [rcu_sched]
>     8 root       0:00 [rcu_bh]
>   395 root       0:00 grep rcu

OK, you do not have callback-offloading enabled.  We can therefore eliminate
the possibility that you are being hit by callback-offloading logic.

> > > > > >        rcu_sched-7     [001] d...   109.952633: timer_start: timer0a9eb0 function=process_timeout expiresB94948284 [timeout=1] flags=0x00000001
> > > > > 
> > > > > The CPU nr encoded in flags is: 1
> > > > > 
> > > > > Now we cancel and restart the timer w/o seing the interrupt expiring
> > > > > it. And that expiry should have happened at 109.968000 !?!
> > > > > 
> > > > > >           <idle>-0     [001] d...   109.968225: hrtimer_cancel: hrtimer9f449c
> > > > > >           <idle>-0     [001] d...   109.968526: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires9890000000 softexpires9890000000
> > > > > 
> > > > > So this advances the next tick even further out. And CPU 0 sets the timer to
> > > > > the exact smae value:
> > > > > 
> > > > > >           <idle>-0     [000] d.h.   109.969104: hrtimer_start: hrtimer9e949c function=tick_sched_timer expires9890000000 softexpires9890000000
> > > > > 
> > > > > 
> > > > > >           <idle>-0     [000] d.h.   109.977690: irq_handler_entry: irq name=jcore_pit
> > > > > >           <idle>-0     [000] d.h.   109.977911: hrtimer_cancel: hrtimer9e949c
> > > > > >           <idle>-0     [000] d.h.   109.978053: hrtimer_expire_entry: hrtimer9e949c function=tick_sched_timer now9890434160
> > > > > 
> > > > > Which expires here. And CPU1 instead of getting an interrupt and expiring
> > > > > the timer does the cancel/restart to the next jiffie again:
> > > > > 
> > > > > >           <idle>-0     [001] d...   109.978206: hrtimer_cancel: hrtimer9f449c
> > > > > >           <idle>-0     [001] d...   109.978495: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires9900000000 softexpires9900000000
> > > > > 
> > > > > And this repeats;
> > > > > 
> > > > > >           <idle>-0     [000] d.h.   109.987726: irq_handler_entry: irq name=jcore_pit
> > > > > >           <idle>-0     [000] d.h.   109.987954: hrtimer_cancel: hrtimer9e949c
> > > > > >           <idle>-0     [000] d.h.   109.988095: hrtimer_expire_entry: hrtimer9e949c function=tick_sched_timer now9900474620
> > > > > 
> > > > > >           <idle>-0     [001] d...   109.988243: hrtimer_cancel: hrtimer9f449c
> > > > > >           <idle>-0     [001] d...   109.988537: hrtimer_start: hrtimer9f449c fun9c
> > > > > 
> > > > > There is something badly wrong here.
> > > > > 
> > > > > >           <idle>-0     [000] ..s.   110.019443: softirq_entry: vec=1 [action=TIMER]
> > > > > >           <idle>-0     [000] ..s.   110.019617: softirq_exit: vec=1 [action=TIMER]
> > > > > >           <idle>-0     [000] ..s.   110.019730: softirq_entry: vec=7 [action=SCHED]
> > > > > >           <idle>-0     [000] ..s.   110.020174: softirq_exit: vec=7 [action=SCHED]
> > > > > >           <idle>-0     [000] d.h.   110.027674: irq_handler_entry: irq name=jcore_pit
> > > > > > 
> > > > > > The rcu_sched process does not run again after the tick_stop until
> > > > > > 132s, and only a few RCU softirqs happen (all shown above). During
> > > > > > this time, cpu1 has no interrupt activity and nothing in the trace
> > > > > > except the above hrtimer_cancel/hrtimer_start pairs (not sure how
> > > > > > they're happening without any interrupts).
> > > > > 
> > > > > If you drop out of the arch idle into the core idle loop then you might end
> > > > > up with this. You want to add a few trace points or trace_printks() to the
> > > > > involved functions. tick_nohz_restart() tick_nohz_stop_sched_tick()
> > > > > tick_nohz_restart_sched_tick() and the idle code should be a good starting
> > > > > point.
> > > > > 
> > > > > > This pattern repeats until almost 131s, where cpu1 goes into a frenzy
> > > > > > of hrtimer_cancel/start:
> > > > > 
> > > > > It's not a frenzy. It's the same pattern as above. It arms the timer to the
> > > > > next tick, but that timer never ever fires. And it does that every tick ....
> > > > > 
> > > > > Please put a tracepoint into your set_next_event() callback as well. SO
> > > > > this changes here:
> > > > > 
> > > > > >           <idle>-0     [001] d...   132.198170: hrtimer_cancel: hrtimer9f449c
> > > > > >           <idle>-0     [001] d...   132.198451: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires2120000000 softexpires2120000000
> > > > > 
> > > > > >           <idle>-0     [001] dnh.   132.205860: irq_handler_entry: irq  name=ipi
> > > > > >           <idle>-0     [001] dnh.   132.206041: irq_handler_exit: irq  ret=handle
> > > > > 
> > > > > So CPU1 gets an IPI
> > > > > 
> > > > > >           <idle>-0     [001] dn..   132.206650: hrtimer_cancel: hrtimer9f449c
> > > > > 49c function=tick_sched_timer now2119115200
> > > > > >           <idle>-0     [001] dn..   132.206936: hrtimer_start: hrtimer9f449c function=tick_sched_timer expires2120000000 softexpires2120000000
> > > > > 
> > > > > And rcu-sched-7 gets running magically, but we don't know what woke it
> > > > > up. Definitely not the timer, because that did not fire.
> > > > > 
> > > > > >        rcu_sched-7     [001] d...   132.207710: timer_cancel: timer0a9eb0
> > > > 
> > > > It could have been an explicit wakeup at the end of a grace period.  That
> > > > would explain its cancelling the timer, anyway.
> > > 
> > > I think the rcu stall handler kicked it, no? Looking at the code
> > > again, maybe that behavior needs to be explicitly turned on, so maybe
> > > it's just the uart interrupt activity/load from the stall message that
> > > breaks the stall condition.
> > 
> > That is indeed another alternative.  But either way, if your timers aren't
> > waking rcu_sched up when it asks to be awakened, you will very likely get
> > RCU CPU stall warning messages.  And on small systems, rcu_sched asks to
> > be awakened every few jiffies by default.
> 
> Can you clarify which timer you think should be waking it up and
> isn't? Maybe I'm mistaken but it looks to me like rcu_gp_kthread() is
> waking up as expected, only to go back to sleep due to failure of
> rcu_gp_fqs_check_wake to end the loop.

The timeout in the call to swait_event_interruptible_timeout() below from
rcu_gp_kthread():

			ret = swait_event_interruptible_timeout(rsp->gp_wq,
					rcu_gp_fqs_check_wake(rsp, &gf), j);

On your system, j=1, so rcu_sched should be awakened each and every
jiffy.  The ftrace you sent to Thomas Gleixner indicates that this is
not happening.  Until this problem is fixed, you will continue getting
RCU CPU stall warnings.

> To demonstrate this to myself, I hacked rcu_gp_fqs_check_wake to show
> 2 low bits of rnp->qsmask on LEDs. I also put a hook to update them in
> cpu_idle_loop just now, just in case. At least one, and usually two,
> LEDs are on when the stalls happen.

If one of your CPUs is idle through the grace period, that is the expected
state.  The system needs to invoke force_quiescent_state() to detect the
idle CPUs.

Can you make the LED light up while the grace-period kthread is waiting
in the swait_event_interruptible_timeout() call?  This will need to be
conditioned on the flavor of RCU that is giving you the stall warnings,
for example something like the following, given that you had at least
one rcu_sched RCU CPU stall warning:

			if (rsp = &rcu_sched_state)
				turn_on_led();
			ret = swait_event_interruptible_timeout(rsp->gp_wq,
					rcu_gp_fqs_check_wake(rsp, &gf), j);
			if (rsp = &rcu_sched_state)
				turn_off_led();

Or maybe set different LED bits based on the RCU flavor, which given that
you have preemption disabled are rcu_sched_state and rcu_bh_state.

> > > > > > - During the whole sequence, hrtimer expiration times are being set to
> > > > > >   exact jiffies (@ 100 Hz), whereas before it they're quite arbitrary.
> > > > > 
> > > > > When a CPU goes into NOHZ idle and the next (timer/hrtimer) is farther out
> > > > > than the next tick, then tick_sched_timer is set to this next event which
> > > > > can be far out. So that's expected.
> > > > > 
> > > > > > - The CLOCK_MONOTONIC hrtimer times do not match up with the
> > > > > >   timestamps; they're off by about 0.087s. I assume this is just
> > > > > >   sched_clock vs clocksource time and not a big deal.
> > > > > 
> > > > > Yes. You can tell the tracer to use clock monotonic so then they should match.
> > > > > 
> > > > > > - The rcu_sched process is sleeping with timeout=1. This seems
> > > > > >   odd/excessive.
> > > > > 
> > > > > Why is that odd? That's one tick, i.e. 10ms in your case. And that's not
> > > > > the problem at all. The problem is your timer not firing, but the cpu is
> > > > > obviously either getting out of idle and then moves the tick ahead for some
> > > > > unknown reason.
> > > > 
> > > > And a one-jiffy timeout is in fact expected behavior when HZ0.
> > > > You have to be running HZ%0 or better to have two-jiffy timeouts,
> > > > and HZP0 or better for three-jiffy timeouts.
> > > 
> > > One possible theory I'm looking at is that the two cpus are both
> > > waking up (leaving cpu_idle_poll or cpuidle_idle_call) every jiffy
> > > with sufficient consistency that every time the rcu_gp_fqs_check_wake
> > > loop wakes up in rcu_gp_kthread, the other cpu is in cpu_idle_loop but
> > > outside the rcu_idle_enter/rcu_idle_exit range. Would this block
> > > forward process? I added an LED indicator in rcu_gp_fqs_check_wake
> > > that shows the low 2 bits of rnp->qsmask every time it's called, and
> > > under normal operation the LEDs just flash on momentarily or just one
> > > stays on for a few seconds then goes off. During a stall both are
> > > stuck on. I'm still trying to make sense of the code but my impression
> > > so far is that, on a 2-cpu machine, this is a leaf node and the 2 bits
> > > correspond directly to cpus; is that right? If so I'm a bit confused
> > > because I don't see how forward progress could ever happen if the cpu
> > > on which rcu_gp_kthread is blocking forward progress of
> > > rcu_gp_kthread.
> > 
> > No.  If the CPUs are entering and leaving idle, and if your timers
> > were waking up rcu_sched every few jiffies like it asks, then the
> > repeated idle entry/exit events would be noticed, courtesy of the atomic
> > increments of ->dynticks and the rcu_sched kthread's snapshotting and
> > checking of this value.
> 
> I don't see how rcu_sched could notice the changes if it's stuck in
> the wait loop I think it's stuck in. There is no check of ->dynticks
> in rcu_gp_fqs_check_wake. Just in case checking *gfp & RCU_GP_FLAG_FQS
> accomplishes this, I updated my LED hacks to clear the LEDs in that
> exit path (and killed the other place that could turn them back on
> from cpu_idle_loop) but I still get 2 LEDs on for 21s followed by a
> stall message.

Again, from what I can see, the reason that rcu_sched is stuck in that
wait loop is because the timers are not waking it up.  And again, given
the trace you sent Thomas Gleixner, the timers are not firing properly.
And again, given that they are not firing properly, the RCU CPU stall
warnings are expected behavior.

> > Even if the CPUs were always non-idle on every
> > time force_quiescent_state() is invoked, give or take the possibility
> > of counter wrap -- but even on a 32-bit system, that takes awhile.
> 
> Perhaps force_quiescent_state is not getting invoked? Does that sound
> plausible, and if so, how should I go about debugging it? I see it is
> called from the stall reporting code, so that's presumably what's
> breaking the stalls.

Old memories, apologies.  The force_quiescent_state() name is many years
ago, and means something different now.  :-/

It is rcu_gp_fqs() that should be getting called every jiffy during the
grace period, and for each flavor of RCU.

> > But if your timers don't wake up rcu_sched, then force_quiescent_state()
> > will never be called, and the ->dynticks counter will be neither
> > snapshotted nor checked, which will mean that the idle CPUs will never
> > be noticed, which might mean that the grace period never completes.
> > Which will definitely result in an RCU CPU stall warning like the one
> > that you are seeing.
> 
> I don't follow. I thought force_quiescent_state was called by other
> code to break rcu_sched out of the loop I'm finding it stuck in, not
> by rcu_sched itself.

The timers are supposed to wake rcu_sched up each and every jiffy during
the grace period.  They appear to be failing to do so.  Please look
into why.

							Thanx, Paul

