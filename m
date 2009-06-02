From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Jun 2009 10:34:59 +0000
Subject: [PATCH] sh: sh7724 clock framework rewrite
Message-Id: <20090602103459.13411.85023.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch contains a rewrite of the sh7724 clock
framework code. The new code makes use of the
recently merged div4, div6 and mstp32 helper code.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Untested due to lack of hardware.

 arch/sh/Kconfig                        |    2 
 arch/sh/kernel/cpu/sh4a/Makefile       |    2 
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   85 --------------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |  183 ++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+), 82 deletions(-)

--- 0006/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-06-02 19:01:47.000000000 +0900
@@ -516,7 +516,7 @@ config SH_CLK_CPG
 
 config SH_CLK_CPG_LEGACY
 	depends on SH_CLK_CPG
-	def_bool y if !CPU_SUBTYPE_SH7785 && !CPU_SUBTYPE_SH7723
+	def_bool y if !CPU_SUBTYPE_SH7785 && !CPU_SUBTYPE_SH7723 && !CPU_SUBTYPE_SH7724
 
 config SH_CLK_MD
 	int "CPU Mode Pin Setting"
--- 0006/arch/sh/kernel/cpu/sh4a/Makefile
+++ work/arch/sh/kernel/cpu/sh4a/Makefile	2009-06-02 19:01:19.000000000 +0900
@@ -27,7 +27,7 @@ clock-$(CONFIG_CPU_SUBTYPE_SH7786)	:= cl
 clock-$(CONFIG_CPU_SUBTYPE_SH7343)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7722)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7723)	:= clock-sh7723.o
-clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7722.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7724)	:= clock-sh7724.o
 clock-$(CONFIG_CPU_SUBTYPE_SH7366)	:= clock-sh7722.o
 clock-$(CONFIG_CPU_SUBTYPE_SHX3)	:= clock-shx3.o
 
--- 0006/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2009-06-02 19:21:14.000000000 +0900
@@ -130,11 +130,7 @@ static void adjust_clocks(int originate,
  * is quite simple..
  */
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7724)
-#define STCPLL(frqcr) ((((frqcr >> 24) & 0x3f) + 1) * 2)
-#else
 #define STCPLL(frqcr) (((frqcr >> 24) & 0x1f) + 1)
-#endif
 
 /*
  * Instead of having two separate multipliers/divisors set, like this:
@@ -145,11 +141,7 @@ static void adjust_clocks(int originate,
  * I created the divisors2 array, which is used to calculate rate like
  *   rate = parent * 2 / divisors2[ divisor ];
 */
-#if defined(CONFIG_CPU_SUBTYPE_SH7724)
-static int divisors2[] = { 4, 1, 8, 12, 16, 24, 32, 1, 48, 64, 72, 96, 1, 144 };
-#else
 static int divisors2[] = { 2, 3, 4, 5, 6, 8, 10, 12, 16, 20, 24, 32, 40 };
-#endif
 
 static unsigned long master_clk_recalc(struct clk *clk)
 {
@@ -171,17 +163,10 @@ static unsigned long module_clk_recalc(s
 	return clk->parent->rate / STCPLL(frqcr);
 }
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7724)
-#define MASTERDIVS	{ 12, 16, 24, 30, 32, 36, 48 }
-#define STCMASK		0x3f
-#define DIVCALC(div)	(div/2-1)
-#define FRQCRKICK	0x80000000
-#else
 #define MASTERDIVS	{ 2, 3, 4, 6, 8, 16 }
 #define STCMASK		0x1f
 #define DIVCALC(div)	(div-1)
 #define FRQCRKICK	0x00000000
-#endif
 
 static int master_clk_setrate(struct clk *clk, unsigned long rate, int id)
 {
@@ -557,8 +542,7 @@ static struct clk sh7722_r_clock = {
 	.rate = 32768,
 };
 
-#if !defined(CONFIG_CPU_SUBTYPE_SH7343) &&\
-    !defined(CONFIG_CPU_SUBTYPE_SH7724)
+#if !defined(CONFIG_CPU_SUBTYPE_SH7343)
 /*
  * these three clocks - SIU A, SIU B, IrDA - share the same clk_ops
  * methods of clk_ops determine which register they should access by
@@ -575,10 +559,9 @@ static struct clk sh7722_siu_b_clock = {
 	.arch_flags = SCLKBCR,
 	.ops = &sh7722_siu_clk_ops,
 };
-#endif /* CONFIG_CPU_SUBTYPE_SH7343, SH7724 */
+#endif /* CONFIG_CPU_SUBTYPE_SH7343 */
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7722) ||\
-    defined(CONFIG_CPU_SUBTYPE_SH7724)
+#if defined(CONFIG_CPU_SUBTYPE_SH7722)
 static struct clk sh7722_irda_clock = {
 	.name = "irda_clk",
 	.arch_flags = IrDACLKCR,
@@ -676,61 +659,6 @@ static struct clk sh7722_mstpcr_clocks[]
 	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
 	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
 #endif
-#if defined(CONFIG_CPU_SUBTYPE_SH7724)
-	/* See Datasheet : Overview -> Block Diagram */
-	MSTPCR("tlb0", "cpu_clk", 0, 31, 0),
-	MSTPCR("ic0", "cpu_clk", 0, 30, 0),
-	MSTPCR("oc0", "cpu_clk", 0, 29, 0),
-	MSTPCR("rs0", "bus_clk", 0, 28, 0),
-	MSTPCR("ilmem0", "cpu_clk", 0, 27, 0),
-	MSTPCR("l2c0", "sh_clk", 0, 26, 0),
-	MSTPCR("fpu0", "cpu_clk", 0, 24, 0),
-	MSTPCR("intc0", "peripheral_clk", 0, 22, 0),
-	MSTPCR("dmac0", "bus_clk", 0, 21, 0),
-	MSTPCR("sh0", "sh_clk", 0, 20, 0),
-	MSTPCR("hudi0", "peripheral_clk", 0, 19, 0),
-	MSTPCR("ubc0", "cpu_clk", 0, 17, 0),
-	MSTPCR("tmu0", "peripheral_clk", 0, 15, 0),
-	MSTPCR("cmt0", "r_clk", 0, 14, 0),
-	MSTPCR("rwdt0", "r_clk", 0, 13, 0),
-	MSTPCR("dmac1", "bus_clk", 0, 12, 0),
-	MSTPCR("tmu1", "peripheral_clk", 0, 10, 0),
-	MSTPCR("scif0", "peripheral_clk", 0, 9, 0),
-	MSTPCR("scif1", "peripheral_clk", 0, 8, 0),
-	MSTPCR("scif2", "peripheral_clk", 0, 7, 0),
-	MSTPCR("scif3", "bus_clk", 0, 6, 0),
-	MSTPCR("scif4", "bus_clk", 0, 5, 0),
-	MSTPCR("scif5", "bus_clk", 0, 4, 0),
-	MSTPCR("msiof0", "bus_clk", 0, 2, 0),
-	MSTPCR("msiof1", "bus_clk", 0, 1, 0),
-	MSTPCR("keysc0", "r_clk", 1, 12, 0),
-	MSTPCR("rtc0", "r_clk", 1, 11, 0),
-	MSTPCR("i2c0", "peripheral_clk", 1, 9, 0),
-	MSTPCR("i2c1", "peripheral_clk", 1, 8, 0),
-	MSTPCR("mmc0", "bus_clk", 2, 29, 0),
-	MSTPCR("eth0", "bus_clk", 2, 28, 0),
-	MSTPCR("atapi0", "bus_clk", 2, 26, 0),
-	MSTPCR("tpu0", "bus_clk", 2, 25, 0),
-	MSTPCR("irda0", "peripheral_clk", 2, 24, 0),
-	MSTPCR("tsif0", "bus_clk", 2, 22, 0),
-	MSTPCR("usb1", "bus_clk", 2, 21, 0),
-	MSTPCR("usb0", "bus_clk", 2, 20, 0),
-	MSTPCR("2dg0", "bus_clk", 2, 19, 0),
-	MSTPCR("sdhi0", "bus_clk", 2, 18, 0),
-	MSTPCR("sdhi1", "bus_clk", 2, 17, 0),
-	MSTPCR("veu1", "bus_clk", 2, 15, CLK_ENABLE_ON_INIT),
-	MSTPCR("ceu1", "bus_clk", 2, 13, 0),
-	MSTPCR("beu1", "bus_clk", 2, 12, 0),
-	MSTPCR("2ddmac0", "sh_clk", 2, 10, 0),
-	MSTPCR("spu0", "bus_clk", 2, 9, 0),
-	MSTPCR("jpu0", "bus_clk", 2, 6, 0),
-	MSTPCR("vou0", "bus_clk", 2, 5, 0),
-	MSTPCR("beu0", "bus_clk", 2, 4, 0),
-	MSTPCR("ceu0", "bus_clk", 2, 3, 0),
-	MSTPCR("veu0", "bus_clk", 2, 2, CLK_ENABLE_ON_INIT),
-	MSTPCR("vpu0", "bus_clk", 2, 1, CLK_ENABLE_ON_INIT),
-	MSTPCR("lcdc0", "bus_clk", 2, 0, 0),
-#endif
 #if defined(CONFIG_CPU_SUBTYPE_SH7343)
 	MSTPCR("uram0", "umem_clk", 0, 28, CLK_ENABLE_ON_INIT),
 	MSTPCR("xymem0", "bus_clk", 0, 26, CLK_ENABLE_ON_INIT),
@@ -802,14 +730,11 @@ static struct clk *sh7722_clocks[] = {
 	&sh7722_sh_clock,
 	&sh7722_peripheral_clock,
 	&sh7722_sdram_clock,
-#if !defined(CONFIG_CPU_SUBTYPE_SH7343) &&\
-    !defined(CONFIG_CPU_SUBTYPE_SH7724)
+#if !defined(CONFIG_CPU_SUBTYPE_SH7343)
 	&sh7722_siu_a_clock,
 	&sh7722_siu_b_clock,
 #endif
-/* 7724 should support FSI clock */
-#if defined(CONFIG_CPU_SUBTYPE_SH7722) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7724)
+#if defined(CONFIG_CPU_SUBTYPE_SH7722)
 	&sh7722_irda_clock,
 #endif
 	&sh7722_video_clock,
--- /dev/null
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2009-06-02 19:18:14.000000000 +0900
@@ -0,0 +1,183 @@
+/*
+ * arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+ *
+ * SH7724 clock framework support
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
+/* SH7724 registers */
+#define FRQCRA		0xa4150000
+#define FRQCRB		0xa4150004
+#define VCLKCR		0xa4150048
+#define FCLKACR		0xa4150008
+#define FCLKBCR		0xa415000c
+#define IRDACLKCR	0xa4150018
+#define SPUCLKCR	0xa415003c
+#define MSTPCR0		0xa4150030
+#define MSTPCR1		0xa4150034
+#define MSTPCR2		0xa4150038
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
+static unsigned long pll_recalc(struct clk *clk)
+{
+	return clk->parent->rate * (((__raw_readl(FRQCRA) >> 24) & 0x3f) + 1);
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
+	.parent		= &extal_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
+
+struct clk *main_clks[] = {
+	&r_clk,
+	&extal_clk,
+	&pll_clk,
+};
+
+static int divisors[] = { 2, 0, 4, 6, 8, 12, 16, 0, 24, 32, 36, 48, 0, 72 };
+
+static struct clk_div_mult_table div4_table = {
+	.divisors = divisors,
+	.nr_divisors = ARRAY_SIZE(divisors),
+};
+
+enum { DIV4_I, DIV4_SH, DIV4_B, DIV4_P, DIV4_M1, DIV4_NR };
+
+#define DIV4(_str, _reg, _bit, _mask, _flags) \
+  SH_CLK_DIV4(_str, &pll_clk, _reg, _bit, _mask, _flags)
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I] = DIV4("cpu_clk", FRQCRA, 20, 0x2f7d, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4("shyway_clk", FRQCRA, 12, 0x2f7c, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4("bus_clk", FRQCRA, 8, 0x2f7c, CLK_ENABLE_ON_INIT),
+	[DIV4_P] = DIV4("peripheral_clk", FRQCRA, 0, 0x2f7c, 0),
+	[DIV4_M1] = DIV4("vpu_clk", FRQCRB, 4, 0x2f7c, 0),
+};
+
+struct clk div6_clks[] = {
+	SH_CLK_DIV6("video_clk", &pll_clk, VCLKCR, 0),
+	SH_CLK_DIV6("fsia_clk", &pll_clk, FCLKACR, 0),
+	SH_CLK_DIV6("fsib_clk", &pll_clk, FCLKBCR, 0),
+	SH_CLK_DIV6("irda_clk", &pll_clk, IRDACLKCR, 0),
+	SH_CLK_DIV6("spu_clk", &pll_clk, SPUCLKCR, 0),
+};
+
+#define MSTP(_str, _parent, _reg, _bit, _force_on, _need_cpg, _need_ram) \
+  SH_CLK_MSTP32(_str, -1, _parent, _reg, _bit, _force_on * CLK_ENABLE_ON_INIT)
+
+static struct clk mstp_clks[] = {
+	MSTP("tlb0", &div4_clks[DIV4_I], MSTPCR0, 31, 1, 1, 0),
+	MSTP("ic0", &div4_clks[DIV4_I], MSTPCR0, 30, 1, 1, 0),
+	MSTP("oc0", &div4_clks[DIV4_I], MSTPCR0, 29, 1, 1, 0),
+	MSTP("rs0", &div4_clks[DIV4_B], MSTPCR0, 28, 1, 1, 0),
+	MSTP("ilmem0", &div4_clks[DIV4_I], MSTPCR0, 27, 1, 1, 0),
+	MSTP("l2c0", &div4_clks[DIV4_SH], MSTPCR0, 26, 1, 1, 0),
+	MSTP("fpu0", &div4_clks[DIV4_I], MSTPCR0, 24, 1, 1, 0),
+	MSTP("intc0", &div4_clks[DIV4_P], MSTPCR0, 22, 1, 1, 0),
+	MSTP("dmac0", &div4_clks[DIV4_B], MSTPCR0, 21, 0, 1, 1),
+	MSTP("sh0", &div4_clks[DIV4_SH], MSTPCR0, 20, 0, 1, 0),
+	MSTP("hudi0", &div4_clks[DIV4_P], MSTPCR0, 19, 0, 1, 0),
+	MSTP("ubc0", &div4_clks[DIV4_I], MSTPCR0, 17, 0, 1, 0),
+	MSTP("tmu0", &div4_clks[DIV4_P], MSTPCR0, 15, 0, 1, 0),
+	MSTP("cmt0", &r_clk, MSTPCR0, 14, 0, 0, 0),
+	MSTP("rwdt0", &r_clk, MSTPCR0, 13, 0, 0, 0),
+	MSTP("dmac1", &div4_clks[DIV4_B], MSTPCR0, 12, 0, 1, 1),
+	MSTP("flctl0", &div4_clks[DIV4_P], MSTPCR0, 10, 0, 1, 0),
+	MSTP("scif0", &div4_clks[DIV4_P], MSTPCR0, 9, 0, 1, 0),
+	MSTP("scif1", &div4_clks[DIV4_P], MSTPCR0, 8, 0, 1, 0),
+	MSTP("scif2", &div4_clks[DIV4_P], MSTPCR0, 7, 0, 1, 0),
+	MSTP("scif3", &div4_clks[DIV4_B], MSTPCR0, 6, 0, 1, 0),
+	MSTP("scif4", &div4_clks[DIV4_B], MSTPCR0, 5, 0, 1, 0),
+	MSTP("scif5", &div4_clks[DIV4_B], MSTPCR0, 4, 0, 1, 0),
+	MSTP("msiof0", &div4_clks[DIV4_B], MSTPCR0, 2, 0, 1, 0),
+	MSTP("msiof1", &div4_clks[DIV4_B], MSTPCR0, 1, 0, 1, 0),
+
+	MSTP("keysc0", &r_clk, MSTPCR1, 12, 0, 0, 0),
+	MSTP("rtc0", &r_clk, MSTPCR1, 11, 0, 0, 0),
+	MSTP("i2c0", &div4_clks[DIV4_P], MSTPCR1, 9, 0, 1, 0),
+	MSTP("i2c1", &div4_clks[DIV4_P], MSTPCR1, 8, 0, 1, 0),
+
+	MSTP("mmc0", &div4_clks[DIV4_B], MSTPCR2, 29, 0, 1, 0),
+	MSTP("eth0", &div4_clks[DIV4_B], MSTPCR2, 28, 0, 1, 0),
+	MSTP("atapi0", &div4_clks[DIV4_B], MSTPCR2, 26, 0, 1, 0),
+	MSTP("tpu0", &div4_clks[DIV4_B], MSTPCR2, 25, 0, 1, 0),
+	MSTP("irda0", &div4_clks[DIV4_P], MSTPCR2, 24, 0, 1, 0),
+	MSTP("tsif0", &div4_clks[DIV4_B], MSTPCR2, 22, 0, 1, 0),
+	MSTP("usb1", &div4_clks[DIV4_B], MSTPCR2, 21, 0, 1, 1),
+	MSTP("usb0", &div4_clks[DIV4_B], MSTPCR2, 20, 0, 1, 1),
+	MSTP("2dg0", &div4_clks[DIV4_B], MSTPCR2, 19, 0, 1, 1),
+	MSTP("sdhi0", &div4_clks[DIV4_B], MSTPCR2, 18, 0, 1, 0),
+	MSTP("sdhi1", &div4_clks[DIV4_B], MSTPCR2, 17, 0, 1, 0),
+	MSTP("veu1", &div4_clks[DIV4_B], MSTPCR2, 15, 1, 1, 1),
+	MSTP("ceu1", &div4_clks[DIV4_B], MSTPCR2, 13, 0, 1, 1),
+	MSTP("beu1", &div4_clks[DIV4_B], MSTPCR2, 12, 0, 1, 1),
+	MSTP("2ddmac0", &div4_clks[DIV4_SH], MSTPCR2, 10, 0, 1, 1),
+	MSTP("spu0", &div4_clks[DIV4_B], MSTPCR2, 9, 0, 1, 0),
+	MSTP("jpu0", &div4_clks[DIV4_B], MSTPCR2, 6, 1, 1, 1),
+	MSTP("vou0", &div4_clks[DIV4_B], MSTPCR2, 5, 0, 1, 1),
+	MSTP("beu0", &div4_clks[DIV4_B], MSTPCR2, 4, 0, 1, 1),
+	MSTP("ceu0", &div4_clks[DIV4_B], MSTPCR2, 3, 0, 1, 1),
+	MSTP("veu0", &div4_clks[DIV4_B], MSTPCR2, 2, 1, 1, 1),
+	MSTP("vpu0", &div4_clks[DIV4_B], MSTPCR2, 1, 1, 1, 1),
+	MSTP("lcdc0", &div4_clks[DIV4_B], MSTPCR2, 0, 0, 1, 1),
+};
+
+int __init arch_clk_init(void)
+{
+	int k, ret = 0;
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
