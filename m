From: Rich Felker <dalias@libc.org>
Date: Wed, 12 Oct 2016 17:02:36 +0000
Subject: Re: [PATCH v8 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161012170236.GP19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1475990489.git.dalias@libc.org>
 <588ea0a3175fcf5d409ca32249f24760f2f6f839.1475990489.git.dalias@libc.org>
 <20161011181812.GA1697@mai>
 <20161011202850.GK19318@brightrain.aerifal.cx>
 <20161012092711.GC1697@mai>
In-Reply-To: <20161012092711.GC1697@mai>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wed, Oct 12, 2016 at 11:27:11AM +0200, Daniel Lezcano wrote:
> > > Are the CPUs on always-on power down ?
> > 
> > For now they are always on and don't even have the sleep instruction
> > (i.e. stop cpu clock until interrupt) implemented. Adding sleep will
> > be the first power-saving step, and perhaps the only one for now,
> > since there doesn't seem to be any indication (according to the ppl
> > working on the hardware) that a deeper sleep would provide significant
> > additional savings.
> 
> Ok.
> 
> However, the 'sleep' state is not, in the power management terminology,
> the idle state described above. It is called "clock gated" / "Wait for
> Interrupt".
> 
> The 'sleep' state lose the CPU context.

I use the term "sleep" because that's the name of the SH instruction
mnemonic for the opcode for entering the wait-for-interrupt state.
Sorry it's confusing like the "RTC" all over again. :-)

> > > > A nanosecond-resolution clocksource is provided using the J-Core "RTC"
> > > > registers, which give a 64-bit seconds count and 32-bit nanoseconds
> > > > that wrap every second. The driver converts these to a full-range
> > > > 32-bit nanoseconds count.
> > > > 
> > > > Signed-off-by: Rich Felker <dalias@libc.org>
> > > > ---
> > > >  drivers/clocksource/Kconfig     |  10 ++
> > > >  drivers/clocksource/Makefile    |   1 +
> > > >  drivers/clocksource/jcore-pit.c | 231 ++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/cpuhotplug.h      |   1 +
> > > >  4 files changed, 243 insertions(+)
> > > >  create mode 100644 drivers/clocksource/jcore-pit.c
> > > > 
> > > > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > > > index 5677886..95dd78b 100644
> > > > --- a/drivers/clocksource/Kconfig
> > > > +++ b/drivers/clocksource/Kconfig
> > > > @@ -407,6 +407,16 @@ config SYS_SUPPORTS_SH_TMU
> > > >  config SYS_SUPPORTS_EM_STI
> > > >          bool
> > > >  
> > > > +config CLKSRC_JCORE_PIT
> > > > +	bool "J-Core PIT timer driver"
> > > > +	depends on OF && (SUPERH || COMPILE_TEST)
> > > 
> > > Actually the idea is to have the SUPERH to select this timer, not create
> > > a dependency on SUPERH from here.
> > > 
> > > We don't want to prompt in the configuration menu the drivers because it
> > > would be impossible to anyone to know which timer comes with which
> > > hardware, so we let the platform to select the timer it needs.
> > 
> > I thought we discussed this before. For users building a kernel for
> > legacy SH systems, especially in the current state where they're only
> > supported with hard-coded board files rather than device tree, it
> > makes no sense to build drivers for J-core hardware. It would make
> > sense to be on by default for CONFIG_SH_DEVICE_TREE with a compatible
> > CPU selection, but at least at this time, not for SUPERH in general.
> 
> Probably I am missing the point but why the user would have to unselect
> this driver manually ? The user wants a config file nothing more or a very
> trivial option. Can you imagine someone can know every single IP block for
> each boards of the same arch and be able to disable/enable the right ones ?

The common case I imagine is just accepting defaults that include more
than you need, but for space-constrained (or more likely, fast boot,
when the kernel is being loaded from a slow spi-based SD card
interface) setups the user might be trying to minimize kernel size and
turn off drivers they know they don't want. I'm not so worried about
this driver, specifically, because it's small, but I am concerned
about the general policy -- when we get rid of all the legacy board
files and everything is move to device tree, will the user be stuck
including a bunch of Renesas SH drivers when building a kernel the
intend to use only on J-core?

> > Anyway I'd really like to do this non-invasively as long as we have a
> > mix of legacy and new stuff and the legacy stuff is not readily
> > testable. Once all of arch/sh is moved over to device tree, could we
> > revisit this and make all the drivers follow a common policy (on by
> > default if they're associated with boards/SoCs using a matching or
> > compatible CPU model, or something like that, but still able to be
> > disabled manually, since the user might be trying to get a tiny-ish
> > embedded kernel)?
> 
> I understand the goal is to have one single configuration and everything
> DT based and it sounds great but what is missing here is just a subarch,
> not an option to enable/disable the timer.
> 
> Give a try with:
> 
> make ARCH=arm multi_v7_defconfig menuconfig
> 
> --> System Type
> 
> That is what you are looking for, a SUPERH config option selecting all the
> common options and then a JCORE config option adding the different missing
> bits, namely the CLKSRC_JCORE_PIT.

We do have something like "system type" in arch/sh, and it's what I'm
trying to deprecate since it's the switch to select between all the
hard-coded board files, _or_ device tree.

Since part of the goal of my DT overhaul is to be able (but not
forced) to produce kernels that run on a wide range of hardware,
rather than having a "system type (select one)" option, what about
individual boolean options like:

config JCORE_SOC
	bool "Support for J-Core SoCs"
	select CLKSRC_JCORE_PIT
	select JCORE_AIC
	...

Note that there are other drivers that should probably be optional
even if you have JCORE_SOC enabled, like the SPI controller, DMA
controller (not implemented yet), Ethernet (not submitted upstream
yet), etc. Maybe they could depend on JCORE_SOC and be default-yes but
configurable if available?

In any case, the SoC support is supposedly there in the current kernel
release (4.8) but not working because of missing essential drivers, so
I'd really like to fix that without making the fix dependent on
restructuring the arch/sh system type handling, which is an ongoing,
independent project for which I'm waiting for help converting and
testing the conversions of legacy board support. My preference would
be to keep the Kconfig stuff the way I submitted it for now --
j2_defconfig already handles enabling thse right drivers -- and do
something more user-friendly as part of the bigger arch overhaul
project.

> > > > +	/*
> > > > +	 * The J-Core PIT is not hard-wired to a particular IRQ, but
> > > > +	 * integrated with the interrupt controller such that the IRQ it
> > > > +	 * generates is programmable. The programming interface has a
> > > > +	 * legacy field which was an interrupt priority for AIC1, but
> > > > +	 * which is OR'd onto bits 2-5 of the generated IRQ number when
> > > > +	 * used with J-Core AIC2, so set it to match these bits.
> > > > +	 */
> > > > +	hwirq = irq_get_irq_data(pit_irq)->hwirq;
> > > > +	irqprio = (hwirq >> 2) & PIT_PRIO_MASK;
> > > > +	enable_val = (1U << PIT_ENABLE_SHIFT)
> > > > +		   | (hwirq << PIT_IRQ_SHIFT)
> > > > +		   | (irqprio << PIT_PRIO_SHIFT);
> > > > +
> > > 
> > > Why mention AIC1 if there is not test to check if AIC1 || AIC2 ?
> > > 
> > > Will be the same information available if the irqchip is AIC1 ?
> > 
> > The bit layout of the PIT enable register is:
> > 
> > 	.....e..ppppiiiiiiii............
> > 
> > where the .'s indicate unrelated/unused bits, e is enable, p is
> > priority, and i is hard irq number.
> > 
> > For the PIT included in AIC1 (obsolete but still in use), any hard irq
> > (trap number) can be programmed via the 8 iiiiiiii bits, and a
> > priority (0-15) is programmable separately in the pppp bits.
> > 
> > For the PIT included in AIC2 (current), the programming interface is
> > equivalent modulo interrupt mapping. This is why a different
> > compatible tag was not used. However only traps 64-127 (the ones
> > actually intended to be used for interrupts, rather than
> > syscalls/exceptions/etc.) can be programmed (the high 2 bits of i are
> > ignored) and the priority pppp is <<2'd and or'd onto the irq number.
> > This was a poor decision made on the hardware engineering side based
> > on a wrong assumption that preserving old priority mapping of outdated
> > software was important, whereas priorities weren't/aren't even being
> > used.
> > 
> > When we do the next round of interrupt controller improvements (AIC3)
> > the PIT programming interface should remain compatible with the
> > driver; likely the priority bits will just be ignored.
> > 
> > If we do want to change the programming interface beyond this at some
> > point (that maay be a good idea, since we have identified several
> > things that are less than ideal for Linux, like the sechi/seclo/ns
> > clocksource), a new compatible tag will be added instead.
> 
> Ok, thanks for the clarification. Can you add your answer as a comment for
> the bits dance above ?

Are you happy with the whole quoted text above as a comment? If so I'm
happy to include it verbatim. I would lean towards condensing or
omitting the last 2 paragraphs (starting with "When we do...") if
that's okay with you since they are not documenting the hw but future
plans/policy.

Rich
