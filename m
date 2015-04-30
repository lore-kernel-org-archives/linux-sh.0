From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:59 +0000
Subject: [PATCH v2 10/15] ARM: shmobile: r8a7793: add SMP support
Message-Id: <1430403544-26742-11-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enables SMP support, similar to other R-Car Gen2 SoCs.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
[uli: moved reset handling to PM, minor adjustments]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/Makefile        |  1 +
 arch/arm/mach-shmobile/r8a7793.h       |  6 +++
 arch/arm/mach-shmobile/setup-r8a7793.c |  2 +
 arch/arm/mach-shmobile/smp-r8a7793.c   | 67 ++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/r8a7793.h
 create mode 100644 arch/arm/mach-shmobile/smp-r8a7793.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e4b8fdb..a8f5d5d 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -42,6 +42,7 @@ smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7779)	+= smp-r8a7779.o headsmp-scu.o platsmp-scu.o
 smp-$(CONFIG_ARCH_R8A7790)	+= smp-r8a7790.o
 smp-$(CONFIG_ARCH_R8A7791)	+= smp-r8a7791.o
+smp-$(CONFIG_ARCH_R8A7793)	+= smp-r8a7793.o
 smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o headsmp-scu.o platsmp-scu.o
 
 # PM objects
diff --git a/arch/arm/mach-shmobile/r8a7793.h b/arch/arm/mach-shmobile/r8a7793.h
new file mode 100644
index 0000000..f961677
--- /dev/null
+++ b/arch/arm/mach-shmobile/r8a7793.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_R8A7793_H__
+#define __ASM_R8A7793_H__
+
+extern struct smp_operations r8a7793_smp_ops;
+
+#endif /* __ASM_R8A7793_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7793.c b/arch/arm/mach-shmobile/setup-r8a7793.c
index 1d2825c..d20cf2a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7793.c
+++ b/arch/arm/mach-shmobile/setup-r8a7793.c
@@ -17,6 +17,7 @@
 #include <asm/mach/arch.h>
 
 #include "common.h"
+#include "r8a7793.h"
 #include "rcar-gen2.h"
 
 static const char *r8a7793_boards_compat_dt[] __initconst = {
@@ -25,6 +26,7 @@ static const char *r8a7793_boards_compat_dt[] __initconst = {
 };
 
 DT_MACHINE_START(R8A7793_DT, "Generic R8A7793 (Flattened Device Tree)")
+	.smp		= smp_ops(r8a7793_smp_ops),
 	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_late	= shmobile_init_late,
diff --git a/arch/arm/mach-shmobile/smp-r8a7793.c b/arch/arm/mach-shmobile/smp-r8a7793.c
new file mode 100644
index 0000000..59b77b2
--- /dev/null
+++ b/arch/arm/mach-shmobile/smp-r8a7793.c
@@ -0,0 +1,67 @@
+/*
+ * SMP support for r8a7793
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2015 Ulrich Hecht
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
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/smp_plat.h>
+#include "platsmp-apmu.h"
+
+#include "common.h"
+#include "pm-rcar.h"
+#include "r8a7793.h"
+#include "rcar-gen2.h"
+
+#define APMU		0xe6151000
+#define CA15DBGRCR	0x1180
+#define CA15RESCNT	0x0040
+
+static struct rcar_apmu_config r8a7793_apmu_config[] = {
+	{
+		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
+		.cpus = { 0, 1 },
+	},
+};
+
+static void __init r8a7793_smp_prepare_cpus(unsigned int max_cpus)
+{
+	void __iomem *p;
+	u32 val;
+
+	/* let APMU code install data related to shmobile_boot_vector */
+	shmobile_smp_apmu_prepare_cpus(max_cpus,
+				       r8a7793_apmu_config,
+				       ARRAY_SIZE(r8a7793_apmu_config));
+
+	/* setup for debug mode */
+	if (rcar_gen2_read_mode_pins() & MD(21)) {
+		p = ioremap_nocache(APMU, 0x2000);
+		val = readl_relaxed(p + CA15DBGRCR);
+		writel_relaxed((val | 0x01f80000), p + CA15DBGRCR);
+		iounmap(p);
+	}
+}
+
+struct smp_operations r8a7793_smp_ops __initdata = {
+	.smp_prepare_cpus	= r8a7793_smp_prepare_cpus,
+	.smp_boot_secondary	= shmobile_smp_apmu_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable		= shmobile_smp_cpu_disable,
+	.cpu_die		= shmobile_smp_apmu_cpu_die,
+	.cpu_kill		= shmobile_smp_apmu_cpu_kill,
+#endif
+};
-- 
2.3.5

