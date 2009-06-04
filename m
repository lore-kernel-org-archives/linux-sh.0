From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Jun 2009 07:35:25 +0000
Subject: [PATCH] sh: sh7366 clock framework rewrite
Message-Id: <20090604073525.32230.32489.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch rewrites the sh7366 clock framework code.
The new code makes use of the recently merged div4,
div6 and mstp32 helper code. Both extal and dll are
supported as input clocks to the pll.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    2 
 arch/sh/kernel/cpu/sh4a/Makefile       |    2 
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |  211 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   42 ------
 4 files changed, 214 insertions(+), 43 deletions(-)

--- 0014/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-06-04 13:19:11.000000000 +0900
@@ -516,7 +516,7 @@ config SH_CLK_CPG
 
 config SH_CLK_CPG_LEGACY
 	depends on SH_CLK_CPG
-	def_bool y if !CPU_SUBTYPE_SH7785 && !CPU_SUBTYPE_SH7723 && !CPU_SUBTYPE_SH7724 && !CPU_SUBTYPE_SH7343
+	def_bool y if !CPU_SUBTYPE_SH7785 && !CPU_SUBTYPE_SH7723 && !CPU_SUBTYPE_SH7724 && !CPU_SUBTYPE_SH7343 && !CPU_SUBTYPE_SH7366
 
 config SH_CLK_MD
 	int "CPU Mode Pin Setting"
--- 0014/arch/sh/kernel/cpu/sh4a/Makefile
+++ work/arch/sh/kernel/cpu/sh4a/Makefile	2009-06-04 13:19:37.000000000 +0900
@@ -28,7 +28,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= cl
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7724.o
-clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7722.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7366.o
 clock-$(CONFIG_CPU_SUBTYPE_SHX3)	:= clock-shx3.o
 
 # Pinmux setup
--- /dev/null
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7366.c	2009-06-04 13:15:07.000000000 +0900
@@ -0,0 +1,211 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+ *
+ * SH7366 clock framework support
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
+/* SH7366 registers */
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
+	unsigned long div = 1;
+
+	if (__raw_readl(PLLCR) & 0x4000)
+		mult = (((__raw_readl(FRQCR) >> 24) & 0x1f) + 1);
+	else
+		div = 2;
+
+	return (clk->parent->rate * mult) / div;
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
+	[DIV4_I] = DIV4("cpu_clk", FRQCR, 20, 0x1fef, CLK_ENABLE_ON_INIT),
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
+	/* See page 52 of Datasheet V0.40: Overview -> Block Diagram */
+	MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, CLK_ENABLE_ON_INIT),
+	MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, CLK_ENABLE_ON_INIT),
+	MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, CLK_ENABLE_ON_INIT),
+	MSTP("rsmem0", &div4_clks[DIV4_SH], MSTPCR0, 28, CLK_ENABLE_ON_INIT),
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
+	MSTP("msiof0", &div4_clks[DIV4_P], MSTPCR0, 2, 0),
+	MSTP("sbr0", &div4_clks[DIV4_P], MSTPCR0, 1, 0),
+
+	MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0),
+
+	MSTP("icb0", &div4_clks[DIV4_P], MSTPCR2, 27, 0),
+	MSTP("meram0", &div4_clks[DIV4_P], MSTPCR2, 26, 0),
+	MSTP("dacy1", &div4_clks[DIV4_P], MSTPCR2, 24, 0),
+	MSTP("dacy0", &div4_clks[DIV4_P], MSTPCR2, 23, 0),
+	MSTP("tsif0", &div4_clks[DIV4_P], MSTPCR2, 22, 0),
+	MSTP("sdhi0", &div4_clks[DIV4_P], MSTPCR2, 18, 0),
+	MSTP("mmcif0", &div4_clks[DIV4_P], MSTPCR2, 17, 0),
+	MSTP("usbf0", &div4_clks[DIV4_P], MSTPCR2, 11, 0),
+	MSTP("siu0", &div4_clks[DIV4_B], MSTPCR2, 9, 0),
+	MSTP("veu1", &div4_clks[DIV4_B], MSTPCR2, 7, CLK_ENABLE_ON_INIT),
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
--- 0014/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2009-06-04 13:18:49.000000000 +0900
@@ -1,7 +1,7 @@
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7722.c
  *
- * SH7722 & SH7366 support for the clock framework
+ * SH7722 support for the clock framework
  *
  * Copyright (c) 2006-2007 Nomad Global Solutions Inc
  * Based on code for sh7343 by Paul Mundt
@@ -654,46 +654,6 @@ static struct clk sh7722_mstpcr_clocks[]
 	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
 	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
 #endif
-#if defined(CONFIG_CPU_SUBTYPE_SH7366)
-	/* See page 52 of Datasheet V0.40: Overview -> Block Diagram */
-	MSTPCR("tlb0", "cpu_clk", 0, 31, 0),
-	MSTPCR("ic0", "cpu_clk", 0, 30, 0),
-	MSTPCR("oc0", "cpu_clk", 0, 29, 0),
-	MSTPCR("rsmem0", "sh_clk", 0, 28, CLK_ENABLE_ON_INIT),
-	MSTPCR("xymem0", "cpu_clk", 0, 26, CLK_ENABLE_ON_INIT),
-	MSTPCR("intc30", "peripheral_clk", 0, 23, 0),
-	MSTPCR("intc0", "peripheral_clk", 0, 22, 0),
-	MSTPCR("dmac0", "bus_clk", 0, 21, 0),
-	MSTPCR("sh0", "sh_clk", 0, 20, 0),
-	MSTPCR("hudi0", "peripheral_clk", 0, 19, 0),
-	MSTPCR("ubc0", "cpu_clk", 0, 17, 0),
-	MSTPCR("tmu0", "peripheral_clk", 0, 15, 0),
-	MSTPCR("cmt0", "r_clk", 0, 14, 0),
-	MSTPCR("rwdt0", "r_clk", 0, 13, 0),
-	MSTPCR("flctl0", "peripheral_clk", 0, 10, 0),
-	MSTPCR("scif0", "peripheral_clk", 0, 7, 0),
-	MSTPCR("scif1", "bus_clk", 0, 6, 0),
-	MSTPCR("scif2", "bus_clk", 0, 5, 0),
-	MSTPCR("msiof0", "peripheral_clk", 0, 2, 0),
-	MSTPCR("sbr0", "peripheral_clk", 0, 1, 0),
-	MSTPCR("i2c0", "peripheral_clk", 1, 9, 0),
-	MSTPCR("icb0", "bus_clk", 2, 27, 0),
-	MSTPCR("meram0", "sh_clk", 2, 26, 0),
-	MSTPCR("dacc0", "peripheral_clk", 2, 24, 0),
-	MSTPCR("dacy0", "peripheral_clk", 2, 23, 0),
-	MSTPCR("tsif0", "bus_clk", 2, 22, 0),
-	MSTPCR("sdhi0", "bus_clk", 2, 18, 0),
-	MSTPCR("mmcif0", "bus_clk", 2, 17, 0),
-	MSTPCR("usb0", "bus_clk", 2, 11, 0),
-	MSTPCR("siu0", "bus_clk", 2, 8, 0),
-	MSTPCR("veu1", "bus_clk", 2, 7, CLK_ENABLE_ON_INIT),
-	MSTPCR("vou0", "bus_clk", 2, 5, 0),
-	MSTPCR("beu0", "bus_clk", 2, 4, 0),
-	MSTPCR("ceu0", "bus_clk", 2, 3, 0),
-	MSTPCR("veu0", "bus_clk", 2, 2, CLK_ENABLE_ON_INIT),
-	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
-	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
-#endif
 };
 
 static struct clk *sh7722_clocks[] = {
