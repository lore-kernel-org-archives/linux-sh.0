From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Sun, 02 Oct 2016 05:59:51 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161002055951.GU14933@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160926222352.GE19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609261936130.4915@nanos>
 <20160927004258.GF19318@brightrain.aerifal.cx>
 <20160927220820.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609301319410.4799@nanos>
 <20160930134835.GT14933@linux.vnet.ibm.com>
 <20161001170508.GO19318@brightrain.aerifal.cx>
 <20161001175837.GP14933@linux.vnet.ibm.com>
 <20161002000049.GP19318@brightrain.aerifal.cx>
 <20161002035925.GQ19318@brightrain.aerifal.cx>
In-Reply-To: <20161002035925.GQ19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Sat, Oct 01, 2016 at 11:59:25PM -0400, Rich Felker wrote:
> On Sat, Oct 01, 2016 at 08:00:49PM -0400, Rich Felker wrote:
> > > > > > > - During the whole sequence, hrtimer expiration times are being set to
> > > > > > >   exact jiffies (@ 100 Hz), whereas before it they're quite arbitrary.
> > > > > > 
> > > > > > When a CPU goes into NOHZ idle and the next (timer/hrtimer) is farther out
> > > > > > than the next tick, then tick_sched_timer is set to this next event which
> > > > > > can be far out. So that's expected.
> > > > > > 
> > > > > > > - The CLOCK_MONOTONIC hrtimer times do not match up with the
> > > > > > >   timestamps; they're off by about 0.087s. I assume this is just
> > > > > > >   sched_clock vs clocksource time and not a big deal.
> > > > > > 
> > > > > > Yes. You can tell the tracer to use clock monotonic so then they should match.
> > > > > > 
> > > > > > > - The rcu_sched process is sleeping with timeout=1. This seems
> > > > > > >   odd/excessive.
> > > > > > 
> > > > > > Why is that odd? That's one tick, i.e. 10ms in your case. And that's not
> > > > > > the problem at all. The problem is your timer not firing, but the cpu is
> > > > > > obviously either getting out of idle and then moves the tick ahead for some
> > > > > > unknown reason.
> > > > > 
> > > > > And a one-jiffy timeout is in fact expected behavior when HZ0.
> > > > > You have to be running HZ%0 or better to have two-jiffy timeouts,
> > > > > and HZP0 or better for three-jiffy timeouts.
> > > > 
> > > > One possible theory I'm looking at is that the two cpus are both
> > > > waking up (leaving cpu_idle_poll or cpuidle_idle_call) every jiffy
> > > > with sufficient consistency that every time the rcu_gp_fqs_check_wake
> > > > loop wakes up in rcu_gp_kthread, the other cpu is in cpu_idle_loop but
> > > > outside the rcu_idle_enter/rcu_idle_exit range. Would this block
> > > > forward process? I added an LED indicator in rcu_gp_fqs_check_wake
> > > > that shows the low 2 bits of rnp->qsmask every time it's called, and
> > > > under normal operation the LEDs just flash on momentarily or just one
> > > > stays on for a few seconds then goes off. During a stall both are
> > > > stuck on. I'm still trying to make sense of the code but my impression
> > > > so far is that, on a 2-cpu machine, this is a leaf node and the 2 bits
> > > > correspond directly to cpus; is that right? If so I'm a bit confused
> > > > because I don't see how forward progress could ever happen if the cpu
> > > > on which rcu_gp_kthread is blocking forward progress of
> > > > rcu_gp_kthread.
> > > 
> > > No.  If the CPUs are entering and leaving idle, and if your timers
> > > were waking up rcu_sched every few jiffies like it asks, then the
> > > repeated idle entry/exit events would be noticed, courtesy of the atomic
> > > increments of ->dynticks and the rcu_sched kthread's snapshotting and
> > > checking of this value.
> > 
> > I don't see how rcu_sched could notice the changes if it's stuck in
> > the wait loop I think it's stuck in. There is no check of ->dynticks
> > in rcu_gp_fqs_check_wake. Just in case checking *gfp & RCU_GP_FLAG_FQS
> > accomplishes this, I updated my LED hacks to clear the LEDs in that
> > exit path (and killed the other place that could turn them back on
> > from cpu_idle_loop) but I still get 2 LEDs on for 21s followed by a
> > stall message.
> > 
> > > Even if the CPUs were always non-idle on every
> > > time force_quiescent_state() is invoked, give or take the possibility
> > > of counter wrap -- but even on a 32-bit system, that takes awhile.
> > 
> > Perhaps force_quiescent_state is not getting invoked? Does that sound
> > plausible, and if so, how should I go about debugging it? I see it is
> > called from the stall reporting code, so that's presumably what's
> > breaking the stalls.
> 
> I can confirm that force_quiescent_state is not being called at all
> except from the stall handler. Where is it supposed to be called from?
> I can't find any code paths to it except the stall handler and
> __call_rcu_core, but the latter seems to only be called when adding
> new rcu callbacks, not as a response to a stalled rcu_sched thread.
> Maybe I'm missing something but this seems like incorrect logic in the
> rcu subsystem.

This is the RCU logic you are missing within the RCU grace-period kthread:

			ret = swait_event_interruptible_timeout(rsp->gp_wq,
					rcu_gp_fqs_check_wake(rsp, &gf), j);

On your system, j=1, which means that when the RCU grace-period kthread
sleeps during a grace period, it is supposed to be awakened after one
jiffy regardless of anything else.  On your system (and apparently -only-
your system), this wakeup is not happening.

RCU reacts to your system's failure to awaken it by giving you an RCU
CPU stall warning.

So please do two things:

1.	As Thomas asked in his September 30th email, upload your full
	trace file somewhere so that he can fully analyze it.  We
	cannot help you if you ignore our requests!
	
	If you did upload it and privately informed Thomas, apologies
	for the false alarm.

2.	Look carefully at the portions of the trace that relate to
	Thomas's sentence in his September 30 email to you with Message-ID
	<alpine.DEB.2.20.1609301319410.4799@nanos> that reads as follows:

		"And this expiry happens on CPU 1, but the expiry time
		looks like the one which got armed on CPU 0 above !?!?!"

	This is a big flaming red-flag whack-over-the-head clue.  Please
	give it the time and attention that it deserves.  Please find
	out why on earth the request for a 10-ms-later timer event on
	CPU 0 appears to have happened way later on CPU 1.  One way
	to do this might be by adding event traces in the lower-level
	hardware-specific timer code.

Again, the reason that force_quiescent_state() is never being called is
because your system's timers are failing to wake up the rcu_sched kthread.
As can be seen from the trace you sent to Thomas, the rcu_sched kthread
is asking to be awakened after 10ms (1 jiffy).  If it had been correctly
awakened, it would have invoked force_quiescent_state().

So please focus some time and attention on learning why your system refused
to respond properly to rcu_sched's timed-wakeup request.

After all, if RCU asks to be awakened in 10 milliseconds, and your system
refuses to do that, you cannot expect RCU to magically wake itself up,
now can you?  ;-)

							Thanx, Paul

