From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Wed, 05 Oct 2016 12:41:40 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161005124139.GA3640@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org>
 <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20161003221039.GR19318@brightrain.aerifal.cx>
 <20161004070623.GM14933@linux.vnet.ibm.com>
 <20161004205837.GC19318@brightrain.aerifal.cx>
 <20161004211451.GZ14933@linux.vnet.ibm.com>
 <20161004214818.GD19318@brightrain.aerifal.cx>
In-Reply-To: <20161004214818.GD19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Oct 04, 2016 at 05:48:18PM -0400, Rich Felker wrote:
> On Tue, Oct 04, 2016 at 02:14:51PM -0700, Paul E. McKenney wrote:
> > On Tue, Oct 04, 2016 at 04:58:37PM -0400, Rich Felker wrote:
> > > On Tue, Oct 04, 2016 at 12:06:23AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Oct 03, 2016 at 06:10:39PM -0400, Rich Felker wrote:
> > > > > On Mon, Sep 26, 2016 at 11:27:14PM +0200, Daniel Lezcano wrote:
> > > > > > On 26/09/2016 23:07, Rich Felker wrote:
> > > > > > > Ping. Is there anything that still needs to be changed for this driver
> > > > > > > to be acceptable?
> > > > > > 
> > > > > > It is on my radar. I'm reviewing it.
> > > > > > 
> > > > > > Can you elaborate the workaround mentioned in the changelog. I have been
> > > > > > digging into the lkml@ thread but it is not clear if the issue is
> > > > > > related to the time framework, the driver itself or whatever else. Can
> > > > > > you clarify that ?
> > > > > 
> > > > > Do you have comments on any remaining issues other than this
> > > > > workaround? If not I don't mind removing the workaround and trying to
> > > > > solve the issue separately later. Let me know and either way I'll
> > > > > submit a v8.
> > > > 
> > > > One question of interest to me is whether this patchset prevents the
> > > > RCU CPU stall warnings that you are seeing.
> > > 
> > > With the 5ms minimum delta, I didn't observe any rcu_sched stall
> > > warnings. At 2.5ms I thought it was gone but eventually saw one. With
> > > the previous mindelta = 1, i.e. 1 hardware bus period, I get the
> > > stalls regularly.
> > 
> > Sounds to me like your low-level clock drivers or your clock hardware is
> > having trouble dealing with short timeouts.  I suggest writing a focused
> > test.  It is of course quite possible that the failure could occur for
> > any time period, but simply becomes less probable with longer time
> > periods.
> 
> I don't see any indication of such a problem on the hardware side, and
> it didn't happen in earlier kernels, though of course it's possible
> that they were programming different intervals. And all of the
> intervals logged when I added trace logging were way above the scale
> where it would be plausible for the hardware to be an issue.

Is it possible that the problem occurs when the process setting up the
timeout is delayed for longer than the timeout duration, so that the
time has already expired at the time that the hardware is programmed?

> > Or perhaps better, do the tracing that Thomas Gleixner suggested.  Or both,
> > in order to get the most information in the shortest period of time.
> 
> I'm starting with new traces with "nohlt" on the kernel command line,
> since many of the stalls I've observed up to now may have a different
> mechanism -- since the arch_cpu_idle code doesn't work (returns
> immediately) the rapid rcu idle enter/exit in the cpu idle loop might
> be part of what was interfering with rcu_sched.

That doesn't sound good, though I cannot immediately think of a reason
why that would cause RCU much trouble.

> With my new traces and LED debugging (which I still need to tune with
> more logging, then I'll post some more results) what I'm seeing when
> the stall happens is the timer interrupt firing as expected and making
> it into __hrtimer_run_queues, but tick_sched_timer not getting called
> and thus rcu_sched never waking up from its 1s schedule_timeout (via
> swait).

It would be very interesting to track down exactly the point at which
the system decides not to fire the timeout.

							Thanx, Paul

