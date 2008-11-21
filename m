From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Nov 2008 13:15:51 +0000
Subject: [PATCH 1/8] sh: timer rewrite, base code
Message-Id: <20081121131551.4114.27901.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

New SuperH timer base code implementation supporting:
- hardware configuration kept with other processor parameters
- reentrant timer drivers using sysdev
- compile time CONFIG_SH_TIMER switch
- using CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKEVENTS
- sharing of drivers with other architectures

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                |   12 +++++-
 arch/sh/kernel/time_32.c       |   34 +++++++++++--------
 drivers/clocksource/Makefile   |    1 
 drivers/clocksource/sh_timer.c |   69 ++++++++++++++++++++++++++++++++++++++++
 include/linux/sh_timer.h       |   44 +++++++++++++++++++++++++
 5 files changed, 143 insertions(+), 17 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-11-21 19:10:50.000000000 +0900
@@ -384,10 +384,15 @@ source "arch/sh/boards/Kconfig"
 
 menu "Timer and clock configuration"
 
+config SH_TIMER
+	def_bool n
+	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
+
 config SH_TMU
 	def_bool y
 	prompt "TMU timer support"
-	depends on CPU_SH3 || CPU_SH4
+	depends on !SH_TIMER && (CPU_SH3 || CPU_SH4)
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	help
@@ -396,18 +401,19 @@ config SH_TMU
 config SH_CMT
 	def_bool y
 	prompt "CMT timer support"
-	depends on CPU_SH2 && !CPU_SUBTYPE_MXG
+	depends on !SH_TIMER && CPU_SH2 && !CPU_SUBTYPE_MXG
 	help
 	  This enables the use of the CMT as the system timer.
 
 config SH_MTU2
 	def_bool n
 	prompt "MTU2 timer support"
-	depends on CPU_SH2A
+	depends on !SH_TIMER && CPU_SH2A
 	help
 	  This enables the use of the MTU2 as the system timer.
 
 config SH_TIMER_IRQ
+	depends on !SH_TIMER
 	int
 	default "28" if CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785 || \
 			CPU_SUBTYPE_SH7763
--- 0001/arch/sh/kernel/time_32.c
+++ work/arch/sh/kernel/time_32.c	2008-11-21 19:10:50.000000000 +0900
@@ -41,14 +41,6 @@ static int null_rtc_set_time(const time_
 	return 0;
 }
 
-/*
- * Null high precision timer functions for systems lacking one.
- */
-static cycle_t null_hpt_read(void)
-{
-	return 0;
-}
-
 void (*rtc_sh_get_time)(struct timespec *) = null_rtc_get_time;
 int (*rtc_sh_set_time)(const time_t) = null_rtc_set_time;
 
@@ -185,7 +177,7 @@ int timer_resume(struct sys_device *dev)
 #define timer_suspend NULL
 #define timer_resume NULL
 #endif
-
+#ifndef CONFIG_SH_TIMER
 static struct sysdev_class timer_sysclass = {
 	.name	 = "timer",
 	.suspend = timer_suspend,
@@ -202,17 +194,25 @@ static int __init timer_init_sysfs(void)
 	return sysdev_register(&sys_timer->dev);
 }
 device_initcall(timer_init_sysfs);
-
+#endif
 void (*board_time_init)(void);
 
 /*
  * Shamelessly based on the MIPS and Sparc64 work.
  */
-static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
 unsigned long sh_hpt_frequency = 0;
-
+#ifndef CONFIG_SH_TIMER
+static unsigned long timer_ticks_per_nsec_quotient __read_mostly;
 #define NSEC_PER_CYC_SHIFT	10
 
+/*
+ * Null high precision timer functions for systems lacking one.
+ */
+static cycle_t null_hpt_read(void)
+{
+	return 0;
+}
+
 static struct clocksource clocksource_sh = {
 	.name		= "SuperH",
 	.rating		= 200,
@@ -221,9 +221,12 @@ static struct clocksource clocksource_sh
 	.shift		= 16,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
+#endif
+
 
 static void __init init_sh_clocksource(void)
 {
+#ifndef CONFIG_SH_TIMER
 	if (!sh_hpt_frequency || clocksource_sh.read = null_hpt_read)
 		return;
 
@@ -234,15 +237,18 @@ static void __init init_sh_clocksource(v
 		clocksource_hz2mult(sh_hpt_frequency, NSEC_PER_CYC_SHIFT);
 
 	clocksource_register(&clocksource_sh);
+#endif
 }
 
 #ifdef CONFIG_GENERIC_TIME
+#ifndef CONFIG_SH_TIMER
 unsigned long long sched_clock(void)
 {
 	unsigned long long ticks = clocksource_sh.read();
 	return (ticks * timer_ticks_per_nsec_quotient) >> NSEC_PER_CYC_SHIFT;
 }
 #endif
+#endif
 
 void __init time_init(void)
 {
@@ -258,7 +264,7 @@ void __init time_init(void)
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 	local_timer_setup(smp_processor_id());
 #endif
-
+#ifndef CONFIG_SH_TIMER
 	/*
 	 * Find the timer to use as the system timer, it will be
 	 * initialized for us.
@@ -269,6 +275,7 @@ void __init time_init(void)
 
 	if (sys_timer->ops->read)
 		clocksource_sh.read = sys_timer->ops->read;
+#endif
 
 	init_sh_clocksource();
 
@@ -276,7 +283,6 @@ void __init time_init(void)
 		printk("Using %lu.%03lu MHz high precision timer.\n",
 		       ((sh_hpt_frequency + 500) / 1000) / 1000,
 		       ((sh_hpt_frequency + 500) / 1000) % 1000);
-
 #if defined(CONFIG_SH_KGDB)
 	/*
 	 * Set up kgdb as requested. We do it here because the serial
--- 0001/drivers/clocksource/Makefile
+++ work/drivers/clocksource/Makefile	2008-11-21 19:10:50.000000000 +0900
@@ -2,3 +2,4 @@ obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_cl
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclone.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
+obj-$(CONFIG_SH_TIMER)		+= sh_timer.o
--- /dev/null
+++ work/drivers/clocksource/sh_timer.c	2008-11-21 19:10:50.000000000 +0900
@@ -0,0 +1,69 @@
+/*
+ * SuperH Timer Support
+ *
+ * Copyright (C) 2008 Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/init.h>
+#include <linux/sysdev.h>
+#include <linux/sh_timer.h>
+
+struct sysdev_class sh_timer_class = {
+	.name = "sh_timer",
+};
+
+struct sysdev_driver *sh_timer_drivers[] = {
+};
+
+int sh_timer_register(struct sh_timer_config *timers, int nr_timers)
+{
+	struct sh_timer_config *cfg;
+	int ret;
+	int k;
+
+	sysdev_class_register(&sh_timer_class);
+
+	for (k = 0; k < nr_timers; k++) {
+		cfg = &timers[k];
+
+		if (cfg->type = SH_TIMER_TYPE_INVALID)
+			pr_warning("sh_timer: invalid timer device\n");
+
+		cfg->sysdev.id = k;
+		cfg->sysdev.cls = &sh_timer_class;
+		ret = sysdev_register(&cfg->sysdev);
+		if (ret)
+			pr_warning("sh_timer: unable to register device\n");
+	}
+
+	return 0;
+}
+
+static int __init sh_timer_init_drivers(void)
+{
+	int ret;
+	int k;
+
+	for (k = 0; k < ARRAY_SIZE(sh_timer_drivers); k++) {
+		ret = sysdev_driver_register(&sh_timer_class,
+					     sh_timer_drivers[k]);
+		if (ret)
+			pr_warning("sh_timer: unable to register driver\n");
+	}
+
+	return 0;
+}
+subsys_initcall(sh_timer_init_drivers);
--- /dev/null
+++ work/include/linux/sh_timer.h	2008-11-21 19:10:57.000000000 +0900
@@ -0,0 +1,44 @@
+#ifndef __SH_TIMER_H__
+#define __SH_TIMER_H__
+/*
+ * SuperH Timer Support
+ *
+ * Timer devices are defined by the processor-specific code using
+ * an array of struct sh_timer_config. This array is registered
+ * using sh_timer_register().
+ *
+ * Timer drivers are sysdev drivers that are kept in a list in the
+ * sh_timer code. Devices and drivers belong to the same class,
+ * and drivers should match against enum sh_timer_type.
+ *
+ * Driver specific flags can be passed in the flags variable.
+ */
+
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/sysdev.h>
+
+enum sh_timer_type { SH_TIMER_TYPE_INVALID = 0 };
+
+struct sh_timer_config {
+	enum sh_timer_type type;
+	unsigned long flags;
+
+	char *name;
+	unsigned long base;
+	unsigned long channel_offset;
+	int timer_bit;
+	char *clk;
+	int irq;
+
+	struct sys_device sysdev;
+};
+
+int sh_timer_register(struct sh_timer_config *timers, int nr);
+
+static inline struct sh_timer_config *to_sh_timer(struct sys_device *sysdev)
+{
+	return container_of(sysdev, struct sh_timer_config, sysdev);
+}
+
+#endif /* __SH_TIMER_H__ */
