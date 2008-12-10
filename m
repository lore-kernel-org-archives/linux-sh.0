From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Dec 2008 15:12:59 +0000
Subject: [PATCH 03/05] sh: timer base code, early timer support
Message-Id: <20081210151259.32515.984.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

SuperH timer rewrite V4 supporting:
- platform timer drivers
- hardware configuration kept as platform data
- early timer support using sh_timer_register()/sh_timer_early_probe()
- compile time CONFIG_SH_TIMER switch
- using CONFIG_GENERIC_TIME and CONFIG_GENERIC_CLOCKEVENTS
- sharing of drivers with other architectures
- built without the need of, but on top of the arch_gettimeoffset patches

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                |   13 +++++--
 arch/sh/kernel/time_32.c       |   27 +++++++++------
 drivers/clocksource/Makefile   |    1 
 drivers/clocksource/sh_timer.c |   72 ++++++++++++++++++++++++++++++++++++++++
 include/linux/sh_timer.h       |   26 ++++++++++++++
 5 files changed, 125 insertions(+), 14 deletions(-)

--- 0004/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-12-10 23:06:16.000000000 +0900
@@ -395,33 +395,38 @@ source "arch/sh/boards/Kconfig"
 
 menu "Timer and clock configuration"
 
+config SH_TIMER
+	def_bool n
+	select GENERIC_CLOCKEVENTS
+
 config SH_TMU
 	def_bool y
 	prompt "TMU timer support"
-	depends on CPU_SH3 || CPU_SH4
+	depends on !SH_TIMER && (CPU_SH3 || CPU_SH4)
 	select GENERIC_CLOCKEVENTS
 	help
 	  This enables the use of the TMU as the system timer.
 
 config ARCH_USES_GETTIMEOFFSET
 	def_bool y
-	depends on !SH_TMU
+	depends on !SH_TMU && !SH_TIMER
 
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
--- 0003/arch/sh/kernel/time_32.c
+++ work/arch/sh/kernel/time_32.c	2008-12-10 23:06:16.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/clockchips.h>
 #include <linux/mc146818rtc.h>	/* for rtc_lock */
 #include <linux/smp.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 #include <asm/rtc.h>
 #include <asm/timer.h>
@@ -41,14 +42,6 @@ static int null_rtc_set_time(const time_
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
 
@@ -133,6 +126,9 @@ int timer_resume(struct sys_device *dev)
 #define timer_resume NULL
 #endif
 
+void (*board_time_init)(void);
+
+#ifndef CONFIG_SH_TIMER
 static struct sysdev_class timer_sysclass = {
 	.name	 = "timer",
 	.suspend = timer_suspend,
@@ -150,8 +146,6 @@ static int __init timer_init_sysfs(void)
 }
 device_initcall(timer_init_sysfs);
 
-void (*board_time_init)(void);
-
 /*
  * Shamelessly based on the MIPS and Sparc64 work.
  */
@@ -160,6 +154,14 @@ unsigned long sh_hpt_frequency = 0;
 
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
@@ -190,6 +192,7 @@ unsigned long long sched_clock(void)
 	return (ticks * timer_ticks_per_nsec_quotient) >> NSEC_PER_CYC_SHIFT;
 }
 #endif
+#endif
 
 void __init time_init(void)
 {
@@ -206,6 +209,9 @@ void __init time_init(void)
 	local_timer_setup(smp_processor_id());
 #endif
 
+#ifdef CONFIG_SH_TIMER
+	sh_timer_init();
+#else
 	/*
 	 * Find the timer to use as the system timer, it will be
 	 * initialized for us.
@@ -224,6 +230,7 @@ void __init time_init(void)
 		       ((sh_hpt_frequency + 500) / 1000) / 1000,
 		       ((sh_hpt_frequency + 500) / 1000) % 1000);
 
+#endif
 #if defined(CONFIG_SH_KGDB)
 	/*
 	 * Set up kgdb as requested. We do it here because the serial
--- 0001/drivers/clocksource/Makefile
+++ work/drivers/clocksource/Makefile	2008-12-10 23:06:16.000000000 +0900
@@ -2,3 +2,4 @@ obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_cl
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclone.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
+obj-$(CONFIG_SH_TIMER)		+= sh_timer.o
--- /dev/null
+++ work/drivers/clocksource/sh_timer.c	2008-12-10 23:22:07.000000000 +0900
@@ -0,0 +1,72 @@
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
+#include <linux/compiler.h>
+#include <linux/bootmem.h>
+#include <linux/sh_timer.h>
+
+static struct platform_device **sh_timer_pdevs;
+static int sh_timer_nr_pdevs;
+
+void sh_timer_register(struct platform_device **pdevs, int nr_pdevs)
+{
+	sh_timer_pdevs = pdevs;
+	sh_timer_nr_pdevs = nr_pdevs;
+}
+
+struct sh_timer_early * __weak sh_timer_early_probe(struct platform_device *pd)
+{
+	return NULL;
+}
+
+void __init sh_timer_free_early(void *priv, int priv_size)
+{
+	free_bootmem(__pa(priv), priv_size);
+}
+
+int __init sh_timer_init(void)
+{
+	struct platform_device *pdev;
+	struct sh_timer_early *etp;
+	void *vp;
+	int k;
+
+	plat_timer_setup();
+
+	for (k = 0; k < sh_timer_nr_pdevs; k++) {
+		pdev = sh_timer_pdevs[k];
+
+		etp = sh_timer_early_probe(pdev);
+		if (etp) {
+			vp = alloc_bootmem(etp->priv_size);
+
+			if (etp->setup(vp, pdev)) {
+				sh_timer_free_early(vp, etp->priv_size);
+				pr_warning("sh_timer: unable to setup "
+					   "early timer\n");
+			}
+		}
+	}
+
+	if (!sh_timer_nr_pdevs)
+		pr_warning("sh_timer: no early timer devices registered\n");
+
+	return 0;
+}
--- /dev/null
+++ work/include/linux/sh_timer.h	2008-12-10 23:06:16.000000000 +0900
@@ -0,0 +1,26 @@
+#ifndef __SH_TIMER_H__
+#define __SH_TIMER_H__
+#include <linux/platform_device.h>
+
+struct sh_timer_config {
+	char *name;
+	unsigned long channel_offset;
+	int timer_bit;
+	char *clk;
+	unsigned long clockevent_rating;
+	unsigned long clocksource_rating;
+};
+
+void sh_timer_register(struct platform_device **pdevs, int nr_pdevs);
+
+struct sh_timer_early {
+	int priv_size;
+	int (*setup)(void *priv, struct platform_device *pdev);
+};
+
+void sh_timer_free_early(void *priv, int priv_size);
+
+int sh_timer_init(void);
+void plat_timer_setup(void);
+
+#endif /* __SH_TIMER_H__ */
