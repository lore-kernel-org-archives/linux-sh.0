From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 23 May 2016 20:32:35 +0000
Subject: Re: [PATCH v2 09/12] clocksource: add J-Core PIT/RTC driver
Message-Id: <20160523203235.GD6863@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <e8d3578861cfe2362e65f3f92d80ccae001c6b16.1463708766.git.dalias@libc.org>
 <20160520140156.GC6863@linaro.org>
 <20160521031515.GZ21636@brightrain.aerifal.cx>
In-Reply-To: <20160521031515.GZ21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Fri, May 20, 2016 at 11:15:16PM -0400, Rich Felker wrote:
> On Fri, May 20, 2016 at 04:01:56PM +0200, Daniel Lezcano wrote:
> > On Fri, May 20, 2016 at 02:53:04AM +0000, Rich Felker wrote:
> > > Signed-off-by: Rich Felker <dalias@libc.org>
> > > ---
> > 
> > Hi Rich,
> > 
> > please add a nice changelog describing how works the timer.
> 
> OK. Do you prefer this in changelog, comments in the source, or both?

I prefer a [detailed] description of the timer in the changelog or the file 
header. As the timer is trivial for now, I don't see the benefit of adding 
too much comments in the code.

> > Having openhardware is really awesome and that deserves a nice
> > documentation. I noticed the changelog of this patchset it very light and 
> > that's a pity regarding the potential of the J-core project.
> > 
> > I'm very much looking forward to see the J-core evolving and, IIUC, bringing 
> > kernel developer to review [and participate to] the CPU design is one of 
> > your objective and that's really cool. If you can beef up the changelog with 
> > detailed description and pointers to documentation to refer to, that will 
> > help a lot, especially when new drivers are added, to fill the gap between 
> > HW/SW.
> 
> *Nod*
> 
> > > My previous post of the patch series accidentally omitted omitted
> > > Cc'ing of subsystem maintainers for the necessary clocksource,
> > > irqchip, and spi drivers. Please ack if this looks ok because I want
> > > to get it merged as part of the arch/sh pull request for 4.7.
> > 
> > In future send the patches sooner so they can be reviewed in a relaxed way 
> > and picked up in the right tree. I doubt that will make it for 4.7.
> > 
> > >  drivers/clocksource/Kconfig     |   9 ++
> > >  drivers/clocksource/Makefile    |   1 +
> > >  drivers/clocksource/jcore-pit.c | 176 ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 186 insertions(+)
> > >  create mode 100644 drivers/clocksource/jcore-pit.c
> > > 
> > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > > index c346be6..a29fd31 100644
> > > --- a/drivers/clocksource/Kconfig
> > > +++ b/drivers/clocksource/Kconfig
> > > @@ -297,6 +297,15 @@ config SYS_SUPPORTS_SH_TMU
> > >  config SYS_SUPPORTS_EM_STI
> > >          bool
> > >  
> > > +config CLKSRC_JCORE_PIT
> > > +	bool "J-Core integrated PIT/RTC"
> > 
> > Replace by:
> > 
> > bool "J-Core integrated PIT/RTC" if COMPILE_TEST
> > 
> > Let the platform's Kconfig to select the timer. Beside, check the timer 
> > compiles correctly on other platform (eg. x86) for compilation test 
> > coverage.
> 
> So the prompt would not even appear unless COMPILE_TEST is selected? 

Correct.

> I don't mind doing it that way if this is the established best practice.
> For clocksource/clockevent, the system isn't even usable without it,
> so there's little harm in having CONFIG_CPU_J2 select CLKSRC_JCORE_PIT
> for the user. On the other hand, some of the drivers like the SPI
> master, (future) EMAC, etc. are things you might want to be able to
> turn off to build a size-optimized kernel for a system that doesn't
> need (or doesn't even have) them, so this approach does not seem to
> make sense for other such drivers.
> 
> My main theoretical concern here is what happens if someone uses the
> J2 cpu core with completely different SoC peripherals hooked up to it,
> and doesn't want to be forced to build the jcore-pit driver. Is this
> type of thing an issue people have thought about and reached a
> canonical solution to?

In this case it is the SoC's Kconfig which is in charge of setting the right 
parameter not the CPU's Kconfig option. This is what we find in the ARM 
configs file where the ARMv7 is the "CPU" but the SoC is different.

But if these timers are local to the CPU, there is a good chance nobody will 
change that as they are the most efficient and certainly well fitted for 
power management. I believe the timer supposed to work as the broadcast 
timer is more subject to change.

IMO, some clarifications about the CPU design and these timers may be 
needed. If the local timers are specified as part of the CPU, then 
CONFIG_CPU_J2 => CONFIG_JCORE_PIT, otherwise CONFIG_SOC_J2_BASED => 
CONFIG_CPU_J2 [+ CONFIG_JCORE_PIT].

[ ... ]

> > > +/*
> > > + * J-Core SoC PIT/RTC driver
> > 
> > Is it really RTC ? :)
> 
> That's the name used in the hardware. It's a settable clock counting
> seconds/nanoseconds and it's the most appropriate thing the hardware
> has for a clocksource device. The old kernel patches that existed when
> I took over were not using it and instead used jiffies and a PIT
> register that returned ns since the last timer interrupt, which is now
> unused (that approach precluded dyntick).

Ok, just for clarification. From Linux, a RTC is different from a 
clocksource. The former is backed up with a battery, relies almost always on 
a quartz and populates /dev/rtc, the latter is based on a clock (which can 
vary) and is volatile. Naming it RTC is confusing as it is a clocksource 
(and RTC falls under drivers/rtc).

> > Please fix the names to have something more accurate (eg. 
> > jcore_clockevent, jcore_clocksource) regarding how the other drivers are 
> > named.
> 
> Filename/Kconfig/etc., or names in the source? I think you mean the
> latter but I just want to check.

Yes, it is the latter.

[ ... ]

> > > +#include <asm/io.h>
> > > +#include <asm/irq.h>
> > > +#include <asm/rtc.h>
> > 
> > Are all these headers really needed ?
> 
> I'll re-check. Sorry I didn't notice the list had gotten so long. This
> code evolved from a pre-DT board file that also had interrupt
> controller and experimental SMP stuff in it and I never went back to
> check what was really needed.
> 
> > > +static unsigned char __iomem *pit_base;
> > 
> > s/unsigned char/void/
> 
> OK. I cringe at doing arithmetic on void*, but that seems to be the
> convention in the kernel.
> 
> > > +static int pit_irq;
> > > +static u32 percpu_offset;
> > > +static u32 enable_val;
> > > +static struct clock_event_device __percpu *pit_percpu;
> > 
> > Are the clockevents per cpu on the J2 ?
> 
> Yes. There's an instance of the PIT (which is actually attached to an
> interrupt controller in the hardware) for each cpu. The smp support is
> not in this patch series since it's still new and there's no public
> board-target suporting smp, but there will be soon.
> 
> > Is there any documentation 
> > describing this hardware I can refer to ?
> 
> There's the vhdl source. I'm not sure what else is publicly available
> right now; I'll check on it for you.

Great, thank you.

[ ... ]

> > s/1000000000/NSEC_PER_SEC/
> 
> OK.
> 
> > > +}
> > 
> > Do you really, really, want to use the 64bits ? There is no real benefit and 
> > it has a significant overhead. The impact on a j-core could be really not 
> > negligible IMHO.
> 
> With just 32-bit, there's no way the cpu could sleep more than 4
> seconds without time desynchronization. 

What do you mean by time 'desynchronization' ?

> Right now it doesn't seem to
> do that anyway (max seems like abou 1-1.5 sec) but it feels like a
> shame to preclude it. I agree there's some serious cost to the 64-bit
> arithmetic though to weigh in. One option would be trying to avoid
> using the high part of seconds, but I think this hits a (admittedly
> largely theoretical) discontinuity in the resulting nanosecond count
> when seclo overflows.

IIUC your comment, the timekeeping layer is supposed to compensate, that's 
why the .mask below is for. It could be a good idea to benchmark 32/64b and 
then take a decision from there.

[ ... ]

> > > +static int pit_set(unsigned long delta, struct clock_event_device 
> > > *ced)
> > > +{
> > > +	unsigned cpu = smp_processor_id();
> > > +
> > > +	pit_disable(ced);
> > 
> > Move out the function pit_disabled().
> 
> I don't understand what you're asking for here. The "throttle"
> register is only programmable when the enable bit is clear, so disable
> has to be called before setting the timer. Are you saying there should
> be a separate disable "helper function" from the function whose
> address is stored in the clockevent device set_state_shutdown pointer?
> 
> > > +	writel(delta, pit_base + percpu_offset*cpu + REG_THROT);
> > > +	writel(enable_val, pit_base + percpu_offset*cpu + REG_PITEN);
> > 
> > Write an enable function and move it out.
> 
> So the set function should call pit_disable, then write the throttle
> register, then call pit_enable?

What I meant is to create simple and trivial functions, like foo_set, 
foo_enable, foo_disable, ... so we can call them from set_periodic, 
set_next_event, ...

[ ... ]

> > static void pit_set_periodic(struct clock_event_device *ced)
> > {
> > 	__iomem void *addr = to_jcore_clkevt(ced)->addr;
> > 	unsigned long period = readl(addr + REG_BUSPD);
> > 
> > 	pit_disable(addr);
> > 	pit_set(period, addr);
> > 	pit_enabled(addr);
> > }
> > 
> > static void pit_set_next_event(unsigned long delta, struct 
> > clock_event_device *ced)
> > {
> > 	__iomem void *addr = to_jcore_clkevt(ced)->addr;
> > 
> > 	pit_disable(addr);
> > 	pit_set(delta, addr);
> > 	pit_enable(addr);
> > }
> > 
> > (jcore_set_next_event, jcore_set_periodic)
> 
> OK.
> 
> > > +	clockevents_config_and_register(ced, DIV_ROUND_CLOSEST(1000000000, per),
> > > +	                                1, 0xffffffff);
> > > +
> > > +	pit_set_periodic(ced);
> > 
> > It is up to the time framework to set this.
> 
> To call the set_periodic function? OK.
> 
> > I don't see enable_percpu_irq / disable_percpu_irq in this driver.
> 
> I was unable to get the percpu irq framework to work correctly with my
> driver for the interrupt controller. Looking at some other irqchip
> drivers now, it seems they have to call irq_set_percpu_devid from the
> domain mapping function (or somewhere) exactly once, but I don't see
> any good way to know whether to do this. In principle at the hw level
> all irqs are percpu, but most peripherals' irq lines are only wired to
> cpu0.

Mmh, that may need further investigation. Does the j2core-stable kernel work 
on the numato ?

> > > +	return 0;
> > > +}
> > > +
> > > +static int pit_cpu_notify(struct notifier_block *self, unsigned long action, void *hcpu)
> > > +{
> > > +	switch (action & ~CPU_TASKS_FROZEN) {
> > > +	case CPU_STARTING:
> > > +		pit_local_init(this_cpu_ptr(pit_percpu));
> > > +		break;
> > > +	}
> > 
> > DYING is missing.
> 
> Does it need to unregister the device?

No. In case of SMP (which I understood it is not yet ready), we should 
enable/disable percpu irq. And thinking beyond for power management, if the 
timer does not belong to cpu power domain, the local timer should be powered 
down (like the exynos_mct). May be it goes too far, but it is for the 
record.

At least, disable percpu irq should be added but the percpu API seems to not 
work and SMP does not exists yet, so let's forget this for the moment.
 
[ ... ]

> > > +	clocksource_register_hz(&rtc_csd, 1000000000);
> > 
> > I suggest the rate to be passed through the DT.
> 
> Normally I would agree, the units of the hw registers are seconds and
> nanoseconds. I don't see any circumstance under which it would make
> sense to change the value here without a different hw register
> interface.

Isn't it possible the clock provider could be different for the timer on 
different SoC ?

> > > +	pit_percpu = alloc_percpu(struct clock_event_device);
> > > +	register_cpu_notifier(&pit_cpu_nb);
> > > +
> > > +	err = request_irq(pit_irq, timer_interrupt,
> > > +		IRQF_TIMER | IRQF_PERCPU, "pit", pit_percpu);
> > 
> > So, we have per CPU private IRQ with the same number, right?
> 
> Yes.
> 
> > You should use the 'percpu' API.
> > 
> >  - request_percpu_irq
> >  - enable_percpu_irq
> >  - disable_percpu_irq
> 
> Still trying to figure out how to make that work.
> 
> > The interrupt callback will have the right percpu dev_id parameter pointing 
> > to the right percpu structure. So you should not have to play with 
> > this_cpu_ptr anywhere.
> > 
> > > +	if (err) pr_err("pit irq request failed: %d\n", err);
> > 
> > CR before pr_err.
> 
> OK.
> 
> > > +	hwirq = irq_get_irq_data(pit_irq)->hwirq;
> > > +	enable_val = (1<<26) | ((hwirq&0x3c)<<18) | (hwirq<<12);
> > 
> > Can you explain? (and replace litterals by macros).
> 
> Since the PIT is actually integrated with the interrupt controller in
> the hardware, it's not tied to a fixed IRQ; it's programmable. However
> I don't know any way to represent "driver can use any irq it wants but
> should avoid sharing" in the DT, so I opted to have the DT just assign
> one. 

Sorry, I don't get the point. IIUC, the timers have private IRQ lines,
why can't they describe their own IRQs even they are the same number ?

> The above code programs it. Bit 26 is the actual enable bit, and
> the actual hw irq number (which conceptually need not match the virq
> number, although it does) gets programmed in a way thats compatible
> with the programmable interrupt priority stuff aic1 did (generating an
> appropriate priority matching what you'd get with aic2). I have
> unpolished specs from one of our hw engineers that I could review and
> see if this could be simplified/clarified.

Ok. I am not 100% sure but I think there is a glitch with the code above. I 
suspect something is missing in the irq driver.

> > > +	pit_local_init(this_cpu_ptr(pit_percpu));
> > > +}
> > 
> > I am wondering if the j2 is subject to change. It is now designable through 
> > FPGA and I imagine the design can go back and forth, no? If yes (and that's 
> > good), wouldn't make sense to make this driver (and others) highly 
> > configurable via the DT, much more than what there is now in order to 
> > prevent errata and kernel changes?
> 
> It's hard to predict exactly what might change or how it might change,
> which is why I went to the effort to redo all our old drivers in a DT
> framework. The current "jcore,pit" binding is intended only for things
> sufficiently compatible with the current programming interface work
> with drivers (or bare-metal software) written for the current
> programming interface. It's expected that we'll add new compatible
> tags if/when changes have to be made, and then the updated driver can
> use whatever new generality is needed with the new compatible tag, or
> keep working the same as it does now (possibly via more general code
> with appropriate parameter values) when the old compatible tag is
> used.

Ok, thanks.

  -- Daniel

