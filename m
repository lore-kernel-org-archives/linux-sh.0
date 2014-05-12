From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 12 May 2014 20:00:28 +0000
Subject: Re: [PATCH v5 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <11669031.2LAYgi9kEh@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 12 May 2014 19:00:28 Geert Uytterhoeven wrote:
> On Mon, May 12, 2014 at 4:03 PM, Laurent Pinchart wrote:
> >> On Koelsch (both legacy and reference), I get:
> >> 
> >> -sh_cmt sh_cmt.0: used for clock events
> >> -sh_cmt sh_cmt.0: used for periodic clock events
> >> +sh_cmt sh-cmt-48-gen2.0: ch0: used for clock events
> >> +sh_cmt sh-cmt-48-gen2.0: ch0: used for periodic clock events
> >> +sh_cmt sh-cmt-48-gen2.0: ch1: used as clock source
> >> +Switched to clocksource sh-cmt-48-gen2.0
> >> +Clockevents: could not switch to one-shot mode:
> >> +Clockevents: could not switch to one-shot mode: dummy_timer is not
> >> functional.
> >> +Could not switch to high resolution mode on CPU 1
> >> + dummy_timer is not functional.
> >> +Could not switch to high resolution mode on CPU 0
> >> 
> >> What's up with the high resolution mode?
> > 
> > That's surprising, I haven't noticed anything similar before. I've just
> > tested Simon's latest devel branch on both Koelsch legacy and Koelsch
> > reference, and I can't reproduce the problem.
> 
> I did some digging, as I'm usually not running directly from Simon's
> latest devel branch (currently I have 183 local commits on top of
> git:///git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git#ren
> esas-drivers-v3.15-rc5-2014-05-12).
> 
> The one-shot mode failures I can reproduce with koelsch_defconfig on
> renesas-devel-v3.15-rc5-20140511.
>
> For the high resolution mode errors you have to enable HIGH_RES_TIMERS.

Actually, after investigating the issue, this isn't really surprising, but 
it's a mess nonetheless.

First of all the problem is caused by the combination of the CMT, MTU2 and TMU 
cleanups *and* commit 521c42990e9d561ed5ed9f501f07639d0512b3c9 ("tick-common: 
Fix wrong check in tick_check_replacement()"). The latter has been merged in 
v3.15-rc2, which explains why I haven't noticed the problem before.

Then, please note that the problem only occurs when the architected timer is 
disabled in the kernel configuration, which is the case with 
koelsch_defconfig. If you enable the architected timer the error messages will 
disappear. Please also note that our current timers implementation is broken 
when the architected timer is disabled with CONFIG_PREEMPT set. We should 
discuss whether that should be fixed, but it's unrelated to this patch series.

Finally, while the kernel log diff seems to imply that the patch series 
introduced a regression in high resolution timer support, the reality is that 
high resolution timer support was silently disabled before the series.

The timers core code includes a heuristic to assign a use for every clock 
event device registered with the kernel. In the r8a7791 case we use a single 
clock event device, both before and after this patch series. As we have more 
than one CPU we can't dedicate the clock event device to one particular CPU, 
so the device gets used as a broadcast timer with one per-cpu dummy timer 
triggered by the broadcast timer using IPI. In this mode of operation the 
dummy timer only relays the broadcast timer's ticks, and the broadcast timer 
must is used in periodic mode. Neither tickless kernel nor high resolution 
timers are available in that case.

The reason why this patch set causes alarming messages being printed to the 
kernel log is related to nohz mode. With the patches applied a clock source 
device is registered, which wasn't the case before. The hrtimer interrupt 
calls the tick_check_oneshot_change() function, which checks whether oneshot 
mode is possible. Before this patch set no clock source device was available, 
and the timekeeping_valid_for_hres() call returning false resulted in 
tick_check_oneshot_change() returning early. After this patch set 
timekeeping_valid_for_hres() returns true and tick_check_oneshot_change() 
calls tick_nohz_switch_to_nohz() which in turn calls tick_switch_to_oneshot() 
to switch the timer to oneshot mode. That function fails and prints the 
messages you've noticed, as the per-cpu dummy timers can't be switched to 
oneshot mode.

I thus believe that the new messages can be ignored.

Please note that the above description corresponds to my understanding of the 
existing timers code. There could be bugs both in the code and in my 
understanding thereof :-) Daniel, I'd appreciate if you could shed some 
additional light on this.

-- 
Regards,

Laurent Pinchart
