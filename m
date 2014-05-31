From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat, 31 May 2014 18:09:24 +0000
Subject: [PATCH] SH7206 new clock framework
Message-Id: <87ha453jmz.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Convert to new framework to SH7206

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/Kconfig                        |   2 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c | 140 +++++++++++++++++++++++----------
 2 files changed, 99 insertions(+), 43 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 6357710..2636a42 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -615,7 +615,7 @@ config SH_CLK_CPG_LEGACY
 	def_bool y if !CPU_SUBTYPE_SH7785 && !ARCH_SHMOBILE && \
 		      !CPU_SHX3 && !CPU_SUBTYPE_SH7757 && \
 		      !CPU_SUBTYPE_SH7734 && !CPU_SUBTYPE_SH7264 && \
-		      !CPU_SUBTYPE_SH7269
+		      !CPU_SUBTYPE_SH7269 && !CPU_SUBTYPE_SH7206
 
 endmenu
 
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7206.c b/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
index ac9f7dd..602c774 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
@@ -3,75 +3,121 @@
  *
  * SH7206 support for the clock framework
  *
- *  Copyright (C) 2006  Yoshinori Sato
+ *  Copyright (C) 2014  Yoshinori Sato
  *
- * Based on clock-sh4.c
- *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
+
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/clkdev.h>
 #include <asm/clock.h>
-#include <asm/freq.h>
 #include <asm/io.h>
 
+#define FRQCR 0xfffe0010
+#define MCLKCR 0xfffe0410
+#define STBCR3 0xfffe0408
+#define STBCR4 0xfffe040c
+
 static const int pll1rate[]={1,2,3,4,6,8};
-static const int pfc_divisors[]={1,2,3,4,6,8,12};
-#define ifc_divisors pfc_divisors
 
 static unsigned int pll2_mult;
 
-static void master_clk_init(struct clk *clk)
+static struct clk extal_clk = {
+	.rate		= 33333333,
+};
+
+static unsigned long pll_recalc(struct clk *clk)
 {
-	clk->rate *= pll2_mult * pll1rate[(__raw_readw(FREQCR) >> 8) & 0x0007];
+	unsigned long rate = clk->parent->rate * pll2_mult;
+	return rate * pll1rate[(__raw_readw(FRQCR) >> 8) & 7];
 }
 
-static struct sh_clk_ops sh7206_master_clk_ops = {
-	.init		= master_clk_init,
+static struct sh_clk_ops pll_clk_ops = {
+	.recalc		= pll_recalc,
 };
 
-static unsigned long module_clk_recalc(struct clk *clk)
-{
-	int idx = (__raw_readw(FREQCR) & 0x0007);
-	return clk->parent->rate / pfc_divisors[idx];
-}
+static struct clk pll_clk = {
+	.ops		= &pll_clk_ops,
+	.parent		= &extal_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};
 
-static struct sh_clk_ops sh7206_module_clk_ops = {
-	.recalc		= module_clk_recalc,
+struct clk *main_clks[] = {
+	&extal_clk,
+	&pll_clk,
 };
 
-static unsigned long bus_clk_recalc(struct clk *clk)
-{
-	int idx = (__raw_readw(FREQCR) >> 8 & 0x0007);
-	return clk->parent->rate / pll1rate[idx];
-}
+static int div1[] = { 1, 2, 3, 4, 6, 8, 12 };
 
-static struct sh_clk_ops sh7206_bus_clk_ops = {
-	.recalc		= bus_clk_recalc,
+static struct clk_div_mult_table div_div_mult_table = {
+	.divisors = div1,
+	.nr_divisors = ARRAY_SIZE(div1),
 };
 
-static unsigned long cpu_clk_recalc(struct clk *clk)
-{
-	int idx = ((__raw_readw(FREQCR) >> 4) & 0x0007);
-	return clk->parent->rate / ifc_divisors[idx];
+static struct clk_div4_table div_table = {
+	.div_mult_table = &div_div_mult_table,
+};
+
+#define SH_CLK_DIV(_parent, _reg, _shift, _div_bitmap, _mask, _flags)	\
+{								\
+	.parent = _parent,					\
+	.enable_reg = (void __iomem *)_reg,			\
+	.enable_bit = _shift,					\
+	.arch_flags = _div_bitmap,				\
+	.div_mask = _mask,					\
+	.flags = _flags,					\
 }
 
-static struct sh_clk_ops sh7206_cpu_clk_ops = {
-	.recalc		= cpu_clk_recalc,
+struct clk div_clks[] = {
+	SH_CLK_DIV(&pll_clk, FRQCR, 4, 0, 0x07, CLK_ENABLE_REG_16BIT), /* I */
+	SH_CLK_DIV(&pll_clk, FRQCR, 8, 0, 0x07, CLK_ENABLE_REG_16BIT), /* B */
+	SH_CLK_DIV(&pll_clk, FRQCR, 0, 0, 0x07, CLK_ENABLE_REG_16BIT), /* P */
+	SH_CLK_DIV(&pll_clk, MCLKCR, 0, 0, 0x03, CLK_ENABLE_REG_8BIT), /* MTU */
+};
+
+static struct clk mstp_clks[] = {
+	SH_CLK_MSTP8(&div_clks[2], STBCR4, 7, 0), /* SCIF0 */
+	SH_CLK_MSTP8(&div_clks[2], STBCR4, 6, 0), /* SCIF1 */
+	SH_CLK_MSTP8(&div_clks[2], STBCR4, 5, 0), /* SCIF2 */
+	SH_CLK_MSTP8(&div_clks[2], STBCR4, 4, 0), /* SCIF3 */
+	SH_CLK_MSTP8(&div_clks[2], STBCR4, 2, 0), /* CMT */
+	SH_CLK_MSTP8(&div_clks[3], STBCR3, 6, 0), /* MTU2S */
+	SH_CLK_MSTP8(&div_clks[3], STBCR3, 5, 0), /* MTU2 */
+	SH_CLK_MSTP8(&div_clks[2], STBCR3, 4, 1), /* POE2 */
+	SH_CLK_MSTP8(&div_clks[2], STBCR3, 3, 1), /* IIC3 */
+	SH_CLK_MSTP8(&div_clks[2], STBCR3, 2, 1), /* ADC */
+	SH_CLK_MSTP8(&div_clks[2], STBCR3, 1, 1), /* DAC */
 };
 
-static struct sh_clk_ops *sh7206_clk_ops[] = {
-	&sh7206_master_clk_ops,
-	&sh7206_module_clk_ops,
-	&sh7206_bus_clk_ops,
-	&sh7206_cpu_clk_ops,
+static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("extal", &extal_clk),
+	CLKDEV_CON_ID("pll_clk", &pll_clk),
+
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("cpu_clk", &div_clks[0]),
+	CLKDEV_CON_ID("bus_clk", &div_clks[1]),
+	CLKDEV_CON_ID("peripheral_clk", &div_clks[2]),
+	CLKDEV_CON_ID("mtu_clk", &div_clks[3]),
+
+	/* MSTP clocks */
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.0", &mstp_clks[0]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[1]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[2]),
+	CLKDEV_ICK_ID("sci_fck", "sh-sci.3", &mstp_clks[3]),
+	CLKDEV_CON_ID("cmt_fck", &mstp_clks[4]),
+	CLKDEV_CON_ID("mtu2s_fck", &mstp_clks[5]),
+	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[6]),
+	CLKDEV_CON_ID("poe", &mstp_clks[7]),
+	CLKDEV_CON_ID("iic", &mstp_clks[8]),
+	CLKDEV_CON_ID("adc0", &mstp_clks[9]),
+	CLKDEV_CON_ID("dac0", &mstp_clks[10]),
 };
 
-void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
+int __init arch_clk_init(void)
 {
+	int i, ret = 0;
+
 	if (test_mode_pin(MODE_PIN2 | MODE_PIN1 | MODE_PIN0) = 
 	    (MODE_PIN2 | MODE_PIN1 | MODE_PIN0))
 		pll2_mult = 1;
@@ -81,6 +127,16 @@ void __init arch_init_clk_ops(struct sh_clk_ops **ops, int idx)
 	else if (test_mode_pin(MODE_PIN1) = MODE_PIN1)
 		pll2_mult = 4;
 
-	if (idx < ARRAY_SIZE(sh7206_clk_ops))
-		*ops = sh7206_clk_ops[idx];
+	for (i = 0; !ret && (i < ARRAY_SIZE(main_clks)); i++)
+		ret = clk_register(main_clks[i]);
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+
+	if (!ret)
+		ret = sh_clk_div4_register(div_clks, ARRAY_SIZE(div_clks), &div_table);
+
+	if (!ret)
+		ret = sh_clk_mstp_register(mstp_clks, ARRAY_SIZE(mstp_clks));
+
+	return ret;
 }
-- 
2.0.0.rc0

