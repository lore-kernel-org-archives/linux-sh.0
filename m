From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 May 2010 14:21:24 +0000
Subject: [PATCH 01/02] ARM: mach-shmobile: Use shared clock framework
Message-Id: <20100512142124.28459.11232.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Teach SH-Mobile ARM how to make use of the shared SH clock
framework. This commit is one atomic switch that dumps the
local hackery and instead links in the shared clock framework
code in drivers/sh. A few local functions are kept in clock.c.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig               |    3 +
 arch/arm/mach-shmobile/Makefile              |    2 -
 arch/arm/mach-shmobile/clock-sh7367.c        |   36 ---------------------
 arch/arm/mach-shmobile/clock.c               |   44 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 drivers/sh/Makefile                          |    2 -
 6 files changed, 52 insertions(+), 37 deletions(-)

--- 0010/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-05-12 19:44:46.000000000 +0900
@@ -102,4 +102,7 @@ config SH_TIMER_TMU
 
 endmenu
 
+config SH_CLK_CPG
+	bool
+
 endif
--- 0005/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-05-12 19:21:36.000000000 +0900
@@ -3,7 +3,7 @@
 #
 
 # Common objects
-obj-y				:= timer.o console.o memory.o
+obj-y				:= timer.o console.o memory.o clock.o
 
 # CPU objects
 obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
--- 0001/arch/arm/mach-shmobile/clock-sh7367.c
+++ work/arch/arm/mach-shmobile/clock-sh7367.c	2010-05-12 19:21:36.000000000 +0900
@@ -21,43 +21,9 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
-
-struct clk {
-	const char *name;
-	unsigned long rate;
-};
-
+#include <linux/sh_clk.h>
 #include <asm/clkdev.h>
 
-int __clk_get(struct clk *clk)
-{
-	return 1;
-}
-EXPORT_SYMBOL(__clk_get);
-
-void __clk_put(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(__clk_put);
-
-
-int clk_enable(struct clk *clk)
-{
-	return 0;
-}
-EXPORT_SYMBOL(clk_enable);
-
-void clk_disable(struct clk *clk)
-{
-}
-EXPORT_SYMBOL(clk_disable);
-
-unsigned long clk_get_rate(struct clk *clk)
-{
-	return clk ? clk->rate : 0;
-}
-EXPORT_SYMBOL(clk_get_rate);
-
 /* a static peripheral clock for now - enough to get sh-sci working */
 static struct clk peripheral_clk = {
 	.name	    = "peripheral_clk",
--- /dev/null
+++ work/arch/arm/mach-shmobile/clock.c	2010-05-12 19:21:37.000000000 +0900
@@ -0,0 +1,44 @@
+/*
+ * SH-Mobile Timer
+ *
+ * Copyright (C) 2010  Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/sh_clk.h>
+
+int __init clk_init(void)
+{
+	/* Kick the child clocks.. */
+	recalculate_root_clocks();
+
+	/* Enable the necessary init clocks */
+	clk_enable_init_clocks();
+
+	return 0;
+}
+
+int __clk_get(struct clk *clk)
+{
+	return 1;
+}
+EXPORT_SYMBOL(__clk_get);
+
+void __clk_put(struct clk *clk)
+{
+}
+EXPORT_SYMBOL(__clk_put);
--- 0005/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-05-12 19:21:36.000000000 +0900
@@ -4,6 +4,8 @@
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
 
+extern int clk_init(void);
+
 /* allocate contiguous memory chunk and fill in struct resource */
 extern int platform_resource_setup_memory(struct platform_device *pdev,
 					  char *name, unsigned long memsize);
--- 0011/drivers/sh/Makefile
+++ work/drivers/sh/Makefile	2010-05-12 19:21:36.000000000 +0900
@@ -4,6 +4,6 @@
 obj-$(CONFIG_SUPERHYWAY)	+= superhyway/
 obj-$(CONFIG_MAPLE)		+= maple/
 obj-$(CONFIG_GENERIC_GPIO)	+= pfc.o
-obj-$(CONFIG_SUPERH)		+= clk.o
 obj-$(CONFIG_SH_CLK_CPG)	+= clk-cpg.o
+obj-y				+= clk.o
 obj-y				+= intc.o
