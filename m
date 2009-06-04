From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Jun 2009 07:32:11 +0000
Subject: [PATCH] sh: sh7343 clock framework rewrite
Message-Id: <20090604073211.32188.76225.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch rewrites the sh7343 clock framework code.
The new code makes use of the recently merged div4,
div6 and mstp32 helper code. Both extal and dll are
supported as input clocks to the pll.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    2 
 arch/sh/kernel/cpu/sh4a/Makefile       |    2 
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |  211 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   33 -----
 4 files changed, 214 insertions(+), 34 deletions(-)

--- 0012/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-06-04 12:49:54.000000000 +0900
@@ -516,7 +516,7 @@ config SH_CLK_CPG
 
 config SH_CLK_CPG_LEGACY
 	depends on SH_CLK_CPG
-	def_bool y if !CPU_SUBTYPE_SH7785 && !CPU_SUBTYPE_SH7723 && !CPU_SUBTYPE_SH7724
+	def_bool y if !CPU_SUBTYPE_SH7785 && !CPU_SUBTYPE_SH7723 && !CPU_SUBTYPE_SH7724 && !CPU_SUBTYPE_SH7343
 
 config SH_CLK_MD
 	int "CPU Mode Pin Setting"
--- 0012/arch/sh/kernel/cpu/sh4a/Makefile
+++ work/arch/sh/kernel/cpu/sh4a/Makefile	2009-06-04 12:49:54.000000000 +0900
@@ -24,7 +24,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7770)	:= cl
 clock-$(CONFIG_CPU_SUBTYPE_SH7780)	:= clock-sh7780.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7785)	:= clock-sh7785.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7786)	:= clock-sh7786.o
-clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7722.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7343.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7724.o
--- /dev/null
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7343.c	2009-06-04 12:49:54.000000000 +0900
@@ -0,0 +1,211 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+ *
+ * SH7343 clock framework support
+ *
+ * Copyright (C) 2009 Magnus Damm
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <asm/clock.h>
+
+/* SH7343 registers */
+#define FRQCR		0xa4150000
+#define VCLKCR		0xa4150004
+#define SCLKACR		0xa4150008
+#define SCLKBCR		0xa415000c
+#define PLLCR		0xa4150024
+#define MSTPCR0		0xa4150030
+#define MSTPCR1		0xa4150034
+#define MSTPCR2		0xa4150038
+#define DLLFRQ		0xa4150050
+
+/* Fixed 32 KHz root clock for RTC and Power Management purposes */
+static struct clk r_clk = {
+	.name           = "rclk",
+	.id             = -1,
+	.rate           = 32768,
+};
+
+/*
+ * Default rate for the root input clock, reset this with clk_set_rate()
+ * from the platform code.
+ */
+struct clk extal_clk = {
+	.name		= "extal",
+	.id		= -1,
+	.rate		= 33333333,
+};
+
+/* The dll block multiplies the 32khz r_clk, may be used instead of extal */
+static unsigned long dll_recalc(struct clk *clk)
+{
+	unsigned long mult;
+
+	if (__raw_readl(PLLCR) & 0x1000)
+		mult = __raw_readl(DLLFRQ);
+	else
+		mult = 0;
+
+	return clk->parent->rate * mult;
+}
+
+static struct clk_ops dll_clk_ops = {
+	.recalc		= dll_recalc,
+};
+
+static struct clk dll_clk = {
+	.name           = "dll_clk",
+	.id             = -1,
+	.ops		= &dll_clk_ops,
+	.parent		= &r_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+static unsigned long pll_recalc(struct clk *clk)
+{
+	unsigned long mult = 1;
+
+	if (__raw_readl(PLLCR) & 0x4000)
+		mult = (((__raw_readl(FRQCR) >> 24) & 0x1f) + 1);
+
+	return clk->parent->rate * mult;
+}
+
+static struct clk_ops pll_clk_ops = {
+	.recalc		= pll_recalc,
+};
+
+static struct clk pll_clk = {
+	.name		= "pll_clk",
+	.id		= -1,
+	.ops		= &pll_clk_ops,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+struct clk *main_clks[] = {
+	&r_clk,
+	&extal_clk,
+	&dll_clk,
+	&pll_clk,
+};
+
+static int multipliers[] = { 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1 };
+static int divisors[] = { 1, 3, 2, 5, 3, 4, 5, 6, 8, 10, 12, 16, 20 };
+
+static struct clk_div_mult_table div4_table = {
+	.divisors = divisors,
+	.nr_divisors = ARRAY_SIZE(divisors),
+	.multipliers = multipliers,
+	.nr_multipliers = ARRAY_SIZE(multipliers),
+};
+
+enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_B3, DIV4_P,
+       DIV4_SIUA, DIV4_SIUB, DIV4_NR };
+
+#define DIV4(_str, _reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4("cpu_clk", FRQCR, 20, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_U] = DIV4("umem_clk", FRQCR, 16, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4("shyway_clk", FRQCR, 12, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4("bus_clk", FRQCR, 8, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_B3] = DIV4("b3_clk", FRQCR, 4, 0x1fff, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4("peripheral_clk", FRQCR, 0, 0x1fff, 0),
+	[DIV4_SIUA] = DIV4("siua_clk", SCLKACR, 0, 0x1fff, 0),
+	[DIV4_SIUB] = DIV4("siub_clk", SCLKBCR, 0, 0x1fff, 0),
+};
+
+struct clk div6_clks[] = {
+	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
+};
+
+#define MSTP(_str, _parent, _reg, _bit, _flags) \
+  SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _flags)
+
+static struct clk mstp_clks[] = {
+	MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
+	MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
+	MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
+	MSTP("uram0", &div4_clks[DIV4_U], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
+	MSTP("xymem0", &div4_clks[DIV4_B], MSTPCR0, 26, CLK_ENABLE_ON_INIT),
+	MSTP("intc3", &div4_clks[DIV4_P], MSTPCR0, 23, 0),
+	MSTP("intc0", &div4_clks[DIV4_P], MSTPCR0, 22, 0),
+	MSTP("dmac0", &div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	MSTP("sh0", &div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	MSTP("hudi0", &div4_clks[DIV4_P], MSTPCR0, 19, 0),
+	MSTP("ubc0", &div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	MSTP("tmu0", &div4_clks[DIV4_P], MSTPCR0, 15, 0),
+	MSTP("cmt0", &r_clk, MSTPCR0, 14, 0),
+	MSTP("rwdt0", &r_clk, MSTPCR0, 13, 0),
+	MSTP("mfi0", &div4_clks[DIV4_P], MSTPCR0, 11, 0),
+	MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0),
+	MSTP("scif0", &div4_clks[DIV4_P], MSTPCR0, 7, 0),
+	MSTP("scif1", &div4_clks[DIV4_P], MSTPCR0, 6, 0),
+	MSTP("scif2", &div4_clks[DIV4_P], MSTPCR0, 5, 0),
+	MSTP("scif3", &div4_clks[DIV4_P], MSTPCR0, 4, 0),
+	MSTP("sio0", &div4_clks[DIV4_P], MSTPCR0, 3, 0),
+	MSTP("siof0", &div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	MSTP("siof1", &div4_clks[DIV4_P], MSTPCR0, 1, 0),
+
+	MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
+	MSTP("i2c1", &div4_clks[DIV4_P], MSTPCR1, 8, 0),
+
+	MSTP("tpu0", &div4_clks[DIV4_P], MSTPCR2, 25, 0),
+	MSTP("irda0", &div4_clks[DIV4_P], MSTPCR2, 24, 0),
+	MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
+	MSTP("mmcif0", &div4_clks[DIV4_P], MSTPCR2, 17, 0),
+	MSTP("sim0", &div4_clks[DIV4_P], MSTPCR2, 16, 0),
+	MSTP("keysc0", &r_clk, MSTPCR2, 14, 0),
+	MSTP("tsif0", &div4_clks[DIV4_P], MSTPCR2, 13, 0),
+	MSTP("s3d40", &div4_clks[DIV4_P], MSTPCR2, 12, 0),
+	MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
+	MSTP("siu0", &div4_clks[DIV4_B], MSTPCR2, 8, 0),
+	MSTP("jpu0", &div4_clks[DIV4_B], MSTPCR2, 6, CLK_ENABLE_ON_INIT),
+	MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0),
+	MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0),
+	MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0),
+	MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, CLK_ENABLE_ON_INIT),
+	MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, CLK_ENABLE_ON_INIT),
+	MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0),
+};
+
+int __init arch_clk_init(void)
+{
+	int k, ret = 0;
+
+	/* autodetect extal or dll configuration */
+	if (__raw_readl(PLLCR) & 0x1000)
+		pll_clk.parent = &dll_clk;
+	else
+		pll_clk.parent = &extal_clk;
+
+	for (k = 0; !ret && (k < ARRAY_SIZE(main_clks)); k++)
+		ret = clk_register(main_clks[k]);
+
+	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
+
+	if (!ret)
+		ret = sh_clk_div6_register(div6_clks, ARRAY_SIZE(div6_clks));
+
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+
+	return ret;
+}
--- 0012/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2009-06-04 12:50:59.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7722.c
  *
- * SH7343, SH7722 & SH7366 support for the clock framework
+ * SH7722 & SH7366 support for the clock framework
  *
  * Copyright (c) 2006-2007 Nomad Global Solutions Inc
  * Based on code for sh7343 by Paul Mundt
@@ -417,7 +417,6 @@ static struct clk_ops sh7722_frqcr_clk_o
 /*
  * clock ops methods for SIU A/B and IrDA clock
  */
-#ifndef CONFIG_CPU_SUBTYPE_SH7343
 static int sh7722_siu_set_rate(struct clk *clk, unsigned long rate, int algo_id)
 {
 	unsigned long r;
@@ -469,8 +468,6 @@ static struct clk_ops sh7722_siu_clk_ops
 	.disable = sh7722_siu_disable,
 };
 
-#endif /* CONFIG_CPU_SUBTYPE_SH7343 */
-
 static int sh7722_video_enable(struct clk *clk)
 {
 	unsigned long r;
@@ -542,7 +539,6 @@ static struct clk sh7722_r_clock = {
 	.rate = 32768,
 };
 
-#if !defined(CONFIG_CPU_SUBTYPE_SH7343)
 /*
  * these three clocks - SIU A, SIU B, IrDA - share the same clk_ops
  * methods of clk_ops determine which register they should access by
@@ -559,7 +555,6 @@ static struct clk sh7722_siu_b_clock = {
 	.arch_flags = SCLKBCR,
 	.ops = &sh7722_siu_clk_ops,
 };
-#endif /* CONFIG_CPU_SUBTYPE_SH7343 */
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7722)
 static struct clk sh7722_irda_clock = {
@@ -659,30 +654,6 @@ static struct clk sh7722_mstpcr_clocks[]
 	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
 	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
 #endif
-#if defined(CONFIG_CPU_SUBTYPE_SH7343)
-	MSTPCR("uram0", "umem_clk", 0, 28, CLK_ENABLE_ON_INIT),
-	MSTPCR("xymem0", "bus_clk", 0, 26, CLK_ENABLE_ON_INIT),
-	MSTPCR("tmu0", "peripheral_clk", 0, 15, 0),
-	MSTPCR("cmt0", "r_clk", 0, 14, 0),
-	MSTPCR("rwdt0", "r_clk", 0, 13, 0),
-	MSTPCR("scif0", "peripheral_clk", 0, 7, 0),
-	MSTPCR("scif1", "peripheral_clk", 0, 6, 0),
-	MSTPCR("scif2", "peripheral_clk", 0, 5, 0),
-	MSTPCR("scif3", "peripheral_clk", 0, 4, 0),
-	MSTPCR("i2c0", "peripheral_clk", 1, 9, 0),
-	MSTPCR("i2c1", "peripheral_clk", 1, 8, 0),
-	MSTPCR("sdhi0", "peripheral_clk", 2, 18, 0),
-	MSTPCR("keysc0", "r_clk", 2, 14, 0),
-	MSTPCR("usbf0", "peripheral_clk", 2, 11, 0),
-	MSTPCR("siu0", "bus_clk", 2, 8, 0),
-	MSTPCR("jpu0", "bus_clk", 2, 6, CLK_ENABLE_ON_INIT),
-	MSTPCR("vou0", "bus_clk", 2, 5, 0),
-	MSTPCR("beu0", "bus_clk", 2, 4, 0),
-	MSTPCR("ceu0", "bus_clk", 2, 3, 0),
-	MSTPCR("veu0", "bus_clk", 2, 2, CLK_ENABLE_ON_INIT),
-	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
-	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
-#endif
 #if defined(CONFIG_CPU_SUBTYPE_SH7366)
 	/* See page 52 of Datasheet V0.40: Overview -> Block Diagram */
 	MSTPCR("tlb0", "cpu_clk", 0, 31, 0),
@@ -730,10 +701,8 @@ static struct clk *sh7722_clocks[] = {
 	&sh7722_sh_clock,
 	&sh7722_peripheral_clock,
 	&sh7722_sdram_clock,
-#if !defined(CONFIG_CPU_SUBTYPE_SH7343)
 	&sh7722_siu_a_clock,
 	&sh7722_siu_b_clock,
-#endif
 #if defined(CONFIG_CPU_SUBTYPE_SH7722)
 	&sh7722_irda_clock,
 #endif
