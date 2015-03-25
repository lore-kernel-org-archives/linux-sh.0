From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Wed, 25 Mar 2015 05:45:35 +0000
Subject: [RFC/PATCH] ARM: shmobile: Consolidate the smp code for R-Car Gen2
Message-Id: <55124B7F.3060103@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5502A268.2030304@bp.renesas.com>
In-Reply-To: <5502A268.2030304@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The smp code for R-Car Gen2 is scatterd in each SoC. These files
(smp-r8a7790.c/smp-r8a7791.c) have some overlap code. This change
consolidate the smp code for R-Car Gen2 into one.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---

Based on : renesas-devel-20150324-v4.0-rc5

 arch/arm/mach-shmobile/Makefile        |    3 +-
 arch/arm/mach-shmobile/r8a7790.h       |    6 --
 arch/arm/mach-shmobile/r8a7791.h       |    6 --
 arch/arm/mach-shmobile/rcar-gen2.h     |    2 +
 arch/arm/mach-shmobile/setup-r8a7790.c |    3 +-
 arch/arm/mach-shmobile/setup-r8a7791.c |    3 +-
 arch/arm/mach-shmobile/smp-r8a7790.c   |   71 ------------------
 arch/arm/mach-shmobile/smp-r8a7791.c   |   65 -----------------
 arch/arm/mach-shmobile/smp-rcar-gen2.c |  125 ++++++++++++++++++++++++++++++++
 9 files changed, 130 insertions(+), 154 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/r8a7790.h
 delete mode 100644 arch/arm/mach-shmobile/r8a7791.h
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7790.c
 delete mode 100644 arch/arm/mach-shmobile/smp-r8a7791.c
 create mode 100644 arch/arm/mach-shmobile/smp-rcar-gen2.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 89e463d..a5e42d6 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -39,9 +39,8 @@ obj-$(CONFIG_ARCH_R8A7791)	+= regulator-quirk-rcar-gen2.o
 smp-y				:= $(cpu-y)
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
-smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
-smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
+smp-$(CONFIG_ARCH_RCAR_GEN2)	+= smp-rcar-gen2.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
diff --git a/arch/arm/mach-shmobile/r8a7790.h b/arch/arm/mach-shmobile/r8a7790.h
deleted file mode 100644
index 1a46d02..0000000
--- a/arch/arm/mach-shmobile/r8a7790.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_R8A7790_H__
-#define __ASM_R8A7790_H__
-
-extern struct smp_operations r8a7790_smp_ops;
-
-#endif /* __ASM_R8A7790_H__ */
diff --git a/arch/arm/mach-shmobile/r8a7791.h b/arch/arm/mach-shmobile/r8a7791.h
deleted file mode 100644
index 7ca0b7d..0000000
--- a/arch/arm/mach-shmobile/r8a7791.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_R8A7791_H__
-#define __ASM_R8A7791_H__
-
-extern struct smp_operations r8a7791_smp_ops;
-
-#endif /* __ASM_R8A7791_H__ */
diff --git a/arch/arm/mach-shmobile/rcar-gen2.h b/arch/arm/mach-shmobile/rcar-gen2.h
index 8a66b4a..a0b811f 100644
--- a/arch/arm/mach-shmobile/rcar-gen2.h
+++ b/arch/arm/mach-shmobile/rcar-gen2.h
@@ -7,4 +7,6 @@ u32 rcar_gen2_read_mode_pins(void);
 void rcar_gen2_reserve(void);
 void rcar_gen2_pm_init(void);
 
+extern struct smp_operations rcar_gen2_smp_ops;
+
 #endif /* __ASM_RCAR_GEN2_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 3a18af4..2e59dd2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -19,7 +19,6 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include "r8a7790.h"
 #include "rcar-gen2.h"
 
 static const char * const r8a7790_boards_compat_dt[] __initconst = {
@@ -28,7 +27,7 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
-	.smp		= smp_ops(r8a7790_smp_ops),
+	.smp		= smp_ops(rcar_gen2_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index ef8eb3a..cd77d3b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -20,7 +20,6 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
-#include "r8a7791.h"
 #include "rcar-gen2.h"
 
 static const char *r8a7791_boards_compat_dt[] __initdata = {
@@ -29,7 +28,7 @@ static const char *r8a7791_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
-	.smp		= smp_ops(r8a7791_smp_ops),
+	.smp		= smp_ops(rcar_gen2_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
deleted file mode 100644
index 930f45c..0000000
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- * SMP support for r8a7790
- *
- * Copyright (C) 2012-2013 Renesas Solutions Corp.
- * Copyright (C) 2012 Takashi Yoshii <takashi.yoshii.ze@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/io.h>
-
-#include <asm/smp_plat.h>
-
-#include "common.h"
-#include "platsmp-apmu.h"
-#include "pm-rcar.h"
-#include "rcar-gen2.h"
-#include "r8a7790.h"
-
-static struct rcar_sysc_ch r8a7790_ca15_scu = {
-	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
-	.isr_bit = 12, /* CA15-SCU */
-};
-
-static struct rcar_sysc_ch r8a7790_ca7_scu = {
-	.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
-	.isr_bit = 21, /* CA7-SCU */
-};
-
-static struct rcar_apmu_config r8a7790_apmu_config[] = {
-	{
-		.iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
-		.cpus = { 0, 1, 2, 3 },
-	},
-	{
-		.iomem = DEFINE_RES_MEM(0xe6151000, 0x188),
-		.cpus = { 0x100, 0x0101, 0x102, 0x103 },
-	}
-};
-
-static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
-{
-	/* let APMU code install data related to shmobile_boot_vector */
-	shmobile_smp_apmu_prepare_cpus(max_cpus,
-				       r8a7790_apmu_config,
-				       ARRAY_SIZE(r8a7790_apmu_config));
-
-	/* turn on power to SCU */
-	rcar_gen2_pm_init();
-	rcar_sysc_power_up(&r8a7790_ca15_scu);
-	rcar_sysc_power_up(&r8a7790_ca7_scu);
-}
-
-struct smp_operations r8a7790_smp_ops __initdata = {
-	.smp_prepare_cpus	= r8a7790_smp_prepare_cpus,
-	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
-#ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= shmobile_smp_cpu_disable,
-	.cpu_die		= shmobile_smp_apmu_cpu_die,
-	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
-#endif
-};
diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
deleted file mode 100644
index 5e2d1db..0000000
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- * SMP support for r8a7791
- *
- * Copyright (C) 2013 Renesas Solutions Corp.
- * Copyright (C) 2013 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/io.h>
-
-#include <asm/smp_plat.h>
-
-#include "common.h"
-#include "platsmp-apmu.h"
-#include "r8a7791.h"
-#include "rcar-gen2.h"
-
-static struct rcar_apmu_config r8a7791_apmu_config[] = {
-	{
-		.iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
-		.cpus = { 0, 1 },
-	}
-};
-
-static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
-{
-	/* let APMU code install data related to shmobile_boot_vector */
-	shmobile_smp_apmu_prepare_cpus(max_cpus,
-				       r8a7791_apmu_config,
-				       ARRAY_SIZE(r8a7791_apmu_config));
-
-	rcar_gen2_pm_init();
-}
-
-static int r8a7791_smp_boot_secondary(unsigned int cpu,
-				      struct task_struct *idle)
-{
-	/* Error out when hardware debug mode is enabled */
-	if (rcar_gen2_read_mode_pins() & BIT(21)) {
-		pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
-		return -ENOTSUPP;
-	}
-
-	return shmobile_smp_apmu_boot_secondary(cpu, idle);
-}
-
-struct smp_operations r8a7791_smp_ops __initdata = {
-	.smp_prepare_cpus	= r8a7791_smp_prepare_cpus,
-	.smp_boot_secondary	= r8a7791_smp_boot_secondary,
-#ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable		= shmobile_smp_cpu_disable,
-	.cpu_die		= shmobile_smp_apmu_cpu_die,
-	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
-#endif
-};
diff --git a/arch/arm/mach-shmobile/smp-rcar-gen2.c b/arch/arm/mach-shmobile/smp-rcar-gen2.c
new file mode 100644
index 0000000..fcf79f7
--- /dev/null
+++ b/arch/arm/mach-shmobile/smp-rcar-gen2.c
@@ -0,0 +1,125 @@
+/*
+ * R-Car Generation 2 SMP support
+ *
+ * Copyright (C) 2015 Renesas Electronics Corporation
+ * Copyright (C) 2013 Magnus Damm
+ * Copyright (C) 2012-2013 Renesas Solutions Corp.
+ * Copyright (C) 2012 Takashi Yoshii <takashi.yoshii.ze@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/smp.h>
+
+#include <asm/cputype.h>
+#include <asm/smp_plat.h>
+
+#include "common.h"
+#include "platsmp-apmu.h"
+#include "pm-rcar.h"
+#include "rcar-gen2.h"
+
+static struct rcar_sysc_ch rcar_gen2_ca15_scu = {
+	.chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
+	.isr_bit = 12, /* CA15-SCU */
+};
+
+static struct rcar_sysc_ch rcar_gen2_ca7_scu = {
+	.chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
+	.isr_bit = 21, /* CA7-SCU */
+};
+
+static struct rcar_apmu_config r8a7790_apmu_config[] = {
+	{
+		.iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
+		.cpus = { 0, 1, 2, 3 },
+	},
+	{
+		.iomem = DEFINE_RES_MEM(0xe6151000, 0x188),
+		.cpus = { 0x100, 0x0101, 0x102, 0x103 },
+	}
+};
+
+static struct rcar_apmu_config r8a7791_apmu_config[] = {
+	{
+		.iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
+		.cpus = { 0, 1 },
+	}
+};
+
+static void __init rcar_gen2_smp_prepare_cpus(unsigned int max_cpus)
+{
+	struct device_node *np, *cpus;
+	bool has_a7 = false;
+	bool has_a15 = false;
+	u32 this_cluster;
+	struct rcar_apmu_config *rcar_gen2_apmu_config;
+	u32 rcar_apmu_config_size;
+
+	cpus = of_find_node_by_path("/cpus");
+	if (!cpus)
+		return;
+
+	for_each_child_of_node(cpus, np) {
+		if (of_device_is_compatible(np, "arm,cortex-a15"))
+			has_a15 = true;
+		else if (of_device_is_compatible(np, "arm,cortex-a7"))
+			has_a7 = true;
+	}
+
+	if (of_machine_is_compatible("renesas,r8a7790")) {
+		rcar_gen2_apmu_config = &r8a7790_apmu_config[0];
+		rcar_apmu_config_size = ARRAY_SIZE(r8a7790_apmu_config);
+	} else if (of_machine_is_compatible("renesas,r8a7791")) {
+		rcar_gen2_apmu_config = &r8a7791_apmu_config[0];
+		rcar_apmu_config_size = ARRAY_SIZE(r8a7791_apmu_config);
+	}
+
+	/* let APMU code install data related to shmobile_boot_vector */
+	shmobile_smp_apmu_prepare_cpus(max_cpus,
+				       rcar_gen2_apmu_config,
+				       rcar_apmu_config_size);
+
+	rcar_gen2_pm_init();
+
+	/* turn on power to SCU of second cluster */
+	if (has_a15 && has_a7) {
+		this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
+		if (this_cluster = 0)
+			rcar_sysc_power_up(&rcar_gen2_ca7_scu);
+		else
+			rcar_sysc_power_up(&rcar_gen2_ca15_scu);
+	}
+}
+
+static int rcar_gen2_smp_boot_secondary(unsigned int cpu,
+				      struct task_struct *idle)
+{
+	/* Error out when hardware debug mode is enabled */
+	if (of_machine_is_compatible("renesas,r8a7791") &&
+	    rcar_gen2_read_mode_pins() & BIT(21)) {
+		pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
+		return -ENOTSUPP;
+	}
+
+	return shmobile_smp_apmu_boot_secondary(cpu, idle);
+}
+
+struct smp_operations rcar_gen2_smp_ops __initdata = {
+	.smp_prepare_cpus	= rcar_gen2_smp_prepare_cpus,
+	.smp_boot_secondary	= rcar_gen2_smp_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
+#endif
+};
-- 
1.7.9.5

