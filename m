From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Mar 2015 01:21:45 +0000
Subject: [PATCH 5/5] ARM: shmobile: r8a7794 SMP support
Message-Id: <54F50CA9.5080900@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/mach-shmobile/Makefile        |    1 +
 arch/arm/mach-shmobile/r8a7794.h       |    2 ++
 arch/arm/mach-shmobile/setup-r8a7794.c |    2 ++
 arch/arm/mach-shmobile/smp-r8a7794.c   |   49 ++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/smp-r8a7794.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index cde95f8..50ed8c4 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -39,6 +39,7 @@ smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
+smp-$(CONFIG_ARCH_R8A7794)	+= smp-r8a7794.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
diff --git a/arch/arm/mach-shmobile/r8a7794.h b/arch/arm/mach-shmobile/r8a7794.h
index b83d387..a1d71e6 100644
--- a/arch/arm/mach-shmobile/r8a7794.h
+++ b/arch/arm/mach-shmobile/r8a7794.h
@@ -3,4 +3,6 @@
 
 void r8a7794_pm_init(void);
 
+extern struct smp_operations r8a7794_smp_ops;
+
 #endif /* __ASM_R8A7794_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
index d2b0930..c6d5a23 100644
--- a/arch/arm/mach-shmobile/setup-r8a7794.c
+++ b/arch/arm/mach-shmobile/setup-r8a7794.c
@@ -17,6 +17,7 @@
 #include <linux/of_platform.h>
 #include "common.h"
 #include "rcar-gen2.h"
+#include "r8a7794.h"
 #include <asm/mach/arch.h>
 
 static const char * const r8a7794_boards_compat_dt[] __initconst = {
@@ -25,6 +26,7 @@ static const char * const r8a7794_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7794_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.init_time	= rcar_gen2_timer_init,
diff --git a/arch/arm/mach-shmobile/smp-r8a7794.c b/arch/arm/mach-shmobile/smp-r8a7794.c
new file mode 100644
index 0000000..eda4d57
--- /dev/null
+++ b/arch/arm/mach-shmobile/smp-r8a7794.c
@@ -0,0 +1,49 @@
+/*
+ * SMP support for r8a7794
+ *
+ * Copyright (C) 2015 Renesas Electronics Corporation
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
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/smp_plat.h>
+
+#include "common.h"
+#include "platsmp-apmu.h"
+#include "r8a7794.h"
+
+static struct rcar_apmu_config r8a7794_apmu_config[] = {
+	{
+		.iomem = DEFINE_RES_MEM(0xe6151000, 0x188),
+		.cpus = { 0, 1 },
+	}
+};
+
+static void __init r8a7794_smp_prepare_cpus(unsigned int max_cpus)
+{
+	/* let APMU code install data related to shmobile_boot_vector */
+	shmobile_smp_apmu_prepare_cpus(max_cpus,
+				       r8a7794_apmu_config,
+				       ARRAY_SIZE(r8a7794_apmu_config));
+
+	r8a7794_pm_init();
+}
+
+struct smp_operations r8a7794_smp_ops __initdata = {
+	.smp_prepare_cpus	= r8a7794_smp_prepare_cpus,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
+#endif
+};
-- 
1.7.9.5

