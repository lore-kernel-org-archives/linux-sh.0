From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 20 May 2016 14:01:56 +0000
Subject: Re: [PATCH v2 09/12] clocksource: add J-Core PIT/RTC driver
Message-Id: <20160520140156.GC6863@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <e8d3578861cfe2362e65f3f92d80ccae001c6b16.1463708766.git.dalias@libc.org>
In-Reply-To: <e8d3578861cfe2362e65f3f92d80ccae001c6b16.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Fri, May 20, 2016 at 02:53:04AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---

Hi Rich,

please add a nice changelog describing how works the timer.

Having openhardware is really awesome and that deserves a nice
documentation. I noticed the changelog of this patchset it very light and 
that's a pity regarding the potential of the J-core project.

I'm very much looking forward to see the J-core evolving and, IIUC, bringing 
kernel developer to review [and participate to] the CPU design is one of 
your objective and that's really cool. If you can beef up the changelog with 
detailed description and pointers to documentation to refer to, that will 
help a lot, especially when new drivers are added, to fill the gap between 
HW/SW.

> My previous post of the patch series accidentally omitted omitted
> Cc'ing of subsystem maintainers for the necessary clocksource,
> irqchip, and spi drivers. Please ack if this looks ok because I want
> to get it merged as part of the arch/sh pull request for 4.7.

In future send the patches sooner so they can be reviewed in a relaxed way 
and picked up in the right tree. I doubt that will make it for 4.7.

>  drivers/clocksource/Kconfig     |   9 ++
>  drivers/clocksource/Makefile    |   1 +
>  drivers/clocksource/jcore-pit.c | 176 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 drivers/clocksource/jcore-pit.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index c346be6..a29fd31 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -297,6 +297,15 @@ config SYS_SUPPORTS_SH_TMU
>  config SYS_SUPPORTS_EM_STI
>          bool
>  
> +config CLKSRC_JCORE_PIT
> +	bool "J-Core integrated PIT/RTC"

Replace by:

bool "J-Core integrated PIT/RTC" if COMPILE_TEST

Let the platform's Kconfig to select the timer. Beside, check the timer 
compiles correctly on other platform (eg. x86) for compilation test 
coverage.

Below a comment regarding RTC/PIT name.

> +	depends on GENERIC_CLOCKEVENTS
> +	depends on HAS_IOMEM
> +	help
> +	  This enables build of clocksource and clockevent driver for
> +	  the integrated PIT/RTC in the J-Core synthesizable, open source
> +	  SoC.
>
>
>  config SH_TIMER_CMT
>  	bool "Renesas CMT timer driver" if COMPILE_TEST
>  	depends on GENERIC_CLOCKEVENTS
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index dc2b899..d825fcf 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -5,6 +5,7 @@ obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
>  obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
>  obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
>  obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
> +obj-$(CONFIG_CLKSRC_JCORE_PIT)		+= jcore-pit.o
>  obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o
>  obj-$(CONFIG_SH_TIMER_MTU2)	+= sh_mtu2.o
>  obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
> diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
> new file mode 100644
> index 0000000..a4fde51
> --- /dev/null
> +++ b/drivers/clocksource/jcore-pit.c
> @@ -0,0 +1,176 @@
> +/*
> + * J-Core SoC PIT/RTC driver

Is it really RTC ? :)

Please fix the names to have something more accurate (eg. jcore_clockevent, 
jcore_clocksource) regarding how the other drivers are named.

> + *
> + * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License.  See the file "COPYING" in the main directory of this archive
> + * for more details.
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/param.h>
> +#include <linux/interrupt.h>
> +#include <linux/profile.h>
> +#include <linux/init.h>
> +#include <linux/irq.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <linux/cpu.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/irqchip.h>
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/rtc.h>

Are all these headers really needed ?

> +static unsigned char __iomem *pit_base;

s/unsigned char/void/

> +static int pit_irq;
> +static u32 percpu_offset;
> +static u32 enable_val;
> +static struct clock_event_device __percpu *pit_percpu;

Are the clockevents per cpu on the J2 ? Is there any documentation 
describing this hardware I can refer to ?

It would make sense to group all these values into a structure and use 
container_of to access them and precalculate the percpu_offset, so no need 
to compute the offset when entering the callbacks again and again.

struct jcore_percpu_clkevt {
	__iomem void *addr;
	struct clock_event_device clkevt;
}

> +#define REG_PITEN 0x00
> +#define REG_THROT 0x10
> +#define REG_COUNT 0x14
> +#define REG_BUSPD 0x18
> +#define REG_SECHI 0x20
> +#define REG_SECLO 0x24
> +#define REG_NSEC  0x28
> +
> +static cycle_t rtc_read(struct clocksource *cs)
> +{
> +	u32 sechi, seclo, nsec, sechi0, seclo0;
> +
> +	sechi = __raw_readl(pit_base + REG_SECHI);
> +	seclo = __raw_readl(pit_base + REG_SECLO);
> +	do {
> +		sechi0 = sechi;
> +		seclo0 = seclo;
> +		nsec  = __raw_readl(pit_base + REG_NSEC);
> +		sechi = __raw_readl(pit_base + REG_SECHI);
> +		seclo = __raw_readl(pit_base + REG_SECLO);
> +	} while (sechi0 != sechi || seclo0 != seclo);
> +
> +	return ((u64)sechi << 32 | seclo) * 1000000000 + nsec;

s/1000000000/NSEC_PER_SEC/

> +}

Do you really, really, want to use the 64bits ? There is no real benefit and 
it has a significant overhead. The impact on a j-core could be really not 
negligible IMHO.

> +
> +struct clocksource rtc_csd = {
> +	.name = "rtc",
> +	.rating = 400,
> +	.read = rtc_read,
> +	.mult = 1,
> +	.shift = 0,
> +	.mask = CLOCKSOURCE_MASK(64),
> +	.flags = CLOCK_SOURCE_IS_CONTINUOUS,
> +};
> +
> +static int pit_disable(struct clock_event_device *ced)
> +{
> +	unsigned cpu = smp_processor_id();
> +	writel(0, pit_base + percpu_offset*cpu + REG_PITEN);
> +	return 0;
> +}
> +
> +static int pit_set(unsigned long delta, struct clock_event_device *ced)
> +{
> +	unsigned cpu = smp_processor_id();
> +
> +	pit_disable(ced);

Move out the function pit_disabled().

> +	writel(delta, pit_base + percpu_offset*cpu + REG_THROT);
> +	writel(enable_val, pit_base + percpu_offset*cpu + REG_PITEN);

Write an enable function and move it out.

> +
> +	return 0;
> +}
> +
> +static int pit_set_periodic(struct clock_event_device *ced)
> +{
> +	unsigned cpu = smp_processor_id();
> +	unsigned long per = readl(pit_base + percpu_offset*cpu + REG_BUSPD);
> +
> +	return pit_set(DIV_ROUND_CLOSEST(1000000000, HZ*per), ced);
> +}
> +
> +static int pit_local_init(struct clock_event_device *ced)
> +{
> +	unsigned cpu = smp_processor_id();
> +	unsigned long per = readl(pit_base + percpu_offset*cpu + REG_BUSPD);
> +
> +	pr_info("Local PIT init on cpu %u\n", cpu);
> +
> +	ced->name = "pit";
> +	ced->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT
> +		| CLOCK_EVT_FEAT_PERCPU;
> +	ced->cpumask = cpumask_of(cpu);
> +	ced->rating = 400;
> +	ced->irq = pit_irq;
> +	ced->set_state_shutdown = pit_disable;
> +	ced->set_state_periodic = pit_set_periodic;
> +	ced->set_state_oneshot = pit_disable;
> +	ced->set_next_event = pit_set;

Don't mix helper functions and callbacks:

static void pit_set_periodic(struct clock_event_device *ced)
{
	__iomem void *addr = to_jcore_clkevt(ced)->addr;
	unsigned long period = readl(addr + REG_BUSPD);

	pit_disable(addr);
	pit_set(period, addr);
	pit_enabled(addr);
}

static void pit_set_next_event(unsigned long delta, struct 
clock_event_device *ced)
{
	__iomem void *addr = to_jcore_clkevt(ced)->addr;

	pit_disable(addr);
	pit_set(delta, addr);
	pit_enable(addr);
}

(jcore_set_next_event, jcore_set_periodic)

> +
> +	clockevents_config_and_register(ced, DIV_ROUND_CLOSEST(1000000000, per),
> +	                                1, 0xffffffff);
> +
> +	pit_set_periodic(ced);

It is up to the time framework to set this.

I don't see enable_percpu_irq / disable_percpu_irq in this driver.

> +	return 0;
> +}
> +
> +static int pit_cpu_notify(struct notifier_block *self, unsigned long action, void *hcpu)
> +{
> +	switch (action & ~CPU_TASKS_FROZEN) {
> +	case CPU_STARTING:
> +		pit_local_init(this_cpu_ptr(pit_percpu));
> +		break;
> +	}

DYING is missing.

> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block pit_cpu_nb = {
> +	.notifier_call = pit_cpu_notify,
> +};
> +
> +static irqreturn_t timer_interrupt(int irq, void *dev_id)
> +{
> +	struct clock_event_device *ced = this_cpu_ptr(dev_id);

this_cpu_ptr shouldn't be used here, see the comment related to percpu in 
the init function.

> +	if (clockevent_state_oneshot(ced)) pit_disable(ced);

CR missing before pit_disable().

> +	ced->event_handler(ced);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void __init pit_init(struct device_node *node)
> +{
> +	unsigned long hwirq;
> +	int err;

Test return code for every function below.

> +
> +	pit_base = of_iomap(node, 0);
> +	pit_irq = irq_of_parse_and_map(node, 0);
> +	of_property_read_u32(node, "cpu-offset", &percpu_offset);
> +
> +	pr_info("Initializing J-Core PIT at %p IRQ %d\n", pit_base, pit_irq);
> +
> +	clocksource_register_hz(&rtc_csd, 1000000000);

I suggest the rate to be passed through the DT.

> +	pit_percpu = alloc_percpu(struct clock_event_device);
> +	register_cpu_notifier(&pit_cpu_nb);
> +
> +	err = request_irq(pit_irq, timer_interrupt,
> +		IRQF_TIMER | IRQF_PERCPU, "pit", pit_percpu);

So, we have per CPU private IRQ with the same number, right?

You should use the 'percpu' API.

 - request_percpu_irq
 - enable_percpu_irq
 - disable_percpu_irq

The interrupt callback will have the right percpu dev_id parameter pointing 
to the right percpu structure. So you should not have to play with 
this_cpu_ptr anywhere.

> +	if (err) pr_err("pit irq request failed: %d\n", err);

CR before pr_err.

> +	hwirq = irq_get_irq_data(pit_irq)->hwirq;
> +	enable_val = (1<<26) | ((hwirq&0x3c)<<18) | (hwirq<<12);

Can you explain? (and replace litterals by macros).

> +	pit_local_init(this_cpu_ptr(pit_percpu));
> +}

I am wondering if the j2 is subject to change. It is now designable through 
FPGA and I imagine the design can go back and forth, no? If yes (and that's 
good), wouldn't make sense to make this driver (and others) highly 
configurable via the DT, much more than what there is now in order to 
prevent errata and kernel changes?

Thanks
  -- Daniel

