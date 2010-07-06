From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 06 Jul 2010 04:32:05 +0000
Subject: [PATCH v2 5/6] sh: modify clock framework of SH7757
Message-Id: <4C32B1C5.3030906@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/Kconfig                        |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |  199 ++++++++++++++++++--------------
 2 files changed, 112 insertions(+), 89 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index e6b1f20..4b5a1d5 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -573,7 +573,7 @@ config SH_CLK_CPG
 config SH_CLK_CPG_LEGACY
 	depends on SH_CLK_CPG
 	def_bool y if !CPU_SUBTYPE_SH7785 && !ARCH_SHMOBILE && \
-		      !CPU_SUBTYPE_SH7786
+		      !CPU_SUBTYPE_SH7786 && !CPU_SUBTYPE_SH7757

 config SH_CLK_MD
 	int "CPU Mode Pin Setting"
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 0a752bd..ce39a2a 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -3,7 +3,7 @@
  *
  * SH7757 support for the clock framework
  *
- *  Copyright (C) 2009  Renesas Solutions Corp.
+ *  Copyright (C) 2009-2010  Renesas Solutions Corp.
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -16,124 +16,147 @@
 #include <asm/clock.h>
 #include <asm/freq.h>

-static int ifc_divisors[] = { 2, 1, 4, 1, 1, 8, 1, 1,
-			      16, 1, 1, 32, 1, 1, 1, 1 };
-static int sfc_divisors[] = { 2, 1, 4, 1, 1, 8, 1, 1,
-			      16, 1, 1, 32, 1, 1, 1, 1 };
-static int bfc_divisors[] = { 2, 1, 4, 1, 1, 8, 1, 1,
-			      16, 1, 1, 32, 1, 1, 1, 1 };
-static int p1fc_divisors[] = { 2, 1, 4, 1, 1, 8, 1, 1,
-			       16, 1, 1, 32, 1, 1, 1, 1 };
+/*
+ * Default rate for the root input clock, reset this with clk_set_rate()
+ * from the platform code.
+ */
+static struct clk extal_clk = {
+	.rate		= 48000000,
+};

-static void master_clk_init(struct clk *clk)
+static unsigned long pll_recalc(struct clk *clk)
 {
-	clk->rate = CONFIG_SH_PCLK_FREQ * 16;
-}
+	int multiplier;

-static struct clk_ops sh7757_master_clk_ops = {
-	.init		= master_clk_init,
-};
+	multiplier = test_mode_pin(MODE_PIN0) ? 24 : 16;

-static void module_clk_recalc(struct clk *clk)
-{
-	int idx = __raw_readl(FRQCR) & 0x0000000f;
-	clk->rate = clk->parent->rate / p1fc_divisors[idx];
+	return clk->parent->rate * multiplier;
 }

-static struct clk_ops sh7757_module_clk_ops = {
-	.recalc		= module_clk_recalc,
+static struct clk_ops pll_clk_ops = {
+	.recalc		= pll_recalc,
 };

-static void bus_clk_recalc(struct clk *clk)
-{
-	int idx = (__raw_readl(FRQCR) >> 8) & 0x0000000f;
-	clk->rate = clk->parent->rate / bfc_divisors[idx];
-}
+static struct clk pll_clk = {
+	.ops		= &pll_clk_ops,
+	.parent		= &extal_clk,
+	.flags		= CLK_ENABLE_ON_INIT,
+};

-static struct clk_ops sh7757_bus_clk_ops = {
-	.recalc		= bus_clk_recalc,
+static struct clk *clks[] = {
+	&extal_clk,
+	&pll_clk,
 };

-static void cpu_clk_recalc(struct clk *clk)
-{
-	int idx = (__raw_readl(FRQCR) >> 20) & 0x0000000f;
-	clk->rate = clk->parent->rate / ifc_divisors[idx];
-}
+static unsigned int div2[] = { 1, 1, 2, 1, 1, 4, 1, 6,
+			       1, 1, 1, 16, 1, 24, 1, 1 };

-static struct clk_ops sh7757_cpu_clk_ops = {
-	.recalc		= cpu_clk_recalc,
+static struct clk_div_mult_table div4_div_mult_table = {
+	.divisors = div2,
+	.nr_divisors = ARRAY_SIZE(div2),
 };

-static struct clk_ops *sh7757_clk_ops[] = {
-	&sh7757_master_clk_ops,
-	&sh7757_module_clk_ops,
-	&sh7757_bus_clk_ops,
-	&sh7757_cpu_clk_ops,
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
 };

-void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
-{
-	if (idx < ARRAY_SIZE(sh7757_clk_ops))
-		*ops = sh7757_clk_ops[idx];
-}
+enum { DIV4_I, DIV4_SH, DIV4_P, DIV4_NR };

-static void shyway_clk_recalc(struct clk *clk)
-{
-	int idx = (__raw_readl(FRQCR) >> 12) & 0x0000000f;
-	clk->rate = clk->parent->rate / sfc_divisors[idx];
-}
-
-static struct clk_ops sh7757_shyway_clk_ops = {
-	.recalc		= shyway_clk_recalc,
-};
+#define DIV4(_bit, _mask, _flags) \
+  SH_CLK_DIV4(&pll_clk, FRQCR, _bit, _mask, _flags)

-static struct clk sh7757_shyway_clk = {
-	.flags		= CLK_ENABLE_ON_INIT,
-	.ops		= &sh7757_shyway_clk_ops,
+struct clk div4_clks[DIV4_NR] = {
+	/*
+	 * P clock is always enable, because some P clock modules is used
+	 * by Host PC.
+	 */
+	[DIV4_P] = DIV4(0, 0x2800, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4(12, 0x00a0, CLK_ENABLE_ON_INIT),
+	[DIV4_I] = DIV4(20, 0x0004, CLK_ENABLE_ON_INIT),
 };

-/*
- * Additional sh7757-specific on-chip clocks that aren't already part of the
- * clock framework
- */
-static struct clk *sh7757_onchip_clocks[] = {
-	&sh7757_shyway_clk,
+#define MSTPCR0		0xffc80030
+#define MSTPCR1		0xffc80034
+
+enum { MSTP004, MSTP000, MSTP114, MSTP113, MSTP112,
+       MSTP111, MSTP110, MSTP103, MSTP102,
+       MSTP_NR };
+
+static struct clk mstp_clks[MSTP_NR] = {
+	/* MSTPCR0 */
+	[MSTP004] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 4, 0),
+	[MSTP000] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 0, 0),
+
+	/* MSTPCR1 */
+	[MSTP114] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 14, 0),
+	[MSTP113] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 13, 0),
+	[MSTP112] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 12, 0),
+	[MSTP111] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 11, 0),
+	[MSTP110] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 10, 0),
+	[MSTP103] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 3, 0),
+	[MSTP102] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 2, 0),
 };

 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }

 static struct clk_lookup lookups[] = {
 	/* main clocks */
-	CLKDEV_CON_ID("shyway_clk", &sh7757_shyway_clk),
+	CLKDEV_CON_ID("extal", &extal_clk),
+	CLKDEV_CON_ID("pll_clk", &pll_clk),
+
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("peripheral_clk", &div4_clks[DIV4_P]),
+	CLKDEV_CON_ID("shyway_clk", &div4_clks[DIV4_SH]),
+	CLKDEV_CON_ID("cpu_clk", &div4_clks[DIV4_I]),
+
+	/* MSTP32 clocks */
+	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP004]),
+	CLKDEV_CON_ID("riic", &mstp_clks[MSTP000]),
+	{
+		/* TMU0 */
+		.dev_id		= "sh_tmu.0",
+		.con_id		= "tmu_fck",
+		.clk		= &mstp_clks[MSTP113],
+	}, {
+		/* TMU1 */
+		.dev_id		= "sh_tmu.1",
+		.con_id		= "tmu_fck",
+		.clk		= &mstp_clks[MSTP114],
+	},
+	{
+		/* SCIF4 (But, ID is 2) */
+		.dev_id		= "sh-sci.2",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP112],
+	}, {
+		/* SCIF3 */
+		.dev_id		= "sh-sci.1",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP111],
+	}, {
+		/* SCIF2 */
+		.dev_id		= "sh-sci.0",
+		.con_id		= "sci_fck",
+		.clk		= &mstp_clks[MSTP110],
+	},
+	CLKDEV_CON_ID("usb0", &mstp_clks[MSTP102]),
 };

-static int __init sh7757_clk_init(void)
+int __init arch_clk_init(void)
 {
-	struct clk *clk = clk_get(NULL, "master_clk");
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(sh7757_onchip_clocks); i++) {
-		struct clk *clkp = sh7757_onchip_clocks[i];
+	int i, ret = 0;

-		clkp->parent = clk;
-		clk_register(clkp);
-		clk_enable(clkp);
-	}
+	for (i = 0; i < ARRAY_SIZE(clks); i++)
+		ret |= clk_register(clks[i]);
+	for (i = 0; i < ARRAY_SIZE(lookups); i++)
+		clkdev_add(&lookups[i]);

-	/*
-	 * Now that we have the rest of the clocks registered, we need to
-	 * force the parent clock to propagate so that these clocks will
-	 * automatically figure out their rate. We cheat by handing the
-	 * parent clock its current rate and forcing child propagation.
-	 */
-	clk_set_rate(clk, clk_get_rate(clk));
+	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
+					   &div4_table);
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);

-	clk_put(clk);
-
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
-	return 0;
+	return ret;
 }

-arch_initcall(sh7757_clk_init);
-
-- 
1.7.1


