From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 11 Oct 2016 18:18:12 +0000
Subject: Re: [PATCH v8 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <20161011181812.GA1697@mai>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1475990489.git.dalias@libc.org>
 <588ea0a3175fcf5d409ca32249f24760f2f6f839.1475990489.git.dalias@libc.org>
In-Reply-To: <588ea0a3175fcf5d409ca32249f24760f2f6f839.1475990489.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>


Hi Rich,

On Sun, Oct 09, 2016 at 05:34:22AM +0000, Rich Felker wrote:
> At the hardware level, the J-Core PIT is integrated with the interrupt
> controller, but it is represented as its own device and has an
> independent programming interface. It provides a 12-bit countdown
> timer, which is not presently used, and a periodic timer. The interval
> length for the latter is programmable via a 32-bit throttle register
> whose units are determined by a bus-period register. The periodic
> timer is used to implement both periodic and oneshot clock event
> modes; in oneshot mode the interrupt handler simply disables the timer
> as soon as it fires.
>=20
> Despite its device tree node representing an interrupt for the PIT,
> the actual irq generated is programmable, not hard-wired. The driver
> is responsible for programming the PIT to generate the hardware irq
> number that the DT assigns to it.
>=20
> On SMP configurations, J-Core provides cpu-local instances of the PIT;
> no broadcast timer is needed. This driver supports the creation of the
> necessary per-cpu clock_event_device instances.

For my personnal information, why no broadcast timer is needed ?

Are the CPUs on always-on power down ?

> A nanosecond-resolution clocksource is provided using the J-Core "RTC"
> registers, which give a 64-bit seconds count and 32-bit nanoseconds
> that wrap every second. The driver converts these to a full-range
> 32-bit nanoseconds count.
>=20
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  drivers/clocksource/Kconfig     |  10 ++
>  drivers/clocksource/Makefile    |   1 +
>  drivers/clocksource/jcore-pit.c | 231 ++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/cpuhotplug.h      |   1 +
>  4 files changed, 243 insertions(+)
>  create mode 100644 drivers/clocksource/jcore-pit.c
>=20
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 5677886..95dd78b 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -407,6 +407,16 @@ config SYS_SUPPORTS_SH_TMU
>  config SYS_SUPPORTS_EM_STI
>          bool
> =20
> +config CLKSRC_JCORE_PIT
> +	bool "J-Core PIT timer driver"
> +	depends on OF && (SUPERH || COMPILE_TEST)

Actually the idea is to have the SUPERH to select this timer, not create
a dependency on SUPERH from here.

We don't want to prompt in the configuration menu the drivers because it
would be impossible to anyone to know which timer comes with which
hardware, so we let the platform to select the timer it needs.

The exception is to enable in order to compile on non-native platform to
compile-test a bunch of drivers (eg. compile most of the clocksource /=20
clockevents drivers on a x86 big server).

That's why we should have:

config CLKSRC_JCORE_PIT
	bool "J-Core PIT timer driver" if COMPILE_TEST

So the jcore pit driver option appears only if compile test is enabled
otherwise it is a silent option and the user doesn't have to deal with
it. Having consistent dependency like the other drivers will help future
changes to consolidate the Kconfig.

[ ... ]             =20

> +#define REG_PITEN		0x00
> +#define REG_THROT		0x10
> +#define REG_COUNT		0x14
> +#define REG_BUSPD		0x18
> +#define REG_SECHI		0x20
> +#define REG_SECLO		0x24
> +#define REG_NSEC		0x28
> +
> +struct jcore_pit {
> +	struct clock_event_device	ced;
> +	__iomem void			*base;

It is not '__iomem void *' but 'void __iomem *'. This appears multiple
times in this code.

> +	unsigned long			periodic_delta;
> +	unsigned			cpu;

This field is pointless, 'cpu' is only used for a trace in the init
function which has already the cpu has parameter.

> +	u32				enable_val;
> +};
> +
> +static __iomem void		*jcore_pit_base;

static void __iomem *jcore_pit_base;

> +struct jcore_pit __percpu	*jcore_pit_percpu;

static.

[ ... ]

> +static int __init jcore_pit_init(struct device_node *node)
> +{

[ ...=A0]

> +	/*
> +	 * The J-Core PIT is not hard-wired to a particular IRQ, but
> +	 * integrated with the interrupt controller such that the IRQ it
> +	 * generates is programmable. The programming interface has a
> +	 * legacy field which was an interrupt priority for AIC1, but
> +	 * which is OR'd onto bits 2-5 of the generated IRQ number when
> +	 * used with J-Core AIC2, so set it to match these bits.
> +	 */
> +	hwirq =3D irq_get_irq_data(pit_irq)->hwirq;
> +	irqprio =3D (hwirq >> 2) & PIT_PRIO_MASK;
> +	enable_val =3D (1U << PIT_ENABLE_SHIFT)
> +		   | (hwirq << PIT_IRQ_SHIFT)
> +		   | (irqprio << PIT_PRIO_SHIFT);
> +

Why mention AIC1 if there is not test to check if AIC1 || AIC2 ?

Will be the same information available if the irqchip is AIC1 ?

I have to admin I find strange this driver has to invoke irq_get_irq_data(),
it is the only one and it sounds even strange it has to be stored per cpu b=
elow.

> +	for_each_present_cpu(cpu) {

		[ ... ]

> +		pit->enable_val =3D enable_val;
> +	}
> +
> +	cpuhp_setup_state(CPUHP_AP_JCORE_TIMER_STARTING,
> +			  "AP_JCORE_TIMER_STARTING",
> +			  jcore_pit_local_init, NULL);
> +
> +	return 0;
> +}
> +

Thanks !

  -- Daniel=20
