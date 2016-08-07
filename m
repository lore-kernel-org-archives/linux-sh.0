From: Nicolai Stange <nicstange@gmail.com>
Date: Sun, 07 Aug 2016 21:48:49 +0000
Subject: [QUESTION] clocksource, sh_cmt: can the clk rate change after dev registration?
Message-Id: <87bn14p7we.fsf@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,

as a preliminary to developing my RFC patch series [1] ("adapt
clockevents frequencies to mono clock") any further, I need to make sure
that the clockevent core gets informed about any rate settings being
made _after_ a clockevent device's (ced) registration.

Luckily, only a total of four ced providers do this without a call to
clockevents_update_freq(), all of which are somehow related to
"renesas".

So, the idea was to hook into clockevents_update_freq() and change those
four "renesas" ced providers to either call that or to do their rate
initialization before ced registration.

As a starting point, I chose drivers/clocksource/sh_cmt.c
(drivers/clocksource/sh_tmu.c seems to be very similar though).

The CMT ced is registered with a dummy frequency of 1Hz. It's real rate
is then set from either of its ->set_state_periodic() and
->set_state_oneshot() (both call sh_cmt_clock_event_start()). This
forbids the use of clockevents_update_freq() from there already: the
latter potentially calls ->set_state_periodic() again, leading to
infinite recursion.
(Sure, I could hook into clockevents_config() rather than
 clockevents_update_freq() and call that one from the CMT driver. But
 since many other drivers simply set the ->mult and ->shift values
 manually before doing a plain clockevents_register_device(), I had to
 hook into that one, too.)

This would all be doable (albeit somewhat ugly), but what really puzzles
me is, what it is that makes the renesas drivers so special? If the CMT
driver did its ced's rate "calculation" before registration, all would
be fine.

That being said, there seems to be some back and forth for the
/clocksource/ device in the CMT driver regarding that question: we have
  f4d7c3565c16 ("clocksource: sh_cmt: compute mult and shift before
                 registration")
as well as
  3593f5fe40a1 ("clocksource: sh_cmt: __clocksource_updatefreq_hz() update")

The latter patch reinstalls the 1Hz dummy initialization for the
clocksource device and says:

  Without this patch the old code uses clocksource_register()
  together with a hack that assumes a never changing clock rate

Its corresponding submission email [2] states that it has been tested
with the "sh7372 Mackerel board", so I suppose the problem that patch
fixed could have been observable on that board.  However, this board is
gone since commit 59b89af1d555 ("ARM: shmobile: sh7372: Remove Legacy C
SoC code").

I've been searching for some clk_set_rate() or alike done after any
sh_cmt_probe() for quite some time now and I haven't found any: on both,
ARM (mach-shmobile) and SH, the clock tree seems to be fully setup after
time_init() (which does clk_init()) and any CMT device instantiation is
done afterwards only:
- the earlytimers on SH are instantiated through late_time_init()
- otherwise, the sh_cmt driver is registered through an initcall.

So, no (relevant) clock rate changes after sh_cmt_probe() anymore?
Might the issue fixed by 3593f5fe40a1 ("clocksource: sh_cmt:
__clocksource_updatefreq_hz() update") have been gone now and it is safe
to set the clocksource as well as the clockevent device's rate *before*
registration again?


I'd really appreciate your help here!

Thank you in advance,

Nicolai


[1] http://lkml.kernel.org/r/20160713130017.8202-1-nicstange@gmail.com
[2] http://marc.info/?l=linux-kernel&m0373795001449&w=2
