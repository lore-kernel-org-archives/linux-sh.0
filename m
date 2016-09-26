From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 26 Sep 2016 23:55:13 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <alpine.DEB.2.20.1609261936130.4915@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org> <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org> <20160926210716.GA12855@brightrain.aerifal.cx> <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20160926222352.GE19318@brightrain.aerifal.cx>
In-Reply-To: <20160926222352.GE19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Mon, 26 Sep 2016, Rich Felker wrote:
> On Mon, Sep 26, 2016 at 11:27:14PM +0200, Daniel Lezcano wrote:
> Based on use of ftrace, I was able to see situations where a second
> timer hardirq happened immediately after one occurred, before the
> timer softirq could run. My theory is that this is causing some kind
> of feedback loop where new timer expirations keep getting scheduled
> with a very short interval such that the softirq never gets to run
> (until other interrupt activity disrups the feedback loop). I tried
> reverting 4e85876a9d2a977b4a07389da8c07edf76d10825 which seemed
> relevant and it didn't help, but on further review (right now) there
> seem to be a few related commits just before it that might be
> responsible for the regression. I'll see if I can dig up anything else
> useful.

Interesting theory, but lets look at the data from the other thread:

         <idle>-0     [001] d.h.  2646.702790: irq_handler_entry: irqr name=jcore_pit
          <idle>-0     [001] d.h.  2646.703398: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] d.h.  2646.703607: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] d.h.  2646.703884: softirq_raise: vec=7 [action=SCHED]
          <idle>-0     [001] d.h.  2646.704191: irq_handler_exit: irqr ret=handled

So it takes 1.4ms to finish the timer irq handler

          <idle>-0     [001] d.H.  2646.704509: irq_handler_entry: irqr name=jcore_pit
          <idle>-0     [001] d.H.  2646.704990: softirq_raise: vec=1 [action=TIMER]
          <idle>-0     [001] d.H.  2646.705182: softirq_raise: vec=9 [action=RCU]
          <idle>-0     [001] d.H.  2646.705465: softirq_raise: vec=7 [action=SCHED]
          <idle>-0     [001] d.H.  2646.705761: irq_handler_exit: irqr ret=handled

And 1.2ms in this case
	  

          <idle>-0     [001] d.H.  2646.706071: irq_handler_entry: irqr name=jcore_pit
          <idle>-0     [001] d.H.  2646.706328: irq_handler_exit: irqr ret=handled

So this one is actually short enough that the soft interrupt can excute and
obviously no new timer is scheduled close enough.

          <idle>-0     [001] ..s.  2646.706530: softirq_entry: vec=1 [action=TIMER]

Now the obvious question arises: Why is that handler taking that long? And
sure the next event being programmed shortely after the other has to do
with various factors (HZ setting, High-resolution timers enabled?). W/o
having the corresponding hrtimer tracepoints available (start and expire)
it's hard to tell what's going on.

But I can tell for sure that there is no feedback loop and its not
disrupted by some other interrupt. The above trace is merily seing the PIT
irq and nothing else.

Can you please provide a trace with hrtimer tracepoints enabled and tell us
the settings of CONFIG_HZ and whether high resolution timers are enabled or
not.

That workaround of setting min_delta to some absurd big number looks fishy
at best.

Thanks,

	tglx
