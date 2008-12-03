From: john stultz <johnstul@us.ibm.com>
Date: Wed, 03 Dec 2008 04:04:31 +0000
Subject: Re: [PATCH 04/10] timer_inc: timer helper code, clockevent only
Message-Id: <1228277071.6140.136.camel@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <20081201103300.26620.32206.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081201103300.26620.32206.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 2008-12-02 at 14:30 +0900, Magnus Damm wrote:
> On Tue, Dec 2, 2008 at 5:29 AM, john stultz <johnstul@us.ibm.com> wrote:
> > On Mon, 2008-12-01 at 19:33 +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@igel.co.jp>
> >>
> >> This patch adds clock source/event helper code for incrementing timers.
> >>
> >> Normally tickless operation requires two timers, one for the clock source
> >> and another one for a oneshot timer event. The helper code makes it
> >> possible to use a single timer for both clock source and clock event,
> >> ie tickless with a single incrementing timer. Useful on for instance
> >> processors where all timers except one needs to be disabled for deep sleep.
> >>
> >> The clock source is calculated from the running hardware timer plus a
> >> software controlled counter which together form a 32 bit value. High
> >> accuracy of the clock source is kept by never reprogramming the hardware
> >> counter, only the hardware match value.
> >>
> >> Clock events are handled by reading out current hardware counter value
> >> and reprogramming the match register. Both periodic and oneshot modes
> >> are supported.
> >>
> >> The helper code only supports incrementing timer hardware which at
> >> matching time resets and generates an interrupt but keeps on counting.
> >> Timers counting down are not supported.
> >
> > Hey Magnus,
> >        Forgive me again for not understanding all this immediately. It just
> > seems like a fair amount of generic infrastructure, so I want to make
> > sure it really is reusable.
> 
> Hi John,
> 
> Thanks for checking my code, and sorry for not giving you enough background.
> 
> > I'm not sure your initial assertion that tickless operation requires two
> > timers is correct. Can you explain why this timer_inc structure is
> > necessary, in comparison to just having separate clockevent and
> > clocksource interfaces for one bit of hardware, like what is done with
> > the similar count-up HPET on x86?
> 
> The HPET hardware seems to come with a single counter and several
> match channels. The clocksource is connected to the counter and the
> clockevents use the first match channel to generate events. The
> clocksource counter keeps on counting and the clockevents are
> reprogrammed as they should. All fine, and the existing clocksource
> and clockevent infrastructure fits very well for this. The CMT
> hardware otoh - which the timer_inc code is designed around -
> automatically clears the counter on match...

So this sounds similar to how the PIT clocksource is implemented. Where
half is a hardware counter and the upper bits are faked via software. Is
this right, or am I misunderstanding? I'm a little cautious of these
software hacks since they can cause some trouble depending on how long
interrupt processing might be deferred. For example, while the hardware
seems to have an overflow bit(which is critical), should interrupts be
starved for too long, like what used to happen on i386 w/ SMIs, or from
other IRQ processing, I worry you might run in to trouble from double
overflow. This would be further problematic in SMP configs, but I'm not
sure if that's something the sh architecture deals with.

> I'm currently writing code for the SuperH architecture where timer
> hardware available varies depending on processor model. In most cases
> each processor comes with say two or three different types of timer
> hardware blocks, and each block comes with somewhere between one and
> three channels. Most timers are 32-bit these days, but some are 16-bit
> only. Some count up-only, others down only and some do both
> directions. Each timer channel usually comes with it's own timer
> counter. The clock driving the counter and dividing capabilities
> varies greatly.
> 
> The most straight-forward way to add support for this wide range of
> hardware is to dedicate one 32-bit timer channel for clocksource and
> another one for clockevents. For this approach the existing
> clocksource and clockevent infrastructure fits well, but the downside
> is that we need to write two drivers for the same type of hardware -
> one using the clocksource interface and one for clockevents.

I'm not sure if this is a major downside. :) They're just interface
hooks, and given the wide array of hardware that can be used for one or
both interfaces the division seems pretty reasonable to me.

> What I'm trying to do is to use a single timer channel for both
> clocksource and clockevents. This is because I want to power down as
> much hardware as possible and only use a single CMT timer channel
> which is driven by a separate 32Khz clock. If the rest of the system
> is idle then we can deep sleep by stopping the main clock and power
> off most of the processor, but still have a working clocksource and
> single shot clockevent and let them keep track of time and wake us up
> from deep sleep.

This seems like a fine goal.

> So when I hacked up my first shared timer prototype I saw that this is
> something that should be broken out. Mainly since the shared timer
> logic has nothing to do with the actual timer hardware details. And I
> know at least three types of different timer hardware types on SuperH
> that can reuse this code.
> 
> After breaking out the timer_inc code I realized that I managed to
> remove the dependency on if the timer will be used as clocksource or
> clockevent. So all of a sudden I can have a single driver and let the
> user decide how it should be used.

I guess what I'm most concerned about is that you've created yet another
interface that we have to manage and maintain, and its similar enough to
the existing interfaces that developers might be confused as to which
they should write to for their hardware.

Further I'm not sure the amount of duplication you'd end up with to
create just clocksource and clockevent drivers for the different
hardware would be more then the amount of code needed in the
registration and management, along with the clocksource and clockevent
integration of the timer_inc infrastructure.

Looking at the code again, you seem to have to indirect through a number
of interfaces:
1) cmt_device structure (actual hardware def)
2) cmt_driver and setup
3) timer_inc structure
4) clockevents and clocksource structures

It seems the cmd_driver could probably skip the timer_inc bits without
too much trouble, and just create a clockevent or clocksource structure
directly, no? 

I'm still not sure I see what necessary function the timer_inc structure
provides.

> > I just worry that we're adding extra structures and interfaces where it
> > might be better to just re-factor the clocksource and clockevent
> > structures themselves to handle the needs you have.
> 
> Yeah, especially the programming-and-retrying part of the timer_inc
> code looks very similar to the clock event code. I don't mind
> modifying existing structures at all. My not-so-qualified guess is
> that other architectures also may come with similar
> increment-match-clear timer hardware.

I definitely am interesting in trying to figure out if the clockevent
and clocksource interfaces need refinement to better adapt to hardware
if they are not sufficient. But I'm very hesitant to recommend creating
super-interfaces that try to span both.

It just seems to me that most of the timer_inc code could be pushed down
into the cmt_driver to cut out the middle man. It reduces the number of
generic interfaces we have to deal with, and lessens the indirection.

Again, I may be missing a subtlety of the timer_inc code, so keep
hammering on me if I'm just being thick headed. :) 

thanks
-john


