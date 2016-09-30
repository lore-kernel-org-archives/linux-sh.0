From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 30 Sep 2016 13:15:11 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <alpine.DEB.2.20.1609301319410.4799@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org> <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org> <20160926210716.GA12855@brightrain.aerifal.cx> <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org> <20160926222352.GE19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609261936130.4915@nanos> <20160927004258.GF19318@brightrain.aerifal.cx> <20160927220820.GH19318@brightrain.aerifal.cx>
In-Reply-To: <20160927220820.GH19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rich Felker <dalias@libc.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Tue, 27 Sep 2016, Rich Felker wrote:
> I've managed to get a trace with a stall. I'm not sure what the best
> way to share the full thing is, since it's large, but here are the
> potentially interesting parts.

Upload it somewhere.
=20
> The first is a big time gap with no events, from 82.446093 to
> 109.852709:
>=20

>           <idle>-0     [001] d.h.    82.443398: irq_handler_entry: irq=16=
 name=3Djcore_pit
>           <idle>-0     [001] d.h.    82.443573: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] d.h.    82.443689: hrtimer_expire_entry: hrt=
imer=109f449c function=3Dtick_sched_timer now=82356112320

Tick timer expires

>           <idle>-0     [001] d.h.    82.443911: softirq_raise: vec=3D1 [a=
ction=3DTIMER]
>           <idle>-0     [001] d.h.    82.444089: softirq_raise: vec=3D9 [a=
ction=3DRCU]
>           <idle>-0     [001] d.h.    82.444306: softirq_raise: vec=3D7 [a=
ction=3DSCHED]

Raises softirqs

>           <idle>-0     [001] d.h.    82.444448: hrtimer_expire_exit: hrti=
mer=109f449c
>           <idle>-0     [001] d.h.    82.444592: hrtimer_start: hrtimer=10=
9f449c function=3Dtick_sched_timer expires=82360000000 softexpires=82360000=
000

Rearms the next period

>           <idle>-0     [001] d.h.    82.444821: irq_handler_exit: irq=16 =
ret=3Dhandled
>           <idle>-0     [001] ..s.    82.445034: softirq_entry: vec=3D1 [a=
ction=3DTIMER]
>           <idle>-0     [001] ..s.    82.445222: softirq_exit: vec=3D1 [ac=
tion=3DTIMER]
>           <idle>-0     [001] ..s.    82.445341: softirq_entry: vec=3D7 [a=
ction=3DSCHED]
>           <idle>-0     [001] ..s.    82.445745: softirq_exit: vec=3D7 [ac=
tion=3DSCHED]
>           <idle>-0     [001] ..s.    82.445880: softirq_entry: vec=3D9 [a=
ction=3DRCU]
>           <idle>-0     [001] ..s.    82.446093: softirq_exit: vec=3D9 [ac=
tion=3DRCU]

Softirqs done and the machine vanishes into lala land ....

And now after that gap we have a cancel/start on CPU 0

>           <idle>-0     [000] dn..   109.852709: hrtimer_cancel: hrtimer=
=109e949c
>           <idle>-0     [000] dn..   109.853043: hrtimer_start: hrtimer=10=
9e949c function=3Dtick_sched_timer expires=109770000000 softexpires=1097700=
00000

>               sh-388   [000] d.h.   109.855851: irq_handler_entry: irq=18=
 name=3Duartlite
>               sh-388   [000] d.h.   109.856751: irq_handler_exit: irq=18 =
ret=3Dhandled
>               sh-388   [000] d.h.   109.857264: irq_handler_entry: irq=18=
 name=3Duartlite
>               sh-388   [000] d.h.   109.857458: irq_handler_exit: irq=18 =
ret=3Dunhandled
>           <idle>-0     [001] d.h.   109.857684: irq_handler_entry: irq=16=
 name=3Djcore_pit
>           <idle>-0     [001] d.h.   109.857934: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] d.h.   109.858087: hrtimer_expire_entry: hrt=
imer=109f449c function=3Dtick_sched_timer now=109770452820

And this expiry happens on CPU 1, but the expiry time looks like the one
which got armed on CPU 0 above !?!?!

>           <idle>-0     [001] d.h.   109.858639: softirq_raise: vec=3D1 [a=
ction=3DTIMER]
>           <idle>-0     [001] d.h.   109.858839: softirq_raise: vec=3D9 [a=
ction=3DRCU]
>           <idle>-0     [001] d.h.   109.859097: softirq_raise: vec=3D7 [a=
ction=3DSCHED]
>           <idle>-0     [001] d.h.   109.859282: hrtimer_expire_exit: hrti=
mer=109f449c
>           <idle>-0     [001] d.h.   109.859428: hrtimer_start: hrtimer=10=
9f449c function=3Dtick_sched_timer expires=109780000000 softexpires=1097800=
00000
>           <idle>-0     [001] d.h.   109.859637: irq_handler_exit: irq=16 =
ret=3Dhandled
>           <idle>-0     [001] ..s.   109.859806: softirq_entry: vec=3D1 [a=
ction=3DTIMER]
>           <idle>-0     [001] ..s.   109.859984: softirq_exit: vec=3D1 [ac=
tion=3DTIMER]
>           <idle>-0     [001] ..s.   109.860098: softirq_entry: vec=3D7 [a=
ction=3DSCHED]
>           <idle>-0     [001] ..s.   109.860533: softirq_exit: vec=3D7 [ac=
tion=3DSCHED]
>           <idle>-0     [001] ..s.   109.860663: softirq_entry: vec=3D9 [a=
ction=3DRCU]
>           <idle>-0     [001] .ns.   109.861424: softirq_exit: vec=3D9 [ac=
tion=3DRCU]
>               sh-388   [000] d.h.   109.861831: irq_handler_entry: irq=16=
 name=3Djcore_pit
>               sh-388   [000] d.h.   109.862071: hrtimer_cancel: hrtimer=
=109e949c
>        rcu_sched-7     [001] ....   109.862141: timer_init: timer=160a9eb0
>               sh-388   [000] d.h.   109.862233: hrtimer_expire_entry: hrt=
imer=109e949c function=3Dtick_sched_timer now=109774586740

And CPU0 has it's timer firing 4.5ms late .....

>        rcu_sched-7     [001] d...   109.862317: timer_start: timer=160a9e=
b0 function=3Dprocess_timeout expiresB94948275 [timeout=3D1] flags=3D0x0000=
0001
>=20
> However no stall message appeared on the console here, and I suspect
> it might have just been a gap in event recording because it doesn't
> look terribly suspicious. At first I thought (and discussed with

Well. If there are gaps in the traces then decoding this is going to be a
nightmare.

> Daniel off-list) that the hrtimer_cancel at the end of the long gap
> might have been spinning for the whole time, but this does not match
> the behavior of the stalls I'm observing waith tracing off; by hooking

Why would it spinning? There is no way that the callback of the tick timer
runs when cancel is called. It's cpu local.....

> up LED output in the hrtimer_cancel code paths, I see rapid bursts of
> successful hrtimer_cancel (no repeated hrtimer_try_to_cancel looping)
> leading up to the rcu_sched stall message. That matches with what I'm
> seeing later in the event log, between 109s and 132s where the stall
> occurred:
>=20
>           <idle>-0     [000] d.h.   109.946127: irq_handler_entry: irq=16=
 name=3Djcore_pit
>           <idle>-0     [000] d.h.   109.946339: hrtimer_cancel: hrtimer=
=109e949c
>           <idle>-0     [000] d.h.   109.946486: hrtimer_expire_entry: hrt=
imer=109e949c function=3Dtick_sched_timer now=109858865160
>           <idle>-0     [000] d.h.   109.946714: softirq_raise: vec=3D1 [a=
ction=3DTIMER]
>           <idle>-0     [000] d.h.   109.946918: softirq_raise: vec=3D9 [a=
ction=3DRCU]
>           <idle>-0     [000] d.h.   109.947193: softirq_raise: vec=3D7 [a=
ction=3DSCHED]
>           <idle>-0     [000] d.h.   109.947364: hrtimer_expire_exit: hrti=
mer=109e949c
>           <idle>-0     [000] d.h.   109.947498: hrtimer_start: hrtimer=10=
9e949c function=3Dtick_sched_timer expires=109860000000 softexpires=1098600=
00000
>           <idle>-0     [000] d.h.   109.947736: hrtimer_cancel: hrtimer=
=109e949c
>           <idle>-0     [000] d.h.   109.947887: hrtimer_expire_entry: hrt=
imer=109e949c function=3Dtick_sched_timer now=109860266000
>           <idle>-0     [000] d.h.   109.948394: softirq_raise: vec=3D1 [a=
ction=3DTIMER]
>           <idle>-0     [000] d.h.   109.948600: softirq_raise: vec=3D9 [a=
ction=3DRCU]
>           <idle>-0     [000] d.h.   109.948870: softirq_raise: vec=3D7 [a=
ction=3DSCHED]
>           <idle>-0     [000] d.h.   109.949036: hrtimer_expire_exit: hrti=
mer=109e949c
>           <idle>-0     [000] d.h.   109.949170: hrtimer_start: hrtimer=10=
9e949c function=3Dtick_sched_timer expires=109870000000 softexpires=1098700=
00000
>           <idle>-0     [000] d.h.   109.949389: irq_handler_exit: irq=16 =
ret=3Dhandled
>           <idle>-0     [000] ..s.   109.949585: softirq_entry: vec=3D1 [a=
ction=3DTIMER]
>           <idle>-0     [000] ..s.   109.949785: softirq_exit: vec=3D1 [ac=
tion=3DTIMER]
>           <idle>-0     [000] ..s.   109.949902: softirq_entry: vec=3D7 [a=
ction=3DSCHED]
>           <idle>-0     [000] ..s.   109.950347: softirq_exit: vec=3D7 [ac=
tion=3DSCHED]
>           <idle>-0     [000] ..s.   109.950472: softirq_entry: vec=3D9 [a=
ction=3DRCU]
>           <idle>-0     [000] ..s.   109.951089: softirq_exit: vec=3D9 [ac=
tion=3DRCU]
>           <idle>-0     [001] dn..   109.951213: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] dn..   109.951476: hrtimer_start: hrtimer=10=
9f449c function=3Dtick_sched_timer expires=109870000000 softexpires=1098700=
00000
>        rcu_sched-7     [001] d...   109.952030: timer_cancel: timer=160a9=
eb0
>        rcu_sched-7     [001] ....   109.952478: timer_init: timer=160a9eb0
>        rcu_sched-7     [001] d...   109.952633: timer_start: timer=160a9e=
b0 function=3Dprocess_timeout expiresB94948284 [timeout=3D1] flags=3D0x0000=
0001

So that should kick rcu_sched-7 in 10ms, latest 20ms from now and CPU1 goes
into a NOHZ idle sleep.

>           <idle>-0     [001] d...   109.953436: tick_stop: success=3D1 de=
pendency=3DNONE
>           <idle>-0     [001] d...   109.953617: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] d...   109.953818: hrtimer_start: hrtimer=10=
9f449c function=3Dtick_sched_timer expires=109880000000 softexpires=1098800=
00000

which is (using the 0.087621us delta between the trace clock and clock
MONO) at: 109.880 + 0.087621 =3D 109.968

Which is about correct as we expect the RCU timer to fire at:
     =20
      109.952633 + 0.01 =3D 109.963633

or latest at

      109.952633 + 0.02 =3D 109.983633
  =20
There is another caveat. That nohz stuff can queue the rcu timer on CPU0, w=
hich
it did not because:

>        rcu_sched-7     [001] d...   109.952633: timer_start: timer=160a9e=
b0 function=3Dprocess_timeout expiresB94948284 [timeout=3D1] flags=3D0x0000=
0001

The CPU nr encoded in flags is: 1

Now we cancel and restart the timer w/o seing the interrupt expiring
it. And that expiry should have happened at 109.968000 !?!

>           <idle>-0     [001] d...   109.968225: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] d...   109.968526: hrtimer_start: hrtimer=10=
9f449c function=3Dtick_sched_timer expires=109890000000 softexpires=1098900=
00000

So this advances the next tick even further out. And CPU 0 sets the timer to
the exact smae value:

>           <idle>-0     [000] d.h.   109.969104: hrtimer_start: hrtimer=10=
9e949c function=3Dtick_sched_timer expires=109890000000 softexpires=1098900=
00000


>           <idle>-0     [000] d.h.   109.977690: irq_handler_entry: irq=16=
 name=3Djcore_pit
>           <idle>-0     [000] d.h.   109.977911: hrtimer_cancel: hrtimer=
=109e949c
>           <idle>-0     [000] d.h.   109.978053: hrtimer_expire_entry: hrt=
imer=109e949c function=3Dtick_sched_timer now=109890434160

Which expires here. And CPU1 instead of getting an interrupt and expiring
the timer does the cancel/restart to the next jiffie again:

>           <idle>-0     [001] d...   109.978206: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] d...   109.978495: hrtimer_start: hrtimer=10=
9f449c function=3Dtick_sched_timer expires=109900000000 softexpires=1099000=
00000

And this repeats;

>           <idle>-0     [000] d.h.   109.987726: irq_handler_entry: irq=16=
 name=3Djcore_pit
>           <idle>-0     [000] d.h.   109.987954: hrtimer_cancel: hrtimer=
=109e949c
>           <idle>-0     [000] d.h.   109.988095: hrtimer_expire_entry: hrt=
imer=109e949c function=3Dtick_sched_timer now=109900474620

>           <idle>-0     [001] d...   109.988243: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] d...   109.988537: hrtimer_start: hrtimer=10=
9f449c fun9c

There is something badly wrong here.

>           <idle>-0     [000] ..s.   110.019443: softirq_entry: vec=3D1 [a=
ction=3DTIMER]
>           <idle>-0     [000] ..s.   110.019617: softirq_exit: vec=3D1 [ac=
tion=3DTIMER]
>           <idle>-0     [000] ..s.   110.019730: softirq_entry: vec=3D7 [a=
ction=3DSCHED]
>           <idle>-0     [000] ..s.   110.020174: softirq_exit: vec=3D7 [ac=
tion=3DSCHED]
>           <idle>-0     [000] d.h.   110.027674: irq_handler_entry: irq=16=
 name=3Djcore_pit
>=20
> The rcu_sched process does not run again after the tick_stop until
> 132s, and only a few RCU softirqs happen (all shown above). During
> this time, cpu1 has no interrupt activity and nothing in the trace
> except the above hrtimer_cancel/hrtimer_start pairs (not sure how
> they're happening without any interrupts).

If you drop out of the arch idle into the core idle loop then you might end
up with this. You want to add a few trace points or trace_printks() to the
involved functions. tick_nohz_restart() tick_nohz_stop_sched_tick()
tick_nohz_restart_sched_tick() and the idle code should be a good starting
point.
=20
> This pattern repeats until almost 131s, where cpu1 goes into a frenzy
> of hrtimer_cancel/start:

It's not a frenzy. It's the same pattern as above. It arms the timer to the
next tick, but that timer never ever fires. And it does that every tick ....

Please put a tracepoint into your set_next_event() callback as well. SO
this changes here:

>           <idle>-0     [001] d...   132.198170: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] d...   132.198451: hrtimer_start: hrtimer=10=
9f449c function=3Dtick_sched_timer expires=132120000000 softexpires=1321200=
00000

>           <idle>-0     [001] dnh.   132.205860: irq_handler_entry: irq  n=
ame=3Dipi
>           <idle>-0     [001] dnh.   132.206041: irq_handler_exit: irq  re=
t=3Dhandle

So CPU1 gets an IPI

>           <idle>-0     [001] dn..   132.206650: hrtimer_cancel: hrtimer=
=109f449c
49c function=3Dtick_sched_timer now=132119115200
>           <idle>-0     [001] dn..   132.206936: hrtimer_start: hrtimer=10=
9f449c function=3Dtick_sched_timer expires=132120000000 softexpires=1321200=
00000

And rcu-sched-7 gets running magically, but we don't know what woke it
up. Definitely not the timer, because that did not fire.

>        rcu_sched-7     [001] d...   132.207710: timer_cancel: timer=160a9=
eb0


> - During the whole sequence, hrtimer expiration times are being set to
>   exact jiffies (@ 100 Hz), whereas before it they're quite arbitrary.

When a CPU goes into NOHZ idle and the next (timer/hrtimer) is farther out
than the next tick, then tick_sched_timer is set to this next event which
can be far out. So that's expected.
=20
> - The CLOCK_MONOTONIC hrtimer times do not match up with the
>   timestamps; they're off by about 0.087s. I assume this is just
>   sched_clock vs clocksource time and not a big deal.

Yes. You can tell the tracer to use clock monotonic so then they should mat=
ch.
=20
> - The rcu_sched process is sleeping with timeout=3D1. This seems
>   odd/excessive.

Why is that odd? That's one tick, i.e. 10ms in your case. And that's not
the problem at all. The problem is your timer not firing, but the cpu is
obviously either getting out of idle and then moves the tick ahead for some
unknown reason.

Thanks,

	tglx
