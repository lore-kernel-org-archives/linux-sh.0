From: Rich Felker <dalias@libc.org>
Date: Tue, 11 Oct 2016 20:28:50 +0000
Subject: Re: [PATCH v8 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161011202850.GK19318@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1475990489.git.dalias@libc.org>
 <588ea0a3175fcf5d409ca32249f24760f2f6f839.1475990489.git.dalias@libc.org>
 <20161011181812.GA1697@mai>
In-Reply-To: <20161011181812.GA1697@mai>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Tue, Oct 11, 2016 at 08:18:12PM +0200, Daniel Lezcano wrote:
>=20
> Hi Rich,
>=20
> On Sun, Oct 09, 2016 at 05:34:22AM +0000, Rich Felker wrote:
> > At the hardware level, the J-Core PIT is integrated with the interrupt
> > controller, but it is represented as its own device and has an
> > independent programming interface. It provides a 12-bit countdown
> > timer, which is not presently used, and a periodic timer. The interval
> > length for the latter is programmable via a 32-bit throttle register
> > whose units are determined by a bus-period register. The periodic
> > timer is used to implement both periodic and oneshot clock event
> > modes; in oneshot mode the interrupt handler simply disables the timer
> > as soon as it fires.
> >=20
> > Despite its device tree node representing an interrupt for the PIT,
> > the actual irq generated is programmable, not hard-wired. The driver
> > is responsible for programming the PIT to generate the hardware irq
> > number that the DT assigns to it.
> >=20
> > On SMP configurations, J-Core provides cpu-local instances of the PIT;
> > no broadcast timer is needed. This driver supports the creation of the
> > necessary per-cpu clock_event_device instances.
>=20
> For my personnal information, why no broadcast timer is needed ?

Broadcast timer is only needed if you don't have percpu local timers.
Early on in SMP development I actually tested with an ipi broadcast
timer and performance was noticably worse.

> Are the CPUs on always-on power down ?

For now they are always on and don't even have the sleep instruction
(i.e. stop cpu clock until interrupt) implemented. Adding sleep will
be the first power-saving step, and perhaps the only one for now,
since there doesn't seem to be any indication (according to the ppl
working on the hardware) that a deeper sleep would provide significant
additional savings.

> > A nanosecond-resolution clocksource is provided using the J-Core "RTC"
> > registers, which give a 64-bit seconds count and 32-bit nanoseconds
> > that wrap every second. The driver converts these to a full-range
> > 32-bit nanoseconds count.
> >=20
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> >  drivers/clocksource/Kconfig     |  10 ++
> >  drivers/clocksource/Makefile    |   1 +
> >  drivers/clocksource/jcore-pit.c | 231 ++++++++++++++++++++++++++++++++=
++++++++
> >  include/linux/cpuhotplug.h      |   1 +
> >  4 files changed, 243 insertions(+)
> >  create mode 100644 drivers/clocksource/jcore-pit.c
> >=20
> > diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> > index 5677886..95dd78b 100644
> > --- a/drivers/clocksource/Kconfig
> > +++ b/drivers/clocksource/Kconfig
> > @@ -407,6 +407,16 @@ config SYS_SUPPORTS_SH_TMU
> >  config SYS_SUPPORTS_EM_STI
> >          bool
> > =20
> > +config CLKSRC_JCORE_PIT
> > +	bool "J-Core PIT timer driver"
> > +	depends on OF && (SUPERH || COMPILE_TEST)
>=20
> Actually the idea is to have the SUPERH to select this timer, not create
> a dependency on SUPERH from here.
>=20
> We don't want to prompt in the configuration menu the drivers because it
> would be impossible to anyone to know which timer comes with which
> hardware, so we let the platform to select the timer it needs.

I thought we discussed this before. For users building a kernel for
legacy SH systems, especially in the current state where they're only
supported with hard-coded board files rather than device tree, it
makes no sense to build drivers for J-core hardware. It would make
sense to be on by default for CONFIG_SH_DEVICE_TREE with a compatible
CPU selection, but at least at this time, not for SUPERH in general.

Anyway I'd really like to do this non-invasively as long as we have a
mix of legacy and new stuff and the legacy stuff is not readily
testable. Once all of arch/sh is moved over to device tree, could we
revisit this and make all the drivers follow a common policy (on by
default if they're associated with boards/SoCs using a matching or
compatible CPU model, or something like that, but still able to be
disabled manually, since the user might be trying to get a tiny-ish
embedded kernel)?

> The exception is to enable in order to compile on non-native platform to
> compile-test a bunch of drivers (eg. compile most of the clocksource /=20
> clockevents drivers on a x86 big server).
>=20
> That's why we should have:
>=20
> config CLKSRC_JCORE_PIT
> 	bool "J-Core PIT timer driver" if COMPILE_TEST
>=20
> So the jcore pit driver option appears only if compile test is enabled
> otherwise it is a silent option and the user doesn't have to deal with
> it. Having consistent dependency like the other drivers will help future
> changes to consolidate the Kconfig.

I don't think this matches the user expectation for the arch yet. For
now we have a j2_defconfig that enables the drivers and other kernel
settings expected to be useful for J-core socs. I want to modernize
this all but that's a separate project.

> [ ... ]             =20
>=20
> > +#define REG_PITEN		0x00
> > +#define REG_THROT		0x10
> > +#define REG_COUNT		0x14
> > +#define REG_BUSPD		0x18
> > +#define REG_SECHI		0x20
> > +#define REG_SECLO		0x24
> > +#define REG_NSEC		0x28
> > +
> > +struct jcore_pit {
> > +	struct clock_event_device	ced;
> > +	__iomem void			*base;
>=20
> It is not '__iomem void *' but 'void __iomem *'. This appears multiple
> times in this code.

OK, I'll change that.

> > +	unsigned long			periodic_delta;
> > +	unsigned			cpu;
>=20
> This field is pointless, 'cpu' is only used for a trace in the init
> function which has already the cpu has parameter.

OK, will remove. It was needed for the old notify framework but not
for cpu hotplug framework, I think.

> > +	u32				enable_val;
> > +};
> > +
> > +static __iomem void		*jcore_pit_base;
>=20
> static void __iomem *jcore_pit_base;

OK.

> > +struct jcore_pit __percpu	*jcore_pit_percpu;
>=20
> static.

OK.

> [ ... ]
>=20
> > +static int __init jcore_pit_init(struct device_node *node)
> > +{
>=20
> [ ...=C2=A0]

Was there something analogous you wanted me to change here, or just
leftover quoting?

> > +	/*
> > +	 * The J-Core PIT is not hard-wired to a particular IRQ, but
> > +	 * integrated with the interrupt controller such that the IRQ it
> > +	 * generates is programmable. The programming interface has a
> > +	 * legacy field which was an interrupt priority for AIC1, but
> > +	 * which is OR'd onto bits 2-5 of the generated IRQ number when
> > +	 * used with J-Core AIC2, so set it to match these bits.
> > +	 */
> > +	hwirq =3D irq_get_irq_data(pit_irq)->hwirq;
> > +	irqprio =3D (hwirq >> 2) & PIT_PRIO_MASK;
> > +	enable_val =3D (1U << PIT_ENABLE_SHIFT)
> > +		   | (hwirq << PIT_IRQ_SHIFT)
> > +		   | (irqprio << PIT_PRIO_SHIFT);
> > +
>=20
> Why mention AIC1 if there is not test to check if AIC1 || AIC2 ?
>=20
> Will be the same information available if the irqchip is AIC1 ?

The bit layout of the PIT enable register is:

	.....e..ppppiiiiiiii............

where the .'s indicate unrelated/unused bits, e is enable, p is
priority, and i is hard irq number.

For the PIT included in AIC1 (obsolete but still in use), any hard irq
(trap number) can be programmed via the 8 iiiiiiii bits, and a
priority (0-15) is programmable separately in the pppp bits.

For the PIT included in AIC2 (current), the programming interface is
equivalent modulo interrupt mapping. This is why a different
compatible tag was not used. However only traps 64-127 (the ones
actually intended to be used for interrupts, rather than
syscalls/exceptions/etc.) can be programmed (the high 2 bits of i are
ignored) and the priority pppp is <<2'd and or'd onto the irq number.
This was a poor decision made on the hardware engineering side based
on a wrong assumption that preserving old priority mapping of outdated
software was important, whereas priorities weren't/aren't even being
used.

When we do the next round of interrupt controller improvements (AIC3)
the PIT programming interface should remain compatible with the
driver; likely the priority bits will just be ignored.

If we do want to change the programming interface beyond this at some
point (that maay be a good idea, since we have identified several
things that are less than ideal for Linux, like the sechi/seclo/ns
clocksource), a new compatible tag will be added instead.

> I have to admin I find strange this driver has to invoke irq_get_irq_data=
(),
> it is the only one and it sounds even strange it has to be stored per cpu=
 below.

The timer will not actually generate the irq it's assigned to (or any
interrupt at all) unless/until it's programmed for the (hard) irq
number. The need to use irq_get_irq_data comes from the fact that the
hardware needs the hard irq number, not a virq number, which could in
principle be different.

There's probably some argument that could have been made that the
irqchip and clocksource/timer driver should have been unified since
they're unified in the hardware and have this awkward programming
relationship, but that didn't fit the Linux model very well and I
think having them factored like this encourages future versions of the
hardware to adapt to the model the software wants.

Rich
