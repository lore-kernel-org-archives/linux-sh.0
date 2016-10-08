From: Rich Felker <dalias@libc.org>
Date: Sat, 08 Oct 2016 16:26:14 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161008162614.GY19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20160926222352.GE19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609261936130.4915@nanos>
 <20160927004258.GF19318@brightrain.aerifal.cx>
 <20160927220820.GH19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609301319410.4799@nanos>
 <20161008013210.GX19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610081312190.5222@nanos>
In-Reply-To: <alpine.DEB.2.20.1610081312190.5222@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>

On Sat, Oct 08, 2016 at 01:32:06PM +0200, Thomas Gleixner wrote:
> On Fri, 7 Oct 2016, Rich Felker wrote:
> >=20
> > If I'm not mistaken, the bug is in tick_nohz_restart. According to the
>=20
> I think you are mistaken. Let's look at CPU0 only:

OK.

>           <idle>-0     [000] d...   150.829698: __tick_nohz_idle_enter: c=
an stop idle tick
>           <idle>-0     [000] d...   150.829774: __tick_nohz_idle_enter: e=
ntering stop_sched_tick
>           <idle>-0     [000] d...   150.830001: tick_stop: success=3D1 de=
pendency=3DNONE
>           <idle>-0     [000] d...   150.830127: hrtimer_cancel: hrtimer=
=109e949c
>           <idle>-0     [000] d...   150.830380: jcore_pit_set_next_event:=
 pit 109eccb0 0 set delta 82124660 enD10000 cntru throt=82124660
>           <idle>-0     [000] d...   150.830498: hrtimer_start: hrtimer=10=
9e949c function=3Dtick_sched_timer expires=150840000000 softexpires=1508400=
00000
>           <idle>-0     [000] d...   150.830720: jcore_pit_set_next_event:=
 pit 109eccb0 0 set delta 539823 enD10000 cntr4 throtS9823
>=20
> Tick is programmed to fire at 150.84
>=20
>           <idle>-0     [000] d...   150.830822: __tick_nohz_idle_enter: r=
eturning from stop_sched_tick
>           <idle>-0     [000] d...   150.830940: rcu_dyntick: Start 140000=
000000000 0
>           <idle>-0     [000] d...   150.831072: rcu_dyntick: End 0 1
>           <idle>-0     [000] d...   150.831165: cpu_idle: state=3D0 cpu_i=
d=3D0
>           <idle>-0     [000] d...   150.831269: rcu_dyntick: Start 1 0
>           <idle>-0     [000] ....   150.831368: cpu_startup_entry: enable=
d irqs, spinning
>=20
> CPU spins and waits for an interrupt to happen
>=20
>=20
>           <idle>-0     [000] d...   150.841530: rcu_dyntick: End 0 1
>=20
> Dropping out of the spin about the time we expect the PIT interrupt to
> fire. And an interrupt is the reason why we drop out because the 'need
> resched' flag is not set and we end up in:

OK, I missed that.

>           <idle>-0     [000] d.s.   150.841724: tick_irq_enter: update ji=
ffies via irq
>=20
> which is called from irq_enter()
>=20
>           <idle>-0     [000] d.s.   150.841918: tick_do_update_jiffies64:=
 finished do_timer(1)
>           <idle>-0     [000] d.s.   150.842348: tick_do_update_jiffies64:=
 finished updating jiffies
>=20
>=20
> So here we would expect:
>=20
>     	 irq_handler_entry: irq=16 name=3Djcore_pit
> 	 ...
> 	 irq_handler_exit .....
>     	=20
>=20
> or any other interrupt being invoked. But we see this here:

According to the trace the 'irq' is soft ('s'). I couldn't find the
code path from the idle loop to softirq but so maybe this is a bug. Is
it possible that in some cases the arch irq entry does not get
identified as a hard irq or traced and then the subsequent tick code
thinks it's running in a softirq and behaves differently? I could add
more tracing around irq entry.

>           <idle>-0     [000] d...   150.842603: __tick_nohz_idle_enter: c=
an stop idle tick
>=20
> And that's just wrong.=20

Can you explain?

> Now looking at CPU1 at the same time:
>=20
>           <idle>-0     [001] d.h.   150.841829: irq_handler_entry: irq=16=
 name=3Djcore_
>           <idle>-0     [001] d.h.   150.842054: hrtimer_cancel: hrtimer=
=109f449c
>           <idle>-0     [001] d.h.   150.842218: hrtimer_expire_entry: hrt=
imer=109f449c function=3Dtick_sched_timer now=150840579940
>=20
> So there the PIT interrupt enters and runs the interrupt handler.
>=20
> Now looking deeper at the PIT interrupts:
>=20
>      kworker/0:1-208   [000] d.h.   150.641822: irq_handler_entry: irq=16=
 name=3Djcore_pit
>      kworker/0:1-208   [000] d.h.   150.644928: irq_handler_exit: irq=16 =
ret=3Dhandled
>=20
>=20
>           <idle>-0     [001] dnh.   150.645370: irq_handler_entry: irq=16=
 name=3Djcore_pit
>           <idle>-0     [001] dnh.   150.647444: irq_handler_exit: irq=16 =
ret=3Dhandled
>=20
> Both CPUs have the same interrupt number for their per cpu PIT interrupt.
>=20
> IIRC you said earlier when the percpu interrupt discussion happened, that
> your per cpu PITs have distinct interrupt numbers, but that does not seem
> the case here.

No, I said the opposite. They use the same irq number but they're each
wired to their own cpu, and there's no way for them to fire on the
wrong cpu.

Rich
