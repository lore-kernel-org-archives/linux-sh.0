From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 06:39:44 +0000
Subject: [PATCH 3/4] ARM: shmobile: r8a7740: move r8a7740_init_irq_of() to setup
Message-Id: <87ehac8uky.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch moves r8a7740_init_irq_of() to setup code,
and remove intc-r8a7740

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Makefile        |    2 +-
 arch/arm/mach-shmobile/intc-r8a7740.c  |   54 --------------------------------
 arch/arm/mach-shmobile/setup-r8a7740.c |   32 +++++++++++++++++++
 3 files changed, 33 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/intc-r8a7740.c

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 6f44c51..25d8890 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -11,7 +11,7 @@ obj-y				:= timer.o console.o
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
-obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o intc-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o intc-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o
diff --git a/arch/arm/mach-shmobile/intc-r8a7740.c b/arch/arm/mach-shmobile/intc-r8a7740.c
deleted file mode 100644
index 7519353..0000000
--- a/arch/arm/mach-shmobile/intc-r8a7740.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * R8A7740 processor support
- *
- * Copyright (C) 2011  Renesas Solutions Corp.
- * Copyright (C) 2011  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/arm-gic.h>
-
-void __init r8a7740_init_irq_of(void)
-{
-	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
-	void __iomem *intc_msk_base = ioremap_nocache(0xe6900040, 0x10);
-	void __iomem *pfc_inta_ctrl = ioremap_nocache(0xe605807c, 0x4);
-
-	irqchip_init();
-
-	/* route signals to GIC */
-	iowrite32(0x0, pfc_inta_ctrl);
-
-	/*
-	 * To mask the shared interrupt to SPI 149 we must ensure to set
-	 * PRIO *and* MASK. Else we run into IRQ floods when registering
-	 * the intc_irqpin devices
-	 */
-	iowrite32(0x0, intc_prio_base + 0x0);
-	iowrite32(0x0, intc_prio_base + 0x4);
-	iowrite32(0x0, intc_prio_base + 0x8);
-	iowrite32(0x0, intc_prio_base + 0xc);
-	iowrite8(0xff, intc_msk_base + 0x0);
-	iowrite8(0xff, intc_msk_base + 0x4);
-	iowrite8(0xff, intc_msk_base + 0x8);
-	iowrite8(0xff, intc_msk_base + 0xc);
-
-	iounmap(intc_prio_base);
-	iounmap(intc_msk_base);
-	iounmap(pfc_inta_ctrl);
-}
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 84c5bb6..605a532 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -22,6 +22,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
@@ -1019,6 +1021,36 @@ void __init r8a7740_init_delay(void)
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
 };
 
+void __init r8a7740_init_irq_of(void)
+{
+	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
+	void __iomem *intc_msk_base = ioremap_nocache(0xe6900040, 0x10);
+	void __iomem *pfc_inta_ctrl = ioremap_nocache(0xe605807c, 0x4);
+
+	irqchip_init();
+
+	/* route signals to GIC */
+	iowrite32(0x0, pfc_inta_ctrl);
+
+	/*
+	 * To mask the shared interrupt to SPI 149 we must ensure to set
+	 * PRIO *and* MASK. Else we run into IRQ floods when registering
+	 * the intc_irqpin devices
+	 */
+	iowrite32(0x0, intc_prio_base + 0x0);
+	iowrite32(0x0, intc_prio_base + 0x4);
+	iowrite32(0x0, intc_prio_base + 0x8);
+	iowrite32(0x0, intc_prio_base + 0xc);
+	iowrite8(0xff, intc_msk_base + 0x0);
+	iowrite8(0xff, intc_msk_base + 0x4);
+	iowrite8(0xff, intc_msk_base + 0x8);
+	iowrite8(0xff, intc_msk_base + 0xc);
+
+	iounmap(intc_prio_base);
+	iounmap(intc_msk_base);
+	iounmap(pfc_inta_ctrl);
+}
+
 static void __init r8a7740_generic_init(void)
 {
 	r8a7740_clock_init(0);
-- 
1.7.9.5

