From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Mar 2010 07:08:24 +0000
Subject: [PATCH 05/06] ARM: mach-shmobile: SH-Mobile ARM specific clock code
Message-Id: <20100325070824.24148.19947.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SH-Mobile ARM specific clock framework setup
code and update the Kconfig and Makefile. This 
together with the clock code in drivers/sh is
the new clock framework base for SH-Mobile ARM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig  |    3 +++
 arch/arm/mach-shmobile/Makefile |    5 +++++
 arch/arm/mach-shmobile/clock.c  |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2010-03-25 13:41:18.000000000 +0900
@@ -81,4 +81,7 @@ config SH_TIMER_CMT
 
 endmenu
 
+config SH_CLK_CPG
+	def_bool n
+
 endif
--- 0003/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-03-25 13:42:09.000000000 +0900
@@ -11,6 +11,11 @@ obj-$(CONFIG_ARCH_SH7377)	+= setup-sh737
 obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
 
 # Clock framework
+clk-$(CONFIG_ARCH_SH7367)	++clk-$(CONFIG_ARCH_SH7377)	++clk-$(CONFIG_ARCH_SH7372)	++obj-$(CONFIG_SH_CLK_CPG)	+= $(clk-y) clock.o
+
 obj-$(CONFIG_COMMON_CLKDEV)	+= clock-sh7367.o
 
 # Pinmux setup
--- /dev/null
+++ work/arch/arm/mach-shmobile/clock.c	2010-03-25 13:43:39.000000000 +0900
@@ -0,0 +1,33 @@
+/*
+ * SH-Mobile Clock Framework
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
