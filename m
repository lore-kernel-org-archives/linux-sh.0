From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 29 May 2014 07:49:11 +0000
Subject: [PATCH 4/7] ARM: shmobile: add cpufreq-cpu0 driver for common SH-Mobile
Message-Id: <5386E677.60801@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I add a new file(cpufreq.c) for the following reasons.
- Registration of platform_device must be unified in SH-Mobile.
- We can't create a node of cpufreq drivers into device tree.
  (Because cpufreq driver is virtual device.)

This time, this patch only supports r8a7790/r8a7791.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/mach-shmobile/Makefile              |    1 +
 arch/arm/mach-shmobile/cpufreq.c             |   21 +++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    7 +++++++
 3 files changed, 29 insertions(+)
 create mode 100644 arch/arm/mach-shmobile/cpufreq.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 0d6a04c..d4fd9a9 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
+obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
diff --git a/arch/arm/mach-shmobile/cpufreq.c b/arch/arm/mach-shmobile/cpufreq.c
new file mode 100644
index 0000000..254a920
--- /dev/null
+++ b/arch/arm/mach-shmobile/cpufreq.c
@@ -0,0 +1,21 @@
+/*
+ * CPUFreq support code for SH-Mobile ARM
+ *
+ *  Copyright (C) 2014 Gaku Inami
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+int __init shmobile_cpufreq_init(void)
+{
+	if (!(of_machine_is_compatible("renesas,r8a7790")) ||
+		!(of_machine_is_compatible("renesas,r8a7791")))
+		platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
+
+	return 0;
+}
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index f7a360e..921a18e 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -45,12 +45,19 @@ int shmobile_cpuidle_init(void);
 static inline int shmobile_cpuidle_init(void) { return 0; }
 #endif
 
+#ifdef CONFIG_CPU_FREQ
+int shmobile_cpufreq_init(void);
+#else
+static inline int shmobile_cpufreq_init(void) { return 0; }
+#endif
+
 extern void __iomem *shmobile_scu_base;
 
 static inline void __init shmobile_init_late(void)
 {
 	shmobile_suspend_init();
 	shmobile_cpuidle_init();
+	shmobile_cpufreq_init();
 }
 
 #endif /* __ARCH_MACH_COMMON_H */
-- 
1.7.9.5

