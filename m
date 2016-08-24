From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 24 Aug 2016 16:42:05 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <57BDCE5D.2050609@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
In-Reply-To: <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rich Felker <dalias@libc.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <Marc.Zyngier@arm.com>

On 08/04/2016 06:30 AM, Rich Felker wrote:
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
> necessary per-cpu clock_event_device instances. The code has been
> tested and works on SMP, but will not be usable without additional
> J-Core SMP-support patches and appropriate hardware capable of running
> SMP.
>=20
> A nanosecond-resolution clocksource is provided using the J-Core "RTC"
> registers, which give a 64-bit seconds count and 32-bit nanoseconds.
> The driver converts these to a 64-bit nanoseconds count.
>=20
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  drivers/clocksource/Kconfig     |   9 ++
>  drivers/clocksource/Makefile    |   1 +
>  drivers/clocksource/jcore-pit.c | 242 ++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/cpuhotplug.h      |   1 +
>  4 files changed, 253 insertions(+)
>  create mode 100644 drivers/clocksource/jcore-pit.c
>=20
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 5677886..3210ca5 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -407,6 +407,15 @@ config SYS_SUPPORTS_SH_TMU
>  config SYS_SUPPORTS_EM_STI
>          bool
> =20
> +config CLKSRC_JCORE_PIT
> +	bool "J-Core PIT timer driver"
> +	depends on OF && (SUPERH || COMPILE_TEST)

Even if this is correct, for the sake of consistency, it is preferable
to change it to:

	bool "J-Core PIT timer driver" if COMPILE_TEST
	depends on SUPERH
	select CLKSRC_OF

> +	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
> +	help
> +	  This enables build of clocksource and clockevent driver for
> +	  the integrated PIT in the J-Core synthesizable, open source SoC.
> +
>  config SH_TIMER_CMT
>  	bool "Renesas CMT timer driver" if COMPILE_TEST
>  	depends on GENERIC_CLOCKEVENTS
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index fd9d6df..cf87f40 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+=3D tcb_clksrc.o
>  obj-$(CONFIG_X86_PM_TIMER)	+=3D acpi_pm.o
>  obj-$(CONFIG_SCx200HR_TIMER)	+=3D scx200_hrt.o
>  obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+=3D cs5535-clockevt.o
> +obj-$(CONFIG_CLKSRC_JCORE_PIT)		+=3D jcore-pit.o
>  obj-$(CONFIG_SH_TIMER_CMT)	+=3D sh_cmt.o
>  obj-$(CONFIG_SH_TIMER_MTU2)	+=3D sh_mtu2.o
>  obj-$(CONFIG_SH_TIMER_TMU)	+=3D sh_tmu.o
> diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-=
pit.c
> new file mode 100644
> index 0000000..23dee50
> --- /dev/null
> +++ b/drivers/clocksource/jcore-pit.c
> @@ -0,0 +1,242 @@
> +/*
> + * J-Core SoC PIT/clocksource driver
> + *
> + * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
> + *
> + * This file is subject to the terms and conditions of the GNU General P=
ublic
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/sched_clock.h>
> +#include <linux/cpu.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +
> +#define PIT_IRQ_SHIFT		12
> +#define PIT_PRIO_SHIFT		20
> +#define PIT_ENABLE_SHIFT	26
> +#define PIT_IRQ_MASK		0x3f
> +#define PIT_PRIO_MASK		0xf
> +
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
> +	unsigned long			periodic_delta;
> +	unsigned			cpu;
> +	u32				enable_val;
> +};
> +
> +static __iomem void		*jcore_pit_base;
> +static struct clocksource	jcore_cs;
> +struct jcore_pit __percpu	*jcore_pit_percpu;
> +
> +static notrace u64 jcore_sched_clock_read(void)
> +{
> +	u32 seclo, nsec, seclo0;
> +	__iomem void *base =3D jcore_pit_base;
> +
> +	seclo =3D __raw_readl(base + REG_SECLO);
> +	do {
> +		seclo0 =3D seclo;
> +		nsec  =3D __raw_readl(base + REG_NSEC);
> +		seclo =3D __raw_readl(base + REG_SECLO);
> +	} while (seclo0 !=3D seclo);
> +
> +	return seclo * NSEC_PER_SEC + nsec;
> +}
> +
> +static cycle_t jcore_clocksource_read(struct clocksource *cs)
> +{
> +	return jcore_sched_clock_read();
> +}
> +
> +static int jcore_pit_disable(struct jcore_pit *pit)
> +{
> +	__raw_writel(0, pit->base + REG_PITEN);
> +	return 0;
> +}
> +
> +static int jcore_pit_set(unsigned long delta, struct jcore_pit *pit)
> +{
> +	jcore_pit_disable(pit);
> +	__raw_writel(delta, pit->base + REG_THROT);
> +	__raw_writel(pit->enable_val, pit->base + REG_PITEN);
> +	return 0;

Why do you need to use __raw_writel ?

s/__raw_writel/writel/

> +}
> +
> +static int jcore_pit_set_state_shutdown(struct clock_event_device *ced)
> +{
> +	struct jcore_pit *pit =3D container_of(ced, struct jcore_pit, ced);
> +
> +	return jcore_pit_disable(pit);
> +}
> +
> +static int jcore_pit_set_state_oneshot(struct clock_event_device *ced)
> +{
> +	struct jcore_pit *pit =3D container_of(ced, struct jcore_pit, ced);
> +
> +	return jcore_pit_disable(pit);
> +}
> +
> +static int jcore_pit_set_state_periodic(struct clock_event_device *ced)
> +{
> +	struct jcore_pit *pit =3D container_of(ced, struct jcore_pit, ced);
> +
> +	return jcore_pit_set(pit->periodic_delta, pit);
> +}
> +
> +static int jcore_pit_set_next_event(unsigned long delta,
> +				    struct clock_event_device *ced)
> +{
> +	struct jcore_pit *pit =3D container_of(ced, struct jcore_pit, ced);
> +
> +	return jcore_pit_set(delta, pit);
> +}
> +
> +static int jcore_pit_local_init(unsigned cpu)
> +{
> +	struct jcore_pit *pit =3D this_cpu_ptr(jcore_pit_percpu);
> +	unsigned buspd, freq;
> +
> +	pr_info("Local J-Core PIT init on cpu %u\n", pit->cpu);
> +
> +	buspd =3D __raw_readl(pit->base + REG_BUSPD);

s/__raw_readl/readl/ ?

> +	freq =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, buspd);
> +	pit->periodic_delta =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, HZ*buspd);

--->					HZ * buspd

> +
> +	clockevents_config_and_register(&pit->ced, freq, 1, ULONG_MAX);
> +
> +	return 0;
> +}
> +
> +static int jcore_pit_local_shutdown(unsigned cpu)
> +{
> +	return 0;
> +}

This function is useless I think. AFAIU, cpuhp_setup_state can have a
NULL function for the cpu teardown.

> +
> +static irqreturn_t jcore_timer_interrupt(int irq, void *dev_id)
> +{
> +	struct jcore_pit *pit =3D this_cpu_ptr(dev_id);
> +
> +	if (clockevent_state_oneshot(&pit->ced))
> +		jcore_pit_disable(pit);
> +
> +	pit->ced.event_handler(&pit->ced);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __init jcore_pit_init(struct device_node *node)
> +{
> +	int err;
> +	unsigned pit_irq, cpu;
> +	unsigned long hwirq;
> +	u32 irqprio, enable_val;
> +
> +	jcore_pit_base =3D of_iomap(node, 0);
> +	if (!jcore_pit_base) {
> +		pr_err("Error: Cannot map base address for J-Core PIT\n");
> +		return -ENXIO;
> +	}
> +
> +	pit_irq =3D irq_of_parse_and_map(node, 0);
> +	if (!pit_irq) {
> +		pr_err("Error: J-Core PIT has no IRQ\n");
> +		return -ENXIO;
> +	}
> +
> +	pr_info("Initializing J-Core PIT at %p IRQ %d\n",
> +		jcore_pit_base, pit_irq);
> +
> +	jcore_cs.name =3D "jcore_pit_cs";
> +	jcore_cs.rating =3D 400;
> +	jcore_cs.read =3D jcore_clocksource_read;
> +	jcore_cs.mult =3D 1;
> +	jcore_cs.shift =3D 0;
> +	jcore_cs.mask =3D CLOCKSOURCE_MASK(32);
> +	jcore_cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
> +
> +	err =3D clocksource_register_hz(&jcore_cs, NSEC_PER_SEC);
> +	if (err) {
> +		pr_err("Error registering clocksource device: %d\n", err);
> +		return err;
> +	}

May be you can consider by replacing the above by:

	clocksource_mmio_init(jcore_pit_base, "jcore_pit_cs",
				NSEC_PER_SEC, 32,
				jcore_clocksource_read);

> +
> +	sched_clock_register(jcore_sched_clock_read, 32, NSEC_PER_SEC);
> +
> +	jcore_pit_percpu =3D alloc_percpu(struct jcore_pit);
> +	if (!jcore_pit_percpu) {
> +		pr_err("Failed to allocate memory for clock event device\n");
> +		return -ENOMEM;
> +	}
> +
> +	err =3D request_irq(pit_irq, jcore_timer_interrupt,
> +			  IRQF_TIMER | IRQF_PERCPU,
> +			  "jcore_pit", jcore_pit_percpu);
> +	if (err) {
> +		pr_err("pit irq request failed: %d\n", err);
> +		return err;
> +	}

That is my major concern. Regarding the description of this timer, it
appears there is one timer per cpu but we use request_irq instead of
request_percpu_irq.

IIUC, there is a problem with the interrupt controller where the per irq
line are not working correctly. Is that correct ?

Regarding Marc Zyngier comments about the irq controller driver being
almost empty, I'm wondering if something in the irq controller driver
which shouldn't be added before submitting this timer driver with SMP
support (eg. irq domain ?).

> +	/*
> +	 * The J-Core PIT is not hard-wired to a particular IRQ, but
> +	 * integrated with the interrupt controller such that the IRQ it
> +	 * generates is programmable. The programming interface has a
> +	 * legacy field which was an interrupt priority for AIC1, but
> +	 * which is OR'd onto bits 2-5 of the generated IRQ number when
> +	 * used with J-Core AIC2, so set it to match these bits.
> +	 */
> +	hwirq =3D irq_get_irq_data(pit_irq)->hwirq;

	irq_hw_number_t hwirq;
	hwirq =3D irqd_to_hwirq(irq_get_irq_data(pit_irq));

> +	irqprio =3D (hwirq >> 2) & PIT_PRIO_MASK;
> +	enable_val =3D (1U << PIT_ENABLE_SHIFT)
> +		   | (hwirq << PIT_IRQ_SHIFT)
> +		   | (irqprio << PIT_PRIO_SHIFT);


I'm missing the connection between the description above and the enable
value computed here. Can you elaborate ?

> +
> +	for_each_present_cpu(cpu) {
> +		struct jcore_pit *pit =3D per_cpu_ptr(jcore_pit_percpu, cpu);
> +
> +		pit->base =3D of_iomap(node, cpu);
> +		if (!pit->base) {
> +			pr_err("Unable to map PIT for cpu %u\n", cpu);
> +			continue;
> +		}
> +
> +		pit->ced.name =3D "jcore_pit";
> +		pit->ced.features =3D CLOCK_EVT_FEAT_PERIODIC
> +				  | CLOCK_EVT_FEAT_ONESHOT
> +				  | CLOCK_EVT_FEAT_PERCPU;
> +		pit->ced.cpumask =3D cpumask_of(cpu);
> +		pit->ced.rating =3D 400;
> +		pit->ced.irq =3D pit_irq;
> +		pit->ced.set_state_shutdown =3D jcore_pit_set_state_shutdown;
> +		pit->ced.set_state_periodic =3D jcore_pit_set_state_periodic;
> +		pit->ced.set_state_oneshot =3D jcore_pit_set_state_oneshot;
> +		pit->ced.set_next_event =3D jcore_pit_set_next_event;
> +
> +		pit->cpu =3D cpu;
> +		pit->enable_val =3D enable_val;
> +	}
> +
> +	cpuhp_setup_state(CPUHP_AP_JCORE_TIMER_STARTING,
> +			  "AP_JCORE_TIMER_STARTING",
> +			  jcore_pit_local_init, jcore_pit_local_shutdown);
> +
> +	return 0;
> +}
> +
> +CLOCKSOURCE_OF_DECLARE(jcore_pit, "jcore,pit", jcore_pit_init);
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 242bf53..e95ed7d 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -50,6 +50,7 @@ enum cpuhp_state {
>  	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
>  	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
>  	CPUHP_AP_DUMMY_TIMER_STARTING,
> +	CPUHP_AP_JCORE_TIMER_STARTING,
>  	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
>  	CPUHP_AP_ARM_TWD_STARTING,
>  	CPUHP_AP_METAG_TIMER_STARTING,
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

