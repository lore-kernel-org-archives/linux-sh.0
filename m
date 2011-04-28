From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 17:23:28 +0000
Subject: [PATCH] ARM: mach-shmobile: Suspend-to-RAM support
Message-Id: <20110428172328.3626.92816.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds a simple Suspend-to-RAM implementation
for SH-Mobile ARM. The struct shmobile_suspend_ops are
kept global to allow cpu-specific code to override
the callbacks if needed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile              |    3 +
 arch/arm/mach-shmobile/include/mach/common.h |    1 
 arch/arm/mach-shmobile/suspend.c             |   47 ++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2011-04-29 00:43:15.000000000 +0900
@@ -30,6 +30,9 @@ obj-$(CONFIG_ARCH_SH7377)	+= entry-intc.
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
 obj-$(CONFIG_ARCH_SH73A0)	+= entry-gic.o
 
+# PM objects
+obj-$(CONFIG_SUSPEND)		+= suspend.o
+
 # Board objects
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
 obj-$(CONFIG_MACH_G4EVM)	+= board-g4evm.o
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2011-04-29 00:43:10.000000000 +0900
@@ -8,6 +8,7 @@ struct clk;
 extern int clk_init(void);
 extern void shmobile_handle_irq_intc(struct pt_regs *);
 extern void shmobile_handle_irq_gic(struct pt_regs *);
+extern struct platform_suspend_ops shmobile_suspend_ops;
 
 extern void sh7367_init_irq(void);
 extern void sh7367_add_early_devices(void);
--- /dev/null
+++ work/arch/arm/mach-shmobile/suspend.c	2011-04-29 00:43:11.000000000 +0900
@@ -0,0 +1,47 @@
+/*
+ * Suspend-to-RAM support code for SH-Mobile ARM
+ *
+ *  Copyright (C) 2011 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/err.h>
+#include <asm/system.h>
+#include <asm/io.h>
+
+static int shmobile_suspend_default_enter(suspend_state_t suspend_state)
+{
+	cpu_do_idle();
+	return 0;
+}
+
+static int shmobile_suspend_begin(suspend_state_t state)
+{
+	disable_hlt();
+	return 0;
+}
+
+static void shmobile_suspend_end(void)
+{
+	enable_hlt();
+}
+
+struct platform_suspend_ops shmobile_suspend_ops = {
+	.begin		= shmobile_suspend_begin,
+	.end		= shmobile_suspend_end,
+	.enter		= shmobile_suspend_default_enter,
+	.valid		= suspend_valid_only_mem,
+};
+
+static int __init shmobile_suspend_init(void)
+{
+	suspend_set_ops(&shmobile_suspend_ops);
+	return 0;
+}
+late_initcall(shmobile_suspend_init);
