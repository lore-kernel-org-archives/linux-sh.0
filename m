From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 17:36:07 +0000
Subject: [PATCH] ARM: mach-shmobile: CPUIdle support
Message-Id: <20110428173607.3647.365.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds a shared SH-Mobile ARM specific CPUIdle
implementation supporting WFI only at this point. It
serves as a common point for late registration of the
arch-specific CPUIdle code, and supports adding extra
sleep modes using the callback shmobile_cpuidle_setup()
together with shmobile_cpuidle_modes[].

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile              |    1 
 arch/arm/mach-shmobile/cpuidle.c             |   92 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    3 
 3 files changed, 96 insertions(+)

--- 0003/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2011-04-29 00:57:05.000000000 +0900
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_SH73A0)	+= entry-gic.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
+obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
 
 # Board objects
--- /dev/null
+++ work/arch/arm/mach-shmobile/cpuidle.c	2011-04-29 01:23:13.000000000 +0900
@@ -0,0 +1,92 @@
+/*
+ * CPUIdle support code for SH-Mobile ARM
+ *
+ *  Copyright (C) 2011 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/pm.h>
+#include <linux/cpuidle.h>
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <asm/system.h>
+#include <asm/io.h>
+
+static void shmobile_enter_wfi(void)
+{
+	cpu_do_idle();
+}
+
+void (*shmobile_cpuidle_modes[CPUIDLE_STATE_MAX])(void) = {
+	shmobile_enter_wfi, /* regular sleep mode */
+};
+
+static int shmobile_cpuidle_enter(struct cpuidle_device *dev,
+				  struct cpuidle_state *state)
+{
+	ktime_t before, after;
+	int requested_state = state - &dev->states[0];
+
+	dev->last_state = &dev->states[requested_state];
+	before = ktime_get();
+
+	local_irq_disable();
+	local_fiq_disable();
+
+	shmobile_cpuidle_modes[requested_state]();
+
+	local_irq_enable();
+	local_fiq_enable();
+
+	after = ktime_get();
+	return ktime_to_ns(ktime_sub(after, before)) >> 10;
+}
+
+static struct cpuidle_device shmobile_cpuidle_dev;
+static struct cpuidle_driver shmobile_cpuidle_driver = {
+	.name =		"shmobile_cpuidle",
+	.owner =	THIS_MODULE,
+};
+
+void (*shmobile_cpuidle_setup)(struct cpuidle_device *dev);
+
+static int shmobile_cpuidle_init(void)
+{
+	struct cpuidle_device *dev = &shmobile_cpuidle_dev;
+	struct cpuidle_state *state;
+	int i;
+
+	cpuidle_register_driver(&shmobile_cpuidle_driver);
+
+	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
+		dev->states[i].name[0] = '\0';
+		dev->states[i].desc[0] = '\0';
+		dev->states[i].enter = shmobile_cpuidle_enter;
+	}
+
+	i = CPUIDLE_DRIVER_STATE_START;
+
+	state = &dev->states[i++];
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
+	strncpy(state->desc, "WFI", CPUIDLE_DESC_LEN);
+	state->exit_latency = 1;
+	state->target_residency = 1 * 2;
+	state->power_usage = 3;
+	state->flags = 0;
+	state->flags |= CPUIDLE_FLAG_TIME_VALID;
+
+	dev->safe_state = state;
+	dev->state_count = i;
+
+	if (shmobile_cpuidle_setup)
+		shmobile_cpuidle_setup(dev);
+
+	cpuidle_register_device(dev);
+
+	return 0;
+}
+late_initcall(shmobile_cpuidle_init);
--- 0003/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-04-29 01:21:16.000000000 +0900
@@ -9,6 +9,9 @@ extern int clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
 extern void shmobile_handle_irq_gic(struct pt_regs *);
 extern struct platform_suspend_ops shmobile_suspend_ops;
+struct cpuidle_device;
+extern void (*shmobile_cpuidle_modes[])(void);
+extern void (*shmobile_cpuidle_setup)(struct cpuidle_device *dev);
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
