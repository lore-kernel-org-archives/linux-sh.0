From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 23 Feb 2009 05:46:55 +0000
Subject: [PATCH 4/6] sh: sh7786 clock support
Message-Id: <uhc2ld2h3.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch implements clock setting for the sh7786 processor.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
> Paul
Please check this stupid patch carefully.
Don't believe my code please.

 arch/sh/include/cpu-sh4/cpu/freq.h     |    4 +
 arch/sh/kernel/cpu/sh4a/Makefile       |    1 +
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |  148 ++++++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/kernel/cpu/sh4a/clock-sh7786.c

diff --git a/arch/sh/include/cpu-sh4/cpu/freq.h b/arch/sh/include/cpu-sh4/cpu/freq.h
index c23af81..749d1c4 100644
--- a/arch/sh/include/cpu-sh4/cpu/freq.h
+++ b/arch/sh/include/cpu-sh4/cpu/freq.h
@@ -29,6 +29,10 @@
 #define FRQCR0			0xffc80000
 #define FRQCR1			0xffc80004
 #define FRQMR1			0xffc80014
+#elif defined(CONFIG_CPU_SUBTYPE_SH7786)
+#define FRQCR0			0xffc40000
+#define FRQCR1			0xffc40004
+#define FRQMR1			0xffc40014
 #elif defined(CONFIG_CPU_SUBTYPE_SHX3)
 #define FRQCR			0xffc00014
 #else
diff --git a/arch/sh/kernel/cpu/sh4a/Makefile b/arch/sh/kernel/cpu/sh4a/Makefile
index 282ded1..1a92361 100644
--- a/arch/sh/kernel/cpu/sh4a/Makefile
+++ b/arch/sh/kernel/cpu/sh4a/Makefile
@@ -22,6 +22,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7763)	:= clock-sh7763.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7770)	:= clock-sh7770.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7780)	:= clock-sh7780.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7785)	:= clock-sh7785.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7786)	:= clock-sh7786.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7722.o
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
new file mode 100644
index 0000000..a0a6893
--- /dev/null
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -0,0 +1,148 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+ *
+ * SH7786 support for the clock framework
+ *
+ * Copyright (C) 2008 Renesas Solutions Corp.
+ * Kuninori Morimoto <morimoto.kuninori@renesas.com>
+ *
+ * Based on SH7785
+ *  Copyright (C) 2007  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+static int ifc_divisors[] = { 1, 2, 4, 1 };
+static int sfc_divisors[] = { 1, 1, 4, 1 };
+static int bfc_divisors[] = { 1, 1, 1, 1, 1, 12, 16, 1,
+			     24, 32, 1, 1, 1, 1, 1, 1 };
+static int mfc_divisors[] = { 1, 1, 4, 1 };
+static int pfc_divisors[] = { 1, 1, 1, 1, 1, 1, 16, 1,
+			      24, 32, 1, 48, 1, 1, 1, 1 };
+
+static void master_clk_init(struct clk *clk)
+{
+	clk->rate *= pfc_divisors[ctrl_inl(FRQMR1) & 0x000f];
+}
+
+static struct clk_ops sh7786_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inl(FRQMR1) & 0x000f);
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh7786_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQMR1) >> 16) & 0x000f);
+	clk->rate = clk->parent->rate / bfc_divisors[idx];
+}
+
+static struct clk_ops sh7786_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQMR1) >> 28) & 0x0003);
+	clk->rate = clk->parent->rate / ifc_divisors[idx];
+}
+
+static struct clk_ops sh7786_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh7786_clk_ops[] = {
+	&sh7786_master_clk_ops,
+	&sh7786_module_clk_ops,
+	&sh7786_bus_clk_ops,
+	&sh7786_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh7786_clk_ops))
+		*ops = sh7786_clk_ops[idx];
+}
+
+static void shyway_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQMR1) >> 20) & 0x0003);
+	clk->rate = clk->parent->rate / sfc_divisors[idx];
+}
+
+static struct clk_ops sh7786_shyway_clk_ops = {
+	.recalc		= shyway_clk_recalc,
+};
+
+static struct clk sh7786_shyway_clk = {
+	.name		= "shyway_clk",
+	.flags		= CLK_ALWAYS_ENABLED,
+	.ops		= &sh7786_shyway_clk_ops,
+};
+
+static void ddr_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQMR1) >> 12) & 0x0003);
+	clk->rate = clk->parent->rate / mfc_divisors[idx];
+}
+
+static struct clk_ops sh7786_ddr_clk_ops = {
+	.recalc		= ddr_clk_recalc,
+};
+
+static struct clk sh7786_ddr_clk = {
+	.name		= "ddr_clk",
+	.flags		= CLK_ALWAYS_ENABLED,
+	.ops		= &sh7786_ddr_clk_ops,
+};
+
+/*
+ * Additional SH7786-specific on-chip clocks that aren't already part of the
+ * clock framework
+ */
+static struct clk *sh7786_onchip_clocks[] = {
+	&sh7786_shyway_clk,
+	&sh7786_ddr_clk,
+};
+
+static int __init sh7786_clk_init(void)
+{
+	struct clk *clk = clk_get(NULL, "master_clk");
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sh7786_onchip_clocks); i++) {
+		struct clk *clkp = sh7786_onchip_clocks[i];
+
+		clkp->parent = clk;
+		clk_register(clkp);
+		clk_enable(clkp);
+	}
+
+	/*
+	 * Now that we have the rest of the clocks registered, we need to
+	 * force the parent clock to propagate so that these clocks will
+	 * automatically figure out their rate. We cheat by handing the
+	 * parent clock its current rate and forcing child propagation.
+	 */
+	clk_set_rate(clk, clk_get_rate(clk));
+
+	clk_put(clk);
+
+	return 0;
+}
+arch_initcall(sh7786_clk_init);
-- 
1.5.6.3

