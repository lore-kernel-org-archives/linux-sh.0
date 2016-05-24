From: Rich Felker <dalias@libc.org>
Date: Tue, 24 May 2016 02:25:05 +0000
Subject: Re: [PATCH v2 09/12] clocksource: add J-Core PIT/RTC driver
Message-Id: <20160524022505.GI21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <e8d3578861cfe2362e65f3f92d80ccae001c6b16.1463708766.git.dalias@libc.org>
 <20160520140156.GC6863@linaro.org>
 <20160521031515.GZ21636@brightrain.aerifal.cx>
 <20160523203235.GD6863@linaro.org>
In-Reply-To: <20160523203235.GD6863@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Mon, May 23, 2016 at 10:32:35PM +0200, Daniel Lezcano wrote:
> On Fri, May 20, 2016 at 11:15:16PM -0400, Rich Felker wrote:
> > On Fri, May 20, 2016 at 04:01:56PM +0200, Daniel Lezcano wrote:
> > > On Fri, May 20, 2016 at 02:53:04AM +0000, Rich Felker wrote:
> > > > Signed-off-by: Rich Felker <dalias@libc.org>
> > > > ---
> > > 
> > > Hi Rich,
> > > 
> > > please add a nice changelog describing how works the timer.
> > 
> > OK. Do you prefer this in changelog, comments in the source, or both?
> 
> I prefer a [detailed] description of the timer in the changelog or the file 
> header. As the timer is trivial for now, I don't see the benefit of adding 
> too much comments in the code.

OK, my question was just changelog (commit message) vs block comment
in file header. I tend to prefer commit messages because they're
linked to a point in time and don't run the risk of getting out of
sync with the file contents as changes are made, but I can do
whichever you prefer.

BTW if we get this in a form you're ok with, can you ack it to be
pulled as part of my tree (sh arch) or do you want it to go through
your channel to upstream?

> > > Let the platform's Kconfig to select the timer. Beside, check the timer 
> > > compiles correctly on other platform (eg. x86) for compilation test 
> > > coverage.
> > 
> > So the prompt would not even appear unless COMPILE_TEST is selected? 
> 
> Correct.
> 
> > I don't mind doing it that way if this is the established best practice.
> > For clocksource/clockevent, the system isn't even usable without it,
> > so there's little harm in having CONFIG_CPU_J2 select CLKSRC_JCORE_PIT
> > for the user. On the other hand, some of the drivers like the SPI
> > master, (future) EMAC, etc. are things you might want to be able to
> > turn off to build a size-optimized kernel for a system that doesn't
> > need (or doesn't even have) them, so this approach does not seem to
> > make sense for other such drivers.
> > 
> > My main theoretical concern here is what happens if someone uses the
> > J2 cpu core with completely different SoC peripherals hooked up to it,
> > and doesn't want to be forced to build the jcore-pit driver. Is this
> > type of thing an issue people have thought about and reached a
> > canonical solution to?
> 
> In this case it is the SoC's Kconfig which is in charge of setting the right 
> parameter not the CPU's Kconfig option. This is what we find in the ARM 
> configs file where the ARMv7 is the "CPU" but the SoC is different.

My intent in overhauling arch/sh to device tree is not to have
SoC-specific kernels, but to be able to make a single kernel that
works on any SoC with matching cpu isa. Not being able to select the
drivers needed without they getting implicitly selected via a
SoC-specific Kconfig option rather undermines that.

It's certainly plausible to have a user-configurable arch/sh Kconfig
option "Include J-Core SoC drivers" that selects all of the SoC
peripheral drivers, but that doesn't seem like the proper modern way
of doing things...

> But if these timers are local to the CPU, there is a good chance nobody will 
> change that as they are the most efficient and certainly well fitted for 
> power management. I believe the timer supposed to work as the broadcast 
> timer is more subject to change.
> 
> IMO, some clarifications about the CPU design and these timers may be 
> needed. If the local timers are specified as part of the CPU, then 
> CONFIG_CPU_J2 => CONFIG_JCORE_PIT, otherwise CONFIG_SOC_J2_BASED => 
> CONFIG_CPU_J2 [+ CONFIG_JCORE_PIT].

In our hw abstraction, almost nothing is considered "part of the cpu".
Even things like the "L1" cache controller are modelled as DT nodes.
This makes it possible to do custom stripped-down SoCs etc. or to
experiment with completely different designs for one or more
components while reusing everything else.

> > > > +/*
> > > > + * J-Core SoC PIT/RTC driver
> > > 
> > > Is it really RTC ? :)
> > 
> > That's the name used in the hardware. It's a settable clock counting
> > seconds/nanoseconds and it's the most appropriate thing the hardware
> > has for a clocksource device. The old kernel patches that existed when
> > I took over were not using it and instead used jiffies and a PIT
> > register that returned ns since the last timer interrupt, which is now
> > unused (that approach precluded dyntick).
> 
> Ok, just for clarification. From Linux, a RTC is different from a 
> clocksource. The former is backed up with a battery, relies almost always on 
> a quartz and populates /dev/rtc, the latter is based on a clock (which can 
> vary) and is volatile. Naming it RTC is confusing as it is a clocksource 
> (and RTC falls under drivers/rtc).

Yes, I'll try to come up with a name that's less confusing in a Linux
context but still makes sense with the hardware source.

> > > Is there any documentation 
> > > describing this hardware I can refer to ?
> > 
> > There's the vhdl source. I'm not sure what else is publicly available
> > right now; I'll check on it for you.
> 
> Great, thank you.
> 
> [ ... ]
> 
> > > s/1000000000/NSEC_PER_SEC/
> > 
> > OK.
> > 
> > > > +}
> > > 
> > > Do you really, really, want to use the 64bits ? There is no real benefit and 
> > > it has a significant overhead. The impact on a j-core could be really not 
> > > negligible IMHO.
> > 
> > With just 32-bit, there's no way the cpu could sleep more than 4
> > seconds without time desynchronization. 
> 
> What do you mean by time 'desynchronization' ?

What I meant was that, if you sleep (no timer interrupts) for 10s, and
the clocksource count is 32-bit, then after waking up you can't
distinguish between the following 3 cases:

- 10s elapsed
- 5.705032704s elapsed
- 1.410065408s elapsed

Note that you can't just cheat by knowing how long you programmed the
clock event device to sleep for, because another interrupt can be what
wakes the cpu up from sleeping. So it seems like 32-bit clocksource
precludes long sleeps.

Like I said, though, I don't think the kernel even tries to do them
now, so it's probably a non-issue at least in the short term.

> What I meant is to create simple and trivial functions, like foo_set, 
> foo_enable, foo_disable, ... so we can call them from set_periodic, 
> set_next_event, ...

OK.

> > > I don't see enable_percpu_irq / disable_percpu_irq in this driver.
> > 
> > I was unable to get the percpu irq framework to work correctly with my
> > driver for the interrupt controller. Looking at some other irqchip
> > drivers now, it seems they have to call irq_set_percpu_devid from the
> > domain mapping function (or somewhere) exactly once, but I don't see
> > any good way to know whether to do this. In principle at the hw level
> > all irqs are percpu, but most peripherals' irq lines are only wired to
> > cpu0.
> 
> Mmh, that may need further investigation.

Yeah. It's really confusing to me. The kernel's percpu irq stuff seems
like it has a strong assumption that an irq being percpu or not is a
property of the interrupt controller hardware rather than how it's
configured for the device attached to the irq. But it works fine
without using that layer in practice, just using normal percpu storage
allocation and the percpu irq flag and/or flags to request a hard irq
handler rather than tasklet or whatever (so that the handler
necessarily runs on the cpu the irq was delivered to).

> Does the j2core-stable kernel work 
> on the numato ?

Which kernel are you calling j2core-stable? With the patch series
under discussion right now, it works on the numato. You need at least
the config options from j2_defconfig and the SD card you boot from
needs both the vmlinux and a dt.dtb built from j2_mimas_v2.dts (also
provided in this patch series). Future versions of the FPGA bitstream
(once the DT bindings are approved) will include the DTB in the boot
rom and won't need a dt.dtb on the SD card.

> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int pit_cpu_notify(struct notifier_block *self, unsigned long action, void *hcpu)
> > > > +{
> > > > +	switch (action & ~CPU_TASKS_FROZEN) {
> > > > +	case CPU_STARTING:
> > > > +		pit_local_init(this_cpu_ptr(pit_percpu));
> > > > +		break;
> > > > +	}
> > > 
> > > DYING is missing.
> > 
> > Does it need to unregister the device?
> 
> No. In case of SMP (which I understood it is not yet ready), we should 
> enable/disable percpu irq. And thinking beyond for power management, if the 
> timer does not belong to cpu power domain, the local timer should be powered 
> down (like the exynos_mct). May be it goes too far, but it is for the 
> record.
> 
> At least, disable percpu irq should be added but the percpu API seems to not 
> work and SMP does not exists yet, so let's forget this for the moment.

SMP has been working fine for several months on SEI's commercial
hardware using J2, and on the prototype Turtle boards we just got. The
main reasons I've held off from including SMP in this patch series are
that it's a bit more invasive in otherwise-unrelated arch/sh files,
and that it doesn't really make sense to put something in the upstream
kernel when there's no publicly available hardware that you can use it
on.

> > > > +	clocksource_register_hz(&rtc_csd, 1000000000);
> > > 
> > > I suggest the rate to be passed through the DT.
> > 
> > Normally I would agree, the units of the hw registers are seconds and
> > nanoseconds. I don't see any circumstance under which it would make
> > sense to change the value here without a different hw register
> > interface.
> 
> Isn't it possible the clock provider could be different for the timer on 
> different SoC ?

What I'm saying is that the 3 registers being read to produce the
counter are nominally seconds-hi, seconds-lo, and nanoseconds. While I
see how clocksource base could be considered a parameter that can vary
if there were just one hw register that was the counter, I don't see
how anything but NSEC_PER_SEC makes sense as a base with this register
interface.

> > > > +	hwirq = irq_get_irq_data(pit_irq)->hwirq;
> > > > +	enable_val = (1<<26) | ((hwirq&0x3c)<<18) | (hwirq<<12);
> > > 
> > > Can you explain? (and replace litterals by macros).
> > 
> > Since the PIT is actually integrated with the interrupt controller in
> > the hardware, it's not tied to a fixed IRQ; it's programmable. However
> > I don't know any way to represent "driver can use any irq it wants but
> > should avoid sharing" in the DT, so I opted to have the DT just assign
> > one. 
> 
> Sorry, I don't get the point. IIUC, the timers have private IRQ lines,
> why can't they describe their own IRQs even they are the same number ?
> 
> > The above code programs it. Bit 26 is the actual enable bit, and
> > the actual hw irq number (which conceptually need not match the virq
> > number, although it does) gets programmed in a way thats compatible
> > with the programmable interrupt priority stuff aic1 did (generating an
> > appropriate priority matching what you'd get with aic2). I have
> > unpolished specs from one of our hw engineers that I could review and
> > see if this could be simplified/clarified.
> 
> Ok. I am not 100% sure but I think there is a glitch with the code above. I 
> suspect something is missing in the irq driver.

I don't follow. The code is working as-is. All it does is program the
PIT to generate the interrupt that the DT says it generates, and to
generate it on a nonzero priority. I'll break down the computation
into a form that makes sense, though.

At this point I'm about done with the changes you requested short of
using the percpu irq stuff (that doesn't seem to work), as well as
changes requested by reviewers of the other patches in the series.
I'll post a v3 patchset after reviewing it all tomorrow.

Rich
