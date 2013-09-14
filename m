From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 14 Sep 2013 14:15:43 +0000
Subject: [PATCH 02/02] cpuidle: Renesas SCU Core Shutdown CPUIdle driver
Message-Id: <20130914141543.19348.35211.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

CPUIdle prototype support for SCU based SoCs from Renesas,
currently tested on sh73a0 with Core Shutdown mode.

The Core Shutdown mode will turn off the power domain for the
CPU core, and resume will happen from the reset vector.

At this point SMP operation is somewhat working, but there are
known issues with for instance CPU Hotplug. If CPU Hotplug is
used in parallel with CPUIdle then the resume path breaks.

Future work include CPU Hotplug code sharing and cache handling.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/cpuidle/Kconfig               |    6 +++
 drivers/cpuidle/Makefile              |    1 
 drivers/cpuidle/cpuidle-renesas-scu.c |   66 +++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)

--- 0001/drivers/cpuidle/Kconfig
+++ work/drivers/cpuidle/Kconfig	2013-09-14 19:54:45.000000000 +0900
@@ -36,6 +36,12 @@ config CPU_IDLE_CALXEDA
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 
+config CPU_IDLE_RENESAS_SCU
+	bool "CPU Idle Driver for Renesas SoCs using SCU"
+	select ARM_CPU_SUSPEND
+	help
+	  Select this to enable cpuidle on Renesas SoCs with SCU.
+
 config CPU_IDLE_ZYNQ
 	bool "CPU Idle Driver for Xilinx Zynq processors"
 	depends on ARCH_ZYNQ
--- 0001/drivers/cpuidle/Makefile
+++ work/drivers/cpuidle/Makefile	2013-09-14 19:52:00.000000000 +0900
@@ -6,5 +6,6 @@ obj-y += cpuidle.o driver.o governor.o s
 obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 obj-$(CONFIG_CPU_IDLE_CALXEDA) += cpuidle-calxeda.o
+obj-$(CONFIG_CPU_IDLE_RENESAS_SCU) += cpuidle-renesas-scu.o
 obj-$(CONFIG_ARCH_KIRKWOOD) += cpuidle-kirkwood.o
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
--- /dev/null
+++ work/drivers/cpuidle/cpuidle-renesas-scu.c	2013-09-14 22:03:29.000000000 +0900
@@ -0,0 +1,66 @@
+/*
+ * CPUIdle prototype for SoCs with SCU covered by mach-shmobile
+ *
+ * Copyright (C) 2013 Magnus Damm
+ *
+ * Based on cpuidle-zynq.c
+ * Copyright (C) 2012-2013 Xilinx
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <asm/smp_scu.h>
+#include <asm/suspend.h>
+
+extern void *shmobile_scu_base;
+
+static int renesas_scu_idle_do_core_shutdown(unsigned long val)
+{
+	scu_power_mode(shmobile_scu_base, SCU_PM_POWEROFF);
+	cpu_do_idle();
+	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
+	return 1;
+}
+
+static int renesas_scu_idle_enter_core_shutdown(struct cpuidle_device *dev,
+						struct cpuidle_driver *drv,
+						int index)
+{
+	cpu_pm_enter();
+	cpu_suspend(0, renesas_scu_idle_do_core_shutdown);
+	cpu_pm_exit();
+	return index;
+}
+
+static struct cpuidle_driver renesas_scu_idle_driver = {
+	.name = "renesas_scu_idle",
+	.states = {
+		ARM_CPUIDLE_WFI_STATE,
+		{
+			.name = "C2",
+			.desc = "Core Shutdown",
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.exit_latency = 10,
+			.target_residency = 20 + 10,
+			.enter = renesas_scu_idle_enter_core_shutdown,
+		},
+	},
+	.state_count = 2,
+};
+
+static int __init renesas_scu_cpuidle_init(void)
+{
+	if (!of_machine_is_compatible("renesas,sh73a0"))
+		return -ENODEV;
+
+	return cpuidle_register(&renesas_scu_idle_driver, NULL);
+}
+module_init(renesas_scu_cpuidle_init);
