From: Rich Felker <dalias@libc.org>
Date: Sun, 02 Oct 2016 03:59:25 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161002035925.GQ19318@brightrain.aerifal.cx>
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
In-Reply-To: <20161002000049.GP19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Sat, Oct 01, 2016 at 08:00:49PM -0400, Rich Felker wrote:
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
> 
> > Even if the CPUs were always non-idle on every
> > time force_quiescent_state() is invoked, give or take the possibility
> > of counter wrap -- but even on a 32-bit system, that takes awhile.
> 
> Perhaps force_quiescent_state is not getting invoked? Does that sound
> plausible, and if so, how should I go about debugging it? I see it is
> called from the stall reporting code, so that's presumably what's
> breaking the stalls.

I can confirm that force_quiescent_state is not being called at all
except from the stall handler. Where is it supposed to be called from?
I can't find any code paths to it except the stall handler and
__call_rcu_core, but the latter seems to only be called when adding
new rcu callbacks, not as a response to a stalled rcu_sched thread.
Maybe I'm missing something but this seems like incorrect logic in the
rcu subsystem.

Rich
