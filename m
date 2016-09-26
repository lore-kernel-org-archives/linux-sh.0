From: Rich Felker <dalias@libc.org>
Date: Mon, 26 Sep 2016 22:23:52 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160926222352.GE19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org>
 <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
In-Reply-To: <4b02ba7d-4a31-297a-bbbd-be26da615e7b-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

On Mon, Sep 26, 2016 at 11:27:14PM +0200, Daniel Lezcano wrote:
> On 26/09/2016 23:07, Rich Felker wrote:
> > Ping. Is there anything that still needs to be changed for this driver
> > to be acceptable?
> 
> It is on my radar. I'm reviewing it.
> 
> Can you elaborate the workaround mentioned in the changelog. I have been
> digging into the lkml@ thread but it is not clear if the issue is
> related to the time framework, the driver itself or whatever else. Can
> you clarify that ?

It does not seem to be related to the driver. I'd be happy to have a
workaround (or even better a fix) at a higher level outside the
driver. I'll try to summarize what I think is happening.

The symptom is heavy irq load (much higher than the 1-2 irqs/sec I
observed on 4.6, something like 30+ on average) and frequent rcu_sched
stall messages. Under these conditions the system "feels" responsive
still, but that seems to be a consequence of other interrupts breaking
the stall; by inserting and removing the SD card, which is probed
periodically (1s period) by a kernel thread when there's no irq hooked
up for the slot, I was able to observe that the card-removed message
did not appear for several seconds, so apparently the kernel really is
stalling.

Based on use of ftrace, I was able to see situations where a second
timer hardirq happened immediately after one occurred, before the
timer softirq could run. My theory is that this is causing some kind
of feedback loop where new timer expirations keep getting scheduled
with a very short interval such that the softirq never gets to run
(until other interrupt activity disrups the feedback loop). I tried
reverting 4e85876a9d2a977b4a07389da8c07edf76d10825 which seemed
relevant and it didn't help, but on further review (right now) there
seem to be a few related commits just before it that might be
responsible for the regression. I'll see if I can dig up anything else
useful.

> Regarding the previous version, did you reach a consensus regarding
> per_cpu irq with Mark Rutland ?

I'm not sure. I think I can reasonably say that the existign percpu
framework is not suitable or necessary for modeling what the jcore
hardware is doing. The interrupt controller driver seems to have been
accepted already without use of percpu stuff. I know there was some
concern that not letting the kernel know whether an irq is percpu or
not could lead to wrong behavior, but I believe that's only possible
in the other direction (wrongly registering an irq as percpu when it's
actually a normal one that could happen on either cpu, in which case
locking might be wrongly omitted, etc.).

Rich
