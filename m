From: Rich Felker <dalias@libc.org>
Date: Sun, 09 Oct 2016 05:34:22 +0000
Subject: [PATCH v8 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <588ea0a3175fcf5d409ca32249f24760f2f6f839.1475990489.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1475990489.git.dalias@libc.org>
In-Reply-To: <cover.1475990489.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

At the hardware level, the J-Core PIT is integrated with the interrupt
controller, but it is represented as its own device and has an
independent programming interface. It provides a 12-bit countdown
timer, which is not presently used, and a periodic timer. The interval
length for the latter is programmable via a 32-bit throttle register
whose units are determined by a bus-period register. The periodic
timer is used to implement both periodic and oneshot clock event
modes; in oneshot mode the interrupt handler simply disables the timer
as soon as it fires.

Despite its device tree node representing an interrupt for the PIT,
the actual irq generated is programmable, not hard-wired. The driver
is responsible for programming the PIT to generate the hardware irq
number that the DT assigns to it.

On SMP configurations, J-Core provides cpu-local instances of the PIT;
no broadcast timer is needed. This driver supports the creation of the
necessary per-cpu clock_event_device instances.

A nanosecond-resolution clocksource is provided using the J-Core "RTC"
registers, which give a 64-bit seconds count and 32-bit nanoseconds
that wrap every second. The driver converts these to a full-range
32-bit nanoseconds count.

Signed-off-by: Rich Felker <dalias@libc.org>
---
 drivers/clocksource/Kconfig     |  10 ++
 drivers/clocksource/Makefile    |   1 +
 drivers/clocksource/jcore-pit.c | 231 ++++++++++++++++++++++++++++++++++++++++
 include/linux/cpuhotplug.h      |   1 +
 4 files changed, 243 insertions(+)
 create mode 100644 drivers/clocksource/jcore-pit.c

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 5677886..95dd78b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -407,6 +407,16 @@ config SYS_SUPPORTS_SH_TMU
 config SYS_SUPPORTS_EM_STI
         bool
 
+config CLKSRC_JCORE_PIT
+	bool "J-Core PIT timer driver"
+	depends on OF && (SUPERH || COMPILE_TEST)
+	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	help
+	  This enables build of clocksource and clockevent driver for
+	  the integrated PIT in the J-Core synthesizable, open source SoC.
+
 config SH_TIMER_CMT
 	bool "Renesas CMT timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index fd9d6df..cf87f40 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
+obj-$(CONFIG_CLKSRC_JCORE_PIT)		+= jcore-pit.o
 obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o
 obj-$(CONFIG_SH_TIMER_MTU2)	+= sh_mtu2.o
 obj-$(CONFIG_SH_TIMER_TMU)	+= sh_tmu.o
diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
new file mode 100644
index 0000000..4f3ef69
--- /dev/null
+++ b/drivers/clocksource/jcore-pit.c
@@ -0,0 +1,231 @@
+/*
+ * J-Core SoC PIT/clocksource driver
+ *
+ * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/sched_clock.h>
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#define PIT_IRQ_SHIFT		12
+#define PIT_PRIO_SHIFT		20
+#define PIT_ENABLE_SHIFT	26
+#define PIT_IRQ_MASK		0x3f
+#define PIT_PRIO_MASK		0xf
+
+#define REG_PITEN		0x00
+#define REG_THROT		0x10
+#define REG_COUNT		0x14
+#define REG_BUSPD		0x18
+#define REG_SECHI		0x20
+#define REG_SECLO		0x24
+#define REG_NSEC		0x28
+
+struct jcore_pit {
+	struct clock_event_device	ced;
+	__iomem void			*base;
+	unsigned long			periodic_delta;
+	unsigned			cpu;
+	u32				enable_val;
+};
+
+static __iomem void		*jcore_pit_base;
+struct jcore_pit __percpu	*jcore_pit_percpu;
+
+static notrace u64 jcore_sched_clock_read(void)
+{
+	u32 seclo, nsec, seclo0;
+	__iomem void *base = jcore_pit_base;
+
+	seclo = readl(base + REG_SECLO);
+	do {
+		seclo0 = seclo;
+		nsec  = readl(base + REG_NSEC);
+		seclo = readl(base + REG_SECLO);
+	} while (seclo0 != seclo);
+
+	return seclo * NSEC_PER_SEC + nsec;
+}
+
+static cycle_t jcore_clocksource_read(struct clocksource *cs)
+{
+	return jcore_sched_clock_read();
+}
+
+static int jcore_pit_disable(struct jcore_pit *pit)
+{
+	writel(0, pit->base + REG_PITEN);
+	return 0;
+}
+
+static int jcore_pit_set(unsigned long delta, struct jcore_pit *pit)
+{
+	jcore_pit_disable(pit);
+	writel(delta, pit->base + REG_THROT);
+	writel(pit->enable_val, pit->base + REG_PITEN);
+	return 0;
+}
+
+static int jcore_pit_set_state_shutdown(struct clock_event_device *ced)
+{
+	struct jcore_pit *pit = container_of(ced, struct jcore_pit, ced);
+
+	return jcore_pit_disable(pit);
+}
+
+static int jcore_pit_set_state_oneshot(struct clock_event_device *ced)
+{
+	struct jcore_pit *pit = container_of(ced, struct jcore_pit, ced);
+
+	return jcore_pit_disable(pit);
+}
+
+static int jcore_pit_set_state_periodic(struct clock_event_device *ced)
+{
+	struct jcore_pit *pit = container_of(ced, struct jcore_pit, ced);
+
+	return jcore_pit_set(pit->periodic_delta, pit);
+}
+
+static int jcore_pit_set_next_event(unsigned long delta,
+				    struct clock_event_device *ced)
+{
+	struct jcore_pit *pit = container_of(ced, struct jcore_pit, ced);
+
+	return jcore_pit_set(delta, pit);
+}
+
+static int jcore_pit_local_init(unsigned cpu)
+{
+	struct jcore_pit *pit = this_cpu_ptr(jcore_pit_percpu);
+	unsigned buspd, freq;
+
+	pr_info("Local J-Core PIT init on cpu %u\n", pit->cpu);
+
+	buspd = readl(pit->base + REG_BUSPD);
+	freq = DIV_ROUND_CLOSEST(NSEC_PER_SEC, buspd);
+	pit->periodic_delta = DIV_ROUND_CLOSEST(NSEC_PER_SEC, HZ * buspd);
+
+	clockevents_config_and_register(&pit->ced, freq, 1, ULONG_MAX);
+
+	return 0;
+}
+
+static irqreturn_t jcore_timer_interrupt(int irq, void *dev_id)
+{
+	struct jcore_pit *pit = this_cpu_ptr(dev_id);
+
+	if (clockevent_state_oneshot(&pit->ced))
+		jcore_pit_disable(pit);
+
+	pit->ced.event_handler(&pit->ced);
+
+	return IRQ_HANDLED;
+}
+
+static int __init jcore_pit_init(struct device_node *node)
+{
+	int err;
+	unsigned pit_irq, cpu;
+	unsigned long hwirq;
+	u32 irqprio, enable_val;
+
+	jcore_pit_base = of_iomap(node, 0);
+	if (!jcore_pit_base) {
+		pr_err("Error: Cannot map base address for J-Core PIT\n");
+		return -ENXIO;
+	}
+
+	pit_irq = irq_of_parse_and_map(node, 0);
+	if (!pit_irq) {
+		pr_err("Error: J-Core PIT has no IRQ\n");
+		return -ENXIO;
+	}
+
+	pr_info("Initializing J-Core PIT at %p IRQ %d\n",
+		jcore_pit_base, pit_irq);
+
+	err = clocksource_mmio_init(jcore_pit_base, "jcore_pit_cs",
+				    NSEC_PER_SEC, 400, 32,
+				    jcore_clocksource_read);
+	if (err) {
+		pr_err("Error registering clocksource device: %d\n", err);
+		return err;
+	}
+
+	sched_clock_register(jcore_sched_clock_read, 32, NSEC_PER_SEC);
+
+	jcore_pit_percpu = alloc_percpu(struct jcore_pit);
+	if (!jcore_pit_percpu) {
+		pr_err("Failed to allocate memory for clock event device\n");
+		return -ENOMEM;
+	}
+
+	err = request_irq(pit_irq, jcore_timer_interrupt,
+			  IRQF_TIMER | IRQF_PERCPU,
+			  "jcore_pit", jcore_pit_percpu);
+	if (err) {
+		pr_err("pit irq request failed: %d\n", err);
+		free_percpu(jcore_pit_percpu);
+		return err;
+	}
+
+	/*
+	 * The J-Core PIT is not hard-wired to a particular IRQ, but
+	 * integrated with the interrupt controller such that the IRQ it
+	 * generates is programmable. The programming interface has a
+	 * legacy field which was an interrupt priority for AIC1, but
+	 * which is OR'd onto bits 2-5 of the generated IRQ number when
+	 * used with J-Core AIC2, so set it to match these bits.
+	 */
+	hwirq = irq_get_irq_data(pit_irq)->hwirq;
+	irqprio = (hwirq >> 2) & PIT_PRIO_MASK;
+	enable_val = (1U << PIT_ENABLE_SHIFT)
+		   | (hwirq << PIT_IRQ_SHIFT)
+		   | (irqprio << PIT_PRIO_SHIFT);
+
+	for_each_present_cpu(cpu) {
+		struct jcore_pit *pit = per_cpu_ptr(jcore_pit_percpu, cpu);
+
+		pit->base = of_iomap(node, cpu);
+		if (!pit->base) {
+			pr_err("Unable to map PIT for cpu %u\n", cpu);
+			continue;
+		}
+
+		pit->ced.name = "jcore_pit";
+		pit->ced.features = CLOCK_EVT_FEAT_PERIODIC
+				  | CLOCK_EVT_FEAT_ONESHOT
+				  | CLOCK_EVT_FEAT_PERCPU;
+		pit->ced.cpumask = cpumask_of(cpu);
+		pit->ced.rating = 400;
+		pit->ced.irq = pit_irq;
+		pit->ced.set_state_shutdown = jcore_pit_set_state_shutdown;
+		pit->ced.set_state_periodic = jcore_pit_set_state_periodic;
+		pit->ced.set_state_oneshot = jcore_pit_set_state_oneshot;
+		pit->ced.set_next_event = jcore_pit_set_next_event;
+
+		pit->cpu = cpu;
+		pit->enable_val = enable_val;
+	}
+
+	cpuhp_setup_state(CPUHP_AP_JCORE_TIMER_STARTING,
+			  "AP_JCORE_TIMER_STARTING",
+			  jcore_pit_local_init, NULL);
+
+	return 0;
+}
+
+CLOCKSOURCE_OF_DECLARE(jcore_pit, "jcore,pit", jcore_pit_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 34bd805..e2e6c8c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -52,6 +52,7 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_ARCH_TIMER_STARTING,
 	CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
 	CPUHP_AP_DUMMY_TIMER_STARTING,
+	CPUHP_AP_JCORE_TIMER_STARTING,
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_METAG_TIMER_STARTING,
-- 
2.10.0

