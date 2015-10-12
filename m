From: ahaslam@baylibre.com
Date: Mon, 12 Oct 2015 17:41:12 +0000
Subject: [RFC/RFT 4/6] ARM: shmobile: Add MCPM back end functions
Message-Id: <1444671674-19275-5-git-send-email-ahaslam@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Axel Haslam <ahaslam@baylibre.com>

Add machine-dependent MCPM call-backs for shmobile.

(inspired form arch/arm/mach-vexpress/tc2_pm.c)

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-shmobile/Kconfig         |   9 ++
 arch/arm/mach-shmobile/Makefile        |   1 +
 arch/arm/mach-shmobile/common.h        |   6 ++
 arch/arm/mach-shmobile/mcpm-shmobile.c | 155 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/platsmp-apmu.c  |   2 +-
 5 files changed, 172 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/mach-shmobile/mcpm-shmobile.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 926e336..e73628d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -75,6 +75,7 @@ config ARCH_R8A7779
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
 	select ARCH_RCAR_GEN2
+	select SHMOBILE_MCPM if MCPM
 	select I2C
 
 config ARCH_R8A7791
@@ -96,6 +97,14 @@ config ARCH_SH73A0
 	select ARCH_RMOBILE
 	select RENESAS_INTC_IRQPIN
 
+config SHMOBILE_MCPM
+	bool "Shmobile Multi-Cluster PM support"
+	default n
+	depends on MCPM
+	select ARM_CCI400_PORT_CTRL
+	help
+	  This is needed to provide CPU and cluster power management.
+
 comment "Renesas ARM SoCs System Configuration"
 endif
 
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 476de30..8793a83 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
 obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
+obj-$(CONFIG_SHMOBILE_MCPM)	+= mcpm-shmobile.o
 
 # Board objects
 ifndef CONFIG_ARCH_SHMOBILE_MULTI
diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 8d27ec5..13a4efd 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -22,6 +22,12 @@ struct clk;
 extern int shmobile_clk_init(void);
 extern struct platform_suspend_ops shmobile_suspend_ops;
 
+#if defined(CONFIG_SHMOBILE_MCPM)
+extern bool sh_mcpm_probed(void);
+#else
+static inline bool sh_mcpm_probed(void) { return false; }
+#endif
+
 #ifdef CONFIG_SUSPEND
 int shmobile_suspend_init(void);
 void shmobile_smp_apmu_suspend_init(void);
diff --git a/arch/arm/mach-shmobile/mcpm-shmobile.c b/arch/arm/mach-shmobile/mcpm-shmobile.c
new file mode 100644
index 0000000..cc7fe5f
--- /dev/null
+++ b/arch/arm/mach-shmobile/mcpm-shmobile.c
@@ -0,0 +1,155 @@
+/*
+ * SMP support for SoCs with APMU
+ *
+ * Copyright (C) 2015  Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <asm/cp15.h>
+#include <asm/cputype.h>
+#include <asm/smp_plat.h>
+#include <asm/cacheflush.h>
+
+#include <linux/arm-cci.h>
+#include <linux/of.h>
+
+#include "common.h"
+#include "platsmp-apmu.h"
+
+static bool sh_mcpm_probe_ok;
+
+static inline unsigned int pcpu_to_cpu(unsigned int pcpu, unsigned int pcluster)
+{
+	unsigned int mpidr = 0;
+
+	mpidr = pcpu | (pcluster << MPIDR_LEVEL_BITS);
+
+	return get_logical_index(mpidr);
+}
+
+bool sh_mcpm_probed(void)
+{
+	return sh_mcpm_probe_ok;
+}
+
+static void __naked sh_mcpm_power_up_setup(unsigned int affinity_level)
+{
+	asm volatile ("\n"
+	"cmp	r0, #1\n"
+	"bxne	lr\n"
+	"b	cci_enable_port_for_self ");
+}
+
+static int sh_mcpm_cpu_powerup(unsigned int pcpu, unsigned int pcluster)
+{
+	int cpu = pcpu_to_cpu(pcpu, pcluster);
+
+	apmu_power_on(cpu);
+
+	return 0;
+}
+
+static int sh_mcpm_cluster_powerup(unsigned int cluster)
+{
+	return 0;
+}
+
+static void sh_mcpm_cpu_powerdown_prepare(unsigned int pcpu,
+						unsigned int pcluster)
+{
+	int cpu = pcpu_to_cpu(pcpu, pcluster);
+
+	apmu_power_off(cpu);
+}
+
+static void sh_mcpm_cluster_powerdown_prepare(unsigned int pcluster)
+{
+}
+
+static void sh_mcpm_cpu_cache_disable(void)
+{
+	v7_exit_coherency_flush(louis);
+}
+
+static void sh_mcpm_cluster_cache_disable(void)
+{
+	if (read_cpuid_part() = ARM_CPU_PART_CORTEX_A15) {
+		 /* disable L2 prefetching on the Cortex-A15 */
+		asm volatile(
+		"mcr    p15, 1, %0, c15, c0, 3\n\t"
+		"isb\n\t"
+		"dsb"
+		: : "r" (0x400));
+	}
+
+	v7_exit_coherency_flush(all);
+	cci_disable_port_by_cpu(read_cpuid_mpidr());
+}
+
+static void sh_mcpm_cpu_is_up(unsigned int pcpu, unsigned int pcluster)
+{
+}
+
+static int sh_mcpm_wait_for_powerdown(unsigned int pcpu, unsigned int pcluster)
+{
+	int cpu = pcpu_to_cpu(pcpu, pcluster);
+
+	apmu_power_off_poll(cpu);
+
+	return 0;
+}
+
+static const struct mcpm_platform_ops sh_mcpm_power_ops = {
+	.cpu_powerup            = sh_mcpm_cpu_powerup,
+	.cluster_powerup        = sh_mcpm_cluster_powerup,
+	.cpu_powerdown_prepare  = sh_mcpm_cpu_powerdown_prepare,
+	.cluster_powerdown_prepare = sh_mcpm_cluster_powerdown_prepare,
+	.cpu_cache_disable      = sh_mcpm_cpu_cache_disable,
+	.cluster_cache_disable  = sh_mcpm_cluster_cache_disable,
+	.wait_for_powerdown     = sh_mcpm_wait_for_powerdown,
+	.cpu_is_up              = sh_mcpm_cpu_is_up,
+};
+
+static int __init sh_mcpm_init(void)
+{
+	struct device_node *node;
+	int ret = 0;
+	int i;
+
+	sh_mcpm_probe_ok = false;
+
+	/* Register boot function as boot cpu did not call power up
+	 * but will call power down on idle.
+	 */
+
+	node = of_find_compatible_node(NULL, NULL, "arm,cci-400");
+	if (!node && !of_device_is_available(node)) {
+		pr_err("cci-400 node not found!");
+		return -ENODEV;
+	}
+
+	if (!cci_probed())
+		return -ENODEV;
+
+	ret = mcpm_platform_register(&sh_mcpm_power_ops);
+	if (!ret)
+		ret = mcpm_sync_init(sh_mcpm_power_up_setup);
+	if (!ret)
+		ret = mcpm_loopback(sh_mcpm_cluster_cache_disable); /* CCI on */
+	if (ret) {
+		pr_err("mcpm could not be stared. %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < num_possible_cpus(); i++)
+		shmobile_smp_hook(i,
+			virt_to_phys(mcpm_entry_point), 0);
+
+	mcpm_smp_set_ops();
+	sh_mcpm_probe_ok = true;
+
+	return 0;
+}
+early_initcall(sh_mcpm_init);
diff --git a/arch/arm/mach-shmobile/platsmp-apmu.c b/arch/arm/mach-shmobile/platsmp-apmu.c
index b88d97c..e9988b7 100644
--- a/arch/arm/mach-shmobile/platsmp-apmu.c
+++ b/arch/arm/mach-shmobile/platsmp-apmu.c
@@ -46,7 +46,7 @@ int __maybe_unused apmu_power_on(unsigned int cpu)
 	if (!p)
 		return -EINVAL;
 
-	if (pcluster != boot_pcluster) {
+	if (!sh_mcpm_probed() && (pcluster != boot_pcluster)) {
 		pr_err("Requested to boot cpu %d on non-boot cluster!\n", cpu);
 		return -EINVAL;
 	}
-- 
2.4.5

