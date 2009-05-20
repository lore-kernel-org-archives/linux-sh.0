From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 May 2009 13:55:02 +0000
Subject: [PATCH] sh: CONFIG_SH_CLK_DISABLE_LEGACY
Message-Id: <20090520135502.7742.12748.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Invert legacy kconfig logic in clkfwk branch. Instead of
building clock-cpg.c if CONFIG_SH_CLK_CPG_LEGACY is set,
let CONFIG_SH_CLK_DISABLE_LEGACY be no by default and let
upgraded processors use select to disable the legacy code.
While at it, put clock-cpg.c code in clock.c and wrap it
in ifdefs to only build if CONFIG_SH_CLK_DISABLE_LEGACY
is set to no.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                |    5 +--
 arch/sh/kernel/cpu/Makefile    |    1 
 arch/sh/kernel/cpu/clock-cpg.c |   60 ---------------------------------------
 arch/sh/kernel/cpu/clock.c     |   61 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 63 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-05-20 21:40:26.000000000 +0900
@@ -398,6 +398,7 @@ config CPU_SUBTYPE_SH7785
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
+	select SH_CLK_DISABLE_LEGACY
 
 config CPU_SUBTYPE_SH7786
 	bool "Support SH7786 processor"
@@ -513,8 +514,8 @@ config SH_PCLK_FREQ
 	  This is necessary for determining the reference clock value on
 	  platforms lacking an RTC.
 
-config SH_CLK_CPG_LEGACY
-	def_bool y if !CPU_SUBTYPE_SH7785
+config SH_CLK_DISABLE_LEGACY
+	def_bool n
 
 config SH_CLK_MD
 	int "CPU Mode Pin Setting"
--- 0001/arch/sh/kernel/cpu/Makefile
+++ work/arch/sh/kernel/cpu/Makefile	2009-05-20 21:39:39.000000000 +0900
@@ -17,6 +17,5 @@ obj-$(CONFIG_ARCH_SHMOBILE)	+= shmobile/
 
 obj-$(CONFIG_UBC_WAKEUP)	+= ubc.o
 obj-$(CONFIG_SH_ADC)		+= adc.o
-obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 
 obj-y	+= irq/ init.o clock.o
--- 0001/arch/sh/kernel/cpu/clock-cpg.c
+++ /dev/null	2009-05-19 12:17:43.197032281 +0900
@@ -1,60 +0,0 @@
-#include <linux/clk.h>
-#include <linux/compiler.h>
-#include <asm/clock.h>
-
-static struct clk master_clk = {
-	.name		= "master_clk",
-	.flags		= CLK_ENABLE_ON_INIT,
-	.rate		= CONFIG_SH_PCLK_FREQ,
-};
-
-static struct clk peripheral_clk = {
-	.name		= "peripheral_clk",
-	.parent		= &master_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-};
-
-static struct clk bus_clk = {
-	.name		= "bus_clk",
-	.parent		= &master_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-};
-
-static struct clk cpu_clk = {
-	.name		= "cpu_clk",
-	.parent		= &master_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-};
-
-/*
- * The ordering of these clocks matters, do not change it.
- */
-static struct clk *onchip_clocks[] = {
-	&master_clk,
-	&peripheral_clk,
-	&bus_clk,
-	&cpu_clk,
-};
-
-int __init __deprecated cpg_clk_init(void)
-{
-	int i, ret = 0;
-
-	for (i = 0; i < ARRAY_SIZE(onchip_clocks); i++) {
-		struct clk *clk = onchip_clocks[i];
-		arch_init_clk_ops(&clk->ops, i);
-		if (clk->ops)
-			ret |= clk_register(clk);
-	}
-
-	return ret;
-}
-
-/*
- * Placeholder for compatability, until the lazy CPUs do this
- * on their own.
- */
-int __init __weak arch_clk_init(void)
-{
-	return cpg_clk_init();
-}
--- 0001/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2009-05-20 21:39:28.000000000 +0900
@@ -585,3 +585,64 @@ err_out:
 	return err;
 }
 late_initcall(clk_debugfs_init);
+
+#ifndef CONFIG_SH_CLK_DISABLE_LEGACY
+
+static struct clk master_clk = {
+	.name		= "master_clk",
+	.flags		= CLK_ENABLE_ON_INIT,
+	.rate		= CONFIG_SH_PCLK_FREQ,
+};
+
+static struct clk peripheral_clk = {
+	.name		= "peripheral_clk",
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+static struct clk bus_clk = {
+	.name		= "bus_clk",
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+static struct clk cpu_clk = {
+	.name		= "cpu_clk",
+	.parent		= &master_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+/*
+ * The ordering of these clocks matters, do not change it.
+ */
+static struct clk *onchip_clocks[] = {
+	&master_clk,
+	&peripheral_clk,
+	&bus_clk,
+	&cpu_clk,
+};
+
+int __init __deprecated cpg_clk_init(void)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < ARRAY_SIZE(onchip_clocks); i++) {
+		struct clk *clk = onchip_clocks[i];
+		arch_init_clk_ops(&clk->ops, i);
+		if (clk->ops)
+			ret |= clk_register(clk);
+	}
+
+	return ret;
+}
+
+/*
+ * Placeholder for compatability, until the lazy CPUs do this
+ * on their own.
+ */
+int __init __weak arch_clk_init(void)
+{
+	return cpg_clk_init();
+}
+
+#endif /* CONFIG_SH_CLK_DISABLE_LEGACY */
