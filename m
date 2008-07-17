From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jul 2008 10:02:23 +0000
Subject: [PATCH] sh: Merge sh7343 and sh7722 clock code
Message-Id: <20080717100223.19585.30348.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This code makes sh7343 share the sh7722 clock code. Instead of just using
the good and very old sh7343 clock implmentation, switch to the new MSTPCR
enabled clock code. SIU clocks are disabled on sh7343 for now.

With this change all SuperH Mobile devices now use the same clock code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/Makefile       |    2 
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |   99 --------------------------------
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   70 ++++++++++++----------
 3 files changed, 41 insertions(+), 130 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/Makefile
+++ work/arch/sh/kernel/cpu/sh4a/Makefile	2008-07-17 18:08:13.000000000 +0900
@@ -21,7 +21,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7763)	:= cl
 clock-$(CONFIG_CPU_SUBTYPE_SH7770)	:= clock-sh7770.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7780)	:= clock-sh7780.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7785)	:= clock-sh7785.o
-clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7343.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7722.o
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ /dev/null	2008-04-25 12:00:41.699005639 +0900
@@ -1,99 +0,0 @@
-/*
- * arch/sh/kernel/cpu/sh4a/clock-sh7343.c
- *
- * SH7343/SH7722 support for the clock framework
- *
- *  Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <asm/clock.h>
-#include <asm/freq.h>
-
-/*
- * SH7343/SH7722 uses a common set of multipliers and divisors, so this
- * is quite simple..
- */
-static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
-static int divisors[] = { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16, 20 };
-
-#define pll_calc() (((ctrl_inl(FRQCR) >> 24) & 0x1f) + 1)
-
-static void master_clk_init(struct clk *clk)
-{
-	clk->parent = clk_get(NULL, "cpu_clk");
-}
-
-static void master_clk_recalc(struct clk *clk)
-{
-	int idx = (ctrl_inl(FRQCR) & 0x000f);
-	clk->rate *= clk->parent->rate * multipliers[idx] / divisors[idx];
-}
-
-static struct clk_ops sh7343_master_clk_ops = {
-	.init		= master_clk_init,
-	.recalc		= master_clk_recalc,
-};
-
-static void module_clk_init(struct clk *clk)
-{
-	clk->parent = NULL;
-	clk->rate = CONFIG_SH_PCLK_FREQ;
-}
-
-static struct clk_ops sh7343_module_clk_ops = {
-	.init		= module_clk_init,
-};
-
-static void bus_clk_init(struct clk *clk)
-{
-	clk->parent = clk_get(NULL, "cpu_clk");
-}
-
-static void bus_clk_recalc(struct clk *clk)
-{
-	int idx = (ctrl_inl(FRQCR) >> 8) & 0x000f;
-	clk->rate = clk->parent->rate * multipliers[idx] / divisors[idx];
-}
-
-static struct clk_ops sh7343_bus_clk_ops = {
-	.init		= bus_clk_init,
-	.recalc		= bus_clk_recalc,
-};
-
-static void cpu_clk_init(struct clk *clk)
-{
-	clk->parent = clk_get(NULL, "module_clk");
-	clk->flags |= CLK_RATE_PROPAGATES;
-	clk_set_rate(clk, clk_get_rate(clk));
-}
-
-static void cpu_clk_recalc(struct clk *clk)
-{
-	int idx = (ctrl_inl(FRQCR) >> 20) & 0x000f;
-	clk->rate = clk->parent->rate * pll_calc() *
-		multipliers[idx] / divisors[idx];
-}
-
-static struct clk_ops sh7343_cpu_clk_ops = {
-	.init		= cpu_clk_init,
-	.recalc		= cpu_clk_recalc,
-};
-
-static struct clk_ops *sh7343_clk_ops[] = {
-	&sh7343_master_clk_ops,
-	&sh7343_module_clk_ops,
-	&sh7343_bus_clk_ops,
-	&sh7343_cpu_clk_ops,
-};
-
-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
-{
-	if (idx < ARRAY_SIZE(sh7343_clk_ops))
-		*ops = sh7343_clk_ops[idx];
-}
--- 0004/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-07-17 18:18:02.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7722.c
  *
- * SH7722 & SH7366 support for the clock framework
+ * SH7343, SH7722, SH7723 & SH7366 support for the clock framework
  *
  * Copyright (c) 2006-2007 Nomad Global Solutions Inc
  * Based on code for sh7343 by Paul Mundt
@@ -413,6 +413,30 @@ static struct clk_ops sh7722_frqcr_clk_o
  *
  */
 
+#ifndef CONFIG_CPU_SUBTYPE_SH7343
+
+static int sh7722_siu_set_rate(struct clk *clk, unsigned long rate, int algo_id)
+{
+	unsigned long r;
+	int div;
+
+	r = ctrl_inl(clk->arch_flags);
+	div = sh7722_find_divisors(clk->parent->rate, rate);
+	if (div < 0)
+		return div;
+	r = (r & ~0xF) | div;
+	ctrl_outl(r, clk->arch_flags);
+	return 0;
+}
+
+static void sh7722_siu_recalc(struct clk *clk)
+{
+	unsigned long r;
+
+	r = ctrl_inl(clk->arch_flags);
+	clk->rate = clk->parent->rate * 2 / divisors2[r & 0xF];
+}
+
 static int sh7722_siu_start_stop(struct clk *clk, int enable)
 {
 	unsigned long r;
@@ -435,6 +459,15 @@ static void sh7722_siu_disable(struct cl
 	sh7722_siu_start_stop(clk, 0);
 }
 
+static struct clk_ops sh7722_siu_clk_ops = {
+	.recalc = sh7722_siu_recalc,
+	.set_rate = sh7722_siu_set_rate,
+	.enable = sh7722_siu_enable,
+	.disable = sh7722_siu_disable,
+};
+
+#endif /* CONFIG_CPU_SUBTYPE_SH7343 */
+
 static void sh7722_video_enable(struct clk *clk)
 {
 	unsigned long r;
@@ -471,35 +504,6 @@ static void sh7722_video_recalc(struct c
 	clk->rate = clk->parent->rate / ((r & 0x3F) + 1);
 }
 
-static int sh7722_siu_set_rate(struct clk *clk, unsigned long rate, int algo_id)
-{
-	unsigned long r;
-	int div;
-
-	r = ctrl_inl(clk->arch_flags);
-	div = sh7722_find_divisors(clk->parent->rate, rate);
-	if (div < 0)
-		return div;
-	r = (r & ~0xF) | div;
-	ctrl_outl(r, clk->arch_flags);
-	return 0;
-}
-
-static void sh7722_siu_recalc(struct clk *clk)
-{
-	unsigned long r;
-
-	r = ctrl_inl(clk->arch_flags);
-	clk->rate = clk->parent->rate * 2 / divisors2[r & 0xF];
-}
-
-static struct clk_ops sh7722_siu_clk_ops = {
-	.recalc = sh7722_siu_recalc,
-	.set_rate = sh7722_siu_set_rate,
-	.enable = sh7722_siu_enable,
-	.disable = sh7722_siu_disable,
-};
-
 static struct clk_ops sh7722_video_clk_ops = {
 	.recalc = sh7722_video_recalc,
 	.set_rate = sh7722_video_set_rate,
@@ -529,6 +533,9 @@ static struct clk sh7722_sdram_clock = {
 	.ops = &sh7722_frqcr_clk_ops,
 };
 
+
+#ifndef CONFIG_CPU_SUBTYPE_SH7343
+
 /*
  * these three clocks - SIU A, SIU B, IrDA - share the same clk_ops
  * methods of clk_ops determine which register they should access by
@@ -553,6 +560,7 @@ static struct clk sh7722_irda_clock = {
 	.ops = &sh7722_siu_clk_ops,
 };
 #endif
+#endif /* CONFIG_CPU_SUBTYPE_SH7343 */
 
 static struct clk sh7722_video_clock = {
 	.name = "video_clk",
@@ -673,11 +681,13 @@ static struct clk *sh7722_clocks[] = {
 	&sh7722_sh_clock,
 	&sh7722_peripheral_clock,
 	&sh7722_sdram_clock,
+#ifndef CONFIG_CPU_SUBTYPE_SH7343
 	&sh7722_siu_a_clock,
 	&sh7722_siu_b_clock,
 #if defined(CONFIG_CPU_SUBTYPE_SH7722)
 	&sh7722_irda_clock,
 #endif
+#endif
 	&sh7722_video_clock,
 };
 
