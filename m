From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jul 2012 08:25:58 +0000
Subject: [PATCH 03/12 v2] ARM: shmobile: r8a7740: add A4S pm domain support
Message-Id: <871ukqr4vg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds basic A4S pm domain support.
Now, below devices can be controled by PM

Common-SHwy, Common-HPB, BSC, MFI, MMFROM, HS-SHwy,
SYS-HPB, INTCA, DBSC, DDRPHY (Logic),
ATAPI, GbEther, AXI-bus

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - based on pm-rmobile

 arch/arm/mach-shmobile/Makefile               |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    6 +++++
 arch/arm/mach-shmobile/pm-r8a7740.c           |   30 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c        |    5 ++++
 4 files changed, 42 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/pm-r8a7740.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 3ffe412..0df5ae6 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
 obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
+obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
 # Board objects
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 8bd7b9c..e8c87e9 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -19,6 +19,8 @@
 #ifndef __ASM_R8A7740_H__
 #define __ASM_R8A7740_H__
 
+#include <mach/pm-rmobile.h>
+
 /*
  * MD_CKx pin
  */
@@ -604,4 +606,8 @@ enum {
 	SHDMA_SLAVE_USBHS_RX,
 };
 
+#ifdef CONFIG_PM
+extern struct rmobile_pm_domain r8a7740_pd_a4s;
+#endif /* CONFIG_PM */
+
 #endif /* __ASM_R8A7740_H__ */
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
new file mode 100644
index 0000000..d2fe815
--- /dev/null
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -0,0 +1,30 @@
+/*
+ * r8a7740 power management support
+ *
+ * Copyright (C) 2012  Renesas Solutions Corp.
+ * Copyright (C) 2012  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <mach/pm-rmobile.h>
+
+#ifdef CONFIG_PM
+static int r8a7740_pd_a4s_suspend(void)
+{
+	/*
+	 * The A4S domain contains the CPU core and therefore it should
+	 * only be turned off if the CPU is in use.
+	 */
+	return -EBUSY;
+}
+
+struct rmobile_pm_domain r8a7740_pd_a4s = {
+	.genpd.name	= "A4S",
+	.bit_shift	= 10,
+	.gov		= &pm_domain_always_on_gov,
+	.no_debug	= true,
+	.suspend	= r8a7740_pd_a4s_suspend,
+};
+#endif /* CONFIG_PM */
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 48d7bbf..c37ad75 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -29,6 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <mach/dma-register.h>
 #include <mach/r8a7740.h>
+#include <mach/pm-rmobile.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <asm/mach-types.h>
@@ -671,6 +672,10 @@ void __init r8a7740_add_standard_devices(void)
 	r8a7740_i2c_workaround(&i2c0_device);
 	r8a7740_i2c_workaround(&i2c1_device);
 
+	/* PM domain */
+	rmobile_init_pm_domain(&r8a7740_pd_a4s);
+
+	/* add devices */
 	platform_add_devices(r8a7740_early_devices,
 			    ARRAY_SIZE(r8a7740_early_devices));
 	platform_add_devices(r8a7740_late_devices,
-- 
1.7.5.4

