From: Rich Felker <dalias@libc.org>
Date: Tue, 27 Sep 2016 22:08:20 +0000
Subject: Re: [PATCH v7 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20160927220820.GH19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1474693319.git.dalias@libc.org>
 <22c1ee0f908fe3bf8b70f5e87d659ceb29af1434.1474693319.git.dalias@libc.org>
 <20160926210716.GA12855@brightrain.aerifal.cx>
 <4b02ba7d-4a31-297a-bbbd-be26da615e7b@linaro.org>
 <20160926222352.GE19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1609261936130.4915@nanos>
 <20160927004258.GF19318@brightrain.aerifal.cx>
In-Reply-To: <20160927004258.GF19318@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Mon, Sep 26, 2016 at 08:42:58PM -0400, Rich Felker wrote:
> On Mon, Sep 26, 2016 at 07:55:13PM -0400, Thomas Gleixner wrote:
> > On Mon, 26 Sep 2016, Rich Felker wrote:
> > > On Mon, Sep 26, 2016 at 11:27:14PM +0200, Daniel Lezcano wrote:
> > > Based on use of ftrace, I was able to see situations where a second
> > > timer hardirq happened immediately after one occurred, before the
> > > timer softirq could run. My theory is that this is causing some kind
> > > of feedback loop where new timer expirations keep getting scheduled
> > > with a very short interval such that the softirq never gets to run
> > > (until other interrupt activity disrups the feedback loop). I tried
> > > reverting 4e85876a9d2a977b4a07389da8c07edf76d10825 which seemed
> > > relevant and it didn't help, but on further review (right now) there
> > > seem to be a few related commits just before it that might be
> > > responsible for the regression. I'll see if I can dig up anything else
> > > useful.
> >=20
> > Interesting theory, but lets look at the data from the other thread:
> >=20
> >          <idle>-0     [001] d.h.  2646.702790: irq_handler_entry: irqr =
name=3Djcore_pit
> >           <idle>-0     [001] d.h.  2646.703398: softirq_raise: vec=3D1 =
[action=3DTIMER]
> >           <idle>-0     [001] d.h.  2646.703607: softirq_raise: vec=3D9 =
[action=3DRCU]
> >           <idle>-0     [001] d.h.  2646.703884: softirq_raise: vec=3D7 =
[action=3DSCHED]
> >           <idle>-0     [001] d.h.  2646.704191: irq_handler_exit: irqr =
ret=3Dhandled
> >=20
> > So it takes 1.4ms to finish the timer irq handler
> >=20
> >           <idle>-0     [001] d.H.  2646.704509: irq_handler_entry: irqr=
 name=3Djcore_pit
> >           <idle>-0     [001] d.H.  2646.704990: softirq_raise: vec=3D1 =
[action=3DTIMER]
> >           <idle>-0     [001] d.H.  2646.705182: softirq_raise: vec=3D9 =
[action=3DRCU]
> >           <idle>-0     [001] d.H.  2646.705465: softirq_raise: vec=3D7 =
[action=3DSCHED]
> >           <idle>-0     [001] d.H.  2646.705761: irq_handler_exit: irqr =
ret=3Dhandled
> >=20
> > And 1.2ms in this case
> > 	 =20
> >=20
> >           <idle>-0     [001] d.H.  2646.706071: irq_handler_entry: irqr=
 name=3Djcore_pit
> >           <idle>-0     [001] d.H.  2646.706328: irq_handler_exit: irqr =
ret=3Dhandled
> >=20
> > So this one is actually short enough that the soft interrupt can excute=
 and
> > obviously no new timer is scheduled close enough.
> >=20
> >           <idle>-0     [001] ..s.  2646.706530: softirq_entry: vec=3D1 =
[action=3DTIMER]
> >=20
> > Now the obvious question arises: Why is that handler taking that long? =
And
>=20
> I'm not sure. Even at our clock rate of 50 MHz, 1.2ms is 60000 cycles.
> It's possible much of that overhead is coming from ftrace. I can play
> around again with just logging the minimum intervals that are
> programmed, and not using ftrace.
>=20
> > sure the next event being programmed shortely after the other has to do
> > with various factors (HZ setting, High-resolution timers enabled?). W/o
> > having the corresponding hrtimer tracepoints available (start and expir=
e)
> > it's hard to tell what's going on.
>=20
> I do have hrtimers enabled. If it would be helpful I could try again
> with traces for them enabled too.
>=20
> > But I can tell for sure that there is no feedback loop and its not
> > disrupted by some other interrupt.
>=20
> FYI no rcu_sched messages or noticable stalls were observed with
> tracing active. The cpu load from tracing is so high that I would not
> expect to see the same behavior. I probably failed to make that clear
> before; sorry.

I've managed to get a trace with a stall. I'm not sure what the best
way to share the full thing is, since it's large, but here are the
potentially interesting parts.

The first is a big time gap with no events, from 82.446093 to
109.852709:

          <idle>-0     [001] .ns.    82.431940: timer_expire_exit: timer=16=
0a9eb0
          <idle>-0     [001] .ns.    82.432088: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [001] .ns.    82.432180: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [001] .ns.    82.432380: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
     ksoftirqd/1-14    [001] ..s.    82.433042: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
     ksoftirqd/1-14    [001] ..s.    82.433166: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
     ksoftirqd/1-14    [001] ..s.    82.433258: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
     ksoftirqd/1-14    [001] ..s.    82.433428: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
       rcu_sched-7     [001] ....    82.434269: timer_init: timer=160a9eb0
       rcu_sched-7     [001] d...    82.434410: timer_start: timer=160a9eb0=
 function=3Dprocess_timeout expiresB94945532 [timeout=3D1] flags=3D0x000000=
01
             cat-394   [000] d.h.    82.437621: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
             cat-394   [000] d.h.    82.437851: hrtimer_cancel: hrtimer=109=
e949c
             cat-394   [000] d.h.    82.438006: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=82350361520
             cat-394   [000] d.h.    82.438555: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
             cat-394   [000] d.h.    82.438780: softirq_raise: vec=3D9 [act=
ion=3DRCU]
             cat-394   [000] d.h.    82.439245: hrtimer_expire_exit: hrtime=
r=109e949c
             cat-394   [000] d.h.    82.439402: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=82360000000 softexpires=82360000000
             cat-394   [000] d.h.    82.439633: irq_handler_exit: irq=16 re=
t=3Dhandled
             cat-394   [000] ..s.    82.439834: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
             cat-394   [000] ..s.    82.440011: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
             cat-394   [000] ..s.    82.440125: softirq_entry: vec=3D9 [act=
ion=3DRCU]
             cat-394   [000] ..s.    82.440416: softirq_exit: vec=3D9 [acti=
on=3DRCU]
          <idle>-0     [001] d.h.    82.443398: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [001] d.h.    82.443573: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d.h.    82.443689: hrtimer_expire_entry: hrtim=
er=109f449c function=3Dtick_sched_timer now=82356112320
          <idle>-0     [001] d.h.    82.443911: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] d.h.    82.444089: softirq_raise: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [001] d.h.    82.444306: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [001] d.h.    82.444448: hrtimer_expire_exit: hrtime=
r=109f449c
          <idle>-0     [001] d.h.    82.444592: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=82360000000 softexpires=82360000000
          <idle>-0     [001] d.h.    82.444821: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [001] ..s.    82.445034: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] ..s.    82.445222: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [001] ..s.    82.445341: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [001] ..s.    82.445745: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [001] ..s.    82.445880: softirq_entry: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [001] ..s.    82.446093: softirq_exit: vec=3D9 [acti=
on=3DRCU]
          <idle>-0     [000] dn..   109.852709: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] dn..   109.853043: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109770000000 softexpires=109770000=
000
              sh-388   [000] d.h.   109.855851: irq_handler_entry: irq=18 n=
ame=3Duartlite
              sh-388   [000] d.h.   109.856751: irq_handler_exit: irq=18 re=
t=3Dhandled
              sh-388   [000] d.h.   109.857264: irq_handler_entry: irq=18 n=
ame=3Duartlite
              sh-388   [000] d.h.   109.857458: irq_handler_exit: irq=18 re=
t=3Dunhandled
          <idle>-0     [001] d.h.   109.857684: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [001] d.h.   109.857934: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d.h.   109.858087: hrtimer_expire_entry: hrtim=
er=109f449c function=3Dtick_sched_timer now=109770452820
          <idle>-0     [001] d.h.   109.858639: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] d.h.   109.858839: softirq_raise: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [001] d.h.   109.859097: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [001] d.h.   109.859282: hrtimer_expire_exit: hrtime=
r=109f449c
          <idle>-0     [001] d.h.   109.859428: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109780000000 softexpires=109780000=
000
          <idle>-0     [001] d.h.   109.859637: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [001] ..s.   109.859806: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] ..s.   109.859984: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [001] ..s.   109.860098: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [001] ..s.   109.860533: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [001] ..s.   109.860663: softirq_entry: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [001] .ns.   109.861424: softirq_exit: vec=3D9 [acti=
on=3DRCU]
              sh-388   [000] d.h.   109.861831: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
              sh-388   [000] d.h.   109.862071: hrtimer_cancel: hrtimer=109=
e949c
       rcu_sched-7     [001] ....   109.862141: timer_init: timer=160a9eb0
              sh-388   [000] d.h.   109.862233: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109774586740
       rcu_sched-7     [001] d...   109.862317: timer_start: timer=160a9eb0=
 function=3Dprocess_timeout expiresB94948275 [timeout=3D1] flags=3D0x000000=
01

However no stall message appeared on the console here, and I suspect
it might have just been a gap in event recording because it doesn't
look terribly suspicious. At first I thought (and discussed with
Daniel off-list) that the hrtimer_cancel at the end of the long gap
might have been spinning for the whole time, but this does not match
the behavior of the stalls I'm observing waith tracing off; by hooking
up LED output in the hrtimer_cancel code paths, I see rapid bursts of
successful hrtimer_cancel (no repeated hrtimer_try_to_cancel looping)
leading up to the rcu_sched stall message. That matches with what I'm
seeing later in the event log, between 109s and 132s where the stall
occurred:

          <idle>-0     [000] d.h.   109.946127: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   109.946339: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   109.946486: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109858865160
          <idle>-0     [000] d.h.   109.946714: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] d.h.   109.946918: softirq_raise: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [000] d.h.   109.947193: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   109.947364: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   109.947498: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109860000000 softexpires=109860000=
000
          <idle>-0     [000] d.h.   109.947736: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   109.947887: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109860266000
          <idle>-0     [000] d.h.   109.948394: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] d.h.   109.948600: softirq_raise: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [000] d.h.   109.948870: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   109.949036: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   109.949170: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109870000000 softexpires=109870000=
000
          <idle>-0     [000] d.h.   109.949389: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [000] ..s.   109.949585: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] ..s.   109.949785: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [000] ..s.   109.949902: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] ..s.   109.950347: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [000] ..s.   109.950472: softirq_entry: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [000] ..s.   109.951089: softirq_exit: vec=3D9 [acti=
on=3DRCU]
          <idle>-0     [001] dn..   109.951213: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] dn..   109.951476: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109870000000 softexpires=109870000=
000
       rcu_sched-7     [001] d...   109.952030: timer_cancel: timer=160a9eb0
       rcu_sched-7     [001] ....   109.952478: timer_init: timer=160a9eb0
       rcu_sched-7     [001] d...   109.952633: timer_start: timer=160a9eb0=
 function=3Dprocess_timeout expiresB94948284 [timeout=3D1] flags=3D0x000000=
01
          <idle>-0     [001] d...   109.953436: tick_stop: success=3D1 depe=
ndency=3DNONE
          <idle>-0     [001] d...   109.953617: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d...   109.953818: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109880000000 softexpires=109880000=
000
          <idle>-0     [000] d.h.   109.957708: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   109.957918: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   109.958061: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109870441200
          <idle>-0     [000] d.h.   109.958571: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] d.h.   109.958791: softirq_raise: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [000] d.h.   109.959061: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   109.959235: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   109.959369: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109880000000 softexpires=109880000=
000
          <idle>-0     [000] d.h.   109.959591: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [000] ..s.   109.959795: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] ..s.   109.959970: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [000] ..s.   109.960088: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] ..s.   109.960529: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [000] ..s.   109.960656: softirq_entry: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [000] ..s.   109.960890: softirq_exit: vec=3D9 [acti=
on=3DRCU]
          <idle>-0     [000] d.h.   109.967689: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   109.967925: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   109.968070: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109880451380
          <idle>-0     [001] d...   109.968225: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [000] d.h.   109.968307: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] d.h.   109.968522: softirq_raise: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [001] d...   109.968526: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109890000000 softexpires=109890000=
000
          <idle>-0     [000] d.h.   109.968803: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   109.968969: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   109.969104: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109890000000 softexpires=109890000=
000
          <idle>-0     [000] d.h.   109.969324: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [000] ..s.   109.969527: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] ..s.   109.969704: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [000] ..s.   109.969815: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] ..s.   109.970266: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [000] ..s.   109.970392: softirq_entry: vec=3D9 [act=
ion=3DRCU]
          <idle>-0     [000] ..s.   109.970635: softirq_exit: vec=3D9 [acti=
on=3DRCU]
          <idle>-0     [000] d.h.   109.977690: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   109.977911: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   109.978053: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109890434160
          <idle>-0     [001] d...   109.978206: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [000] d.h.   109.978288: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] d...   109.978495: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109900000000 softexpires=109900000=
000
          <idle>-0     [000] d.h.   109.978635: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   109.978812: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   109.978945: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109900000000 softexpires=109900000=
000
          <idle>-0     [000] d.h.   109.979167: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [000] ..s.   109.979365: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] ..s.   109.979542: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [000] ..s.   109.979655: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] ..s.   109.980097: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [000] d.h.   109.987726: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   109.987954: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   109.988095: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109900474620
          <idle>-0     [001] d...   109.988243: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [000] d.h.   109.988339: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] d...   109.988537: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109910000000 softexpires=109910000=
000
          <idle>-0     [000] d.h.   109.988692: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   109.988877: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   109.989012: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109910000000 softexpires=109910000=
000
          <idle>-0     [000] d.h.   109.989232: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [000] ..s.   109.989429: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] ..s.   109.989602: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [000] ..s.   109.989717: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] ..s.   109.990160: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [000] d.h.   109.997726: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   109.997954: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   109.998094: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109910476420
          <idle>-0     [001] d...   109.998243: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [000] d.h.   109.998340: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] d...   109.998541: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109920000000 softexpires=109920000=
000
          <idle>-0     [000] d.h.   109.998692: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   109.998879: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   109.999013: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109920000000 softexpires=109920000=
000
          <idle>-0     [000] d.h.   109.999234: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [000] ..s.   109.999440: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] ..s.   109.999623: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [000] ..s.   109.999735: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] ..s.   110.000178: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [000] d.h.   110.007712: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   110.007955: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   110.008100: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109920477560
          <idle>-0     [001] d...   110.008253: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [000] d.h.   110.008334: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] d...   110.008548: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109930000000 softexpires=109930000=
000
          <idle>-0     [000] d.h.   110.008691: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   110.008875: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   110.009011: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109930000000 softexpires=109930000=
000
          <idle>-0     [000] d.h.   110.009232: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [000] ..s.   110.009435: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] ..s.   110.009610: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [000] ..s.   110.009726: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] ..s.   110.010172: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [000] d.h.   110.017731: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   110.017960: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   110.018106: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=109930482300
          <idle>-0     [001] d...   110.018252: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [000] d.h.   110.018347: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] d...   110.018552: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=109940000000 softexpires=109940000=
000
          <idle>-0     [000] d.h.   110.018701: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   110.018881: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   110.019021: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=109940000000 softexpires=109940000=
000
          <idle>-0     [000] d.h.   110.019239: irq_handler_exit: irq=16 re=
t=3Dhandled
          <idle>-0     [000] ..s.   110.019443: softirq_entry: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] ..s.   110.019617: softirq_exit: vec=3D1 [acti=
on=3DTIMER]
          <idle>-0     [000] ..s.   110.019730: softirq_entry: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] ..s.   110.020174: softirq_exit: vec=3D7 [acti=
on=3DSCHED]
          <idle>-0     [000] d.h.   110.027674: irq_handler_entry: irq=16 n=
ame=3Djcore_pit

The rcu_sched process does not run again after the tick_stop until
132s, and only a few RCU softirqs happen (all shown above). During
this time, cpu1 has no interrupt activity and nothing in the trace
except the above hrtimer_cancel/hrtimer_start pairs (not sure how
they're happening without any interrupts).

This pattern repeats until almost 131s, where cpu1 goes into a frenzy
of hrtimer_cancel/start:

          <idle>-0     [000] d.h.   130.967671: irq_handler_entry: irq=16 n=
ame=3Djcore_pit
          <idle>-0     [000] d.h.   130.967901: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [000] d.h.   130.968044: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=130880420820
          <idle>-0     [001] d...   130.968189: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [000] d.h.   130.968281: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [001] d...   130.968497: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=130890000000 softexpires=130890000=
000
          <idle>-0     [001] d...   130.978145: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d...   130.978421: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=130900000000 softexpires=130900000=
000
          <idle>-0     [001] d...   130.988149: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d...   130.988432: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=130910000000 softexpires=130910000=
000
          <idle>-0     [001] d...   130.998157: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d...   130.998439: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=130920000000 softexpires=130920000=
000
          <idle>-0     [001] d...   131.008183: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d...   131.008463: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=130930000000 softexpires=130930000=
000
          <idle>-0     [001] d...   131.018130: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d...   131.018407: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=130940000000 softexpires=130940000=
000
...
          <idle>-0     [001] d...   132.188156: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d...   132.188442: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=132110000000 softexpires=132110000=
000
          <idle>-0     [001] d...   132.198170: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [001] d...   132.198451: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=132120000000 softexpires=132120000=
000
          <idle>-0     [001] dnh.   132.205860: irq_handler_entry: irq  nam=
e=3Dipi
          <idle>-0     [000] d.h.   132.205999: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [001] dnh.   132.206041: irq_handler_exit: irq  ret=
=3Dhandled
          <idle>-0     [000] d.h.   132.206208: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   132.206350: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=130890000000 softexpires=130890000=
000
          <idle>-0     [000] d.h.   132.206590: hrtimer_cancel: hrtimer=109=
e949c
          <idle>-0     [001] dn..   132.206650: hrtimer_cancel: hrtimer=109=
f449c
          <idle>-0     [000] d.h.   132.206745: hrtimer_expire_entry: hrtim=
er=109e949c function=3Dtick_sched_timer now=132119115200
          <idle>-0     [001] dn..   132.206936: hrtimer_start: hrtimer=109f=
449c function=3Dtick_sched_timer expires=132120000000 softexpires=132120000=
000
          <idle>-0     [000] d.h.   132.206985: softirq_raise: vec=3D1 [act=
ion=3DTIMER]
          <idle>-0     [000] d.h.   132.207315: softirq_raise: vec=3D7 [act=
ion=3DSCHED]
          <idle>-0     [000] d.h.   132.207508: hrtimer_expire_exit: hrtime=
r=109e949c
          <idle>-0     [000] d.h.   132.207643: hrtimer_start: hrtimer=109e=
949c function=3Dtick_sched_timer expires=132120000000 softexpires=132120000=
000
       rcu_sched-7     [001] d...   132.207710: timer_cancel: timer=160a9eb0
          <idle>-0     [000] d.h.   132.207795: hrtimer_cancel: hrtimer=108=
d0098
          <idle>-0     [000] d.h.   132.207933: hrtimer_expire_entry: hrtim=
er=108d0098 function=3Dsched_clock_poll now=132119115200
          <idle>-0     [000] d.h.   132.208140: hrtimer_expire_exit: hrtime=
r=108d0098
          <idle>-0     [000] d.h.   132.208275: hrtimer_start: hrtimer=108d=
0098 function=3Dsched_clock_poll expires=133143986114 softexpires=133143986=
114
       rcu_sched-7     [001] ....   132.208303: timer_init: timer=160a9eb0
          <idle>-0     [000] d.h.   132.208524: hrtimer_cancel: hrtimer=109=
e949c
       rcu_sched-7     [001] d...   132.208598: timer_start: timer=160a9eb0=
 function=3Dprocess_timeout expiresB94950509 [timeout=3D1] flags=3D0x000000=
01

Ending with an IPI interrupt and rcu_sched finally getting to run.

A couple oddities I noticed:

- During the whole sequence, hrtimer expiration times are being set to
  exact jiffies (@ 100 Hz), whereas before it they're quite arbitrary.

- The CLOCK_MONOTONIC hrtimer times do not match up with the
  timestamps; they're off by about 0.087s. I assume this is just
  sched_clock vs clocksource time and not a big deal.

- The rcu_sched process is sleeping with timeout=3D1. This seems
  odd/excessive.

Any ideas what could be going on?

Rich
