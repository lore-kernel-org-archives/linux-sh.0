From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 13:13:56 +0000
Subject: [PATCH] sh: hook up shared div4 clock code to sh7785
Message-Id: <20090528131356.6782.79657.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Hook up the shared 4-bit divisor clock code to sh7785.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |  207 +++++++-------------------------
 1 file changed, 48 insertions(+), 159 deletions(-)

--- 0007/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2009-05-28 17:45:15.000000000 +0900
@@ -18,65 +18,14 @@
 #include <asm/freq.h>
 #include <cpu/sh7785.h>
 
-static unsigned int div2[] = { 1, 2, 4, 6, 8, 12, 16, 18,
-			       24, 32, 36, 48 };
-
-static struct clk_div_mult_table cpg_div = {
-	.divisors = div2,
-	.nr_divisors = ARRAY_SIZE(div2),
-};
-
-struct clk_priv {
-	unsigned int			shift;
-
-	/* allowable divisor bitmap */
-	unsigned long			div_bitmap;
-
-	/* Supportable frequencies + termination entry */
-	struct cpufreq_frequency_table	freq_table[ARRAY_SIZE(div2)+1];
-};
-
-#define FRQMR_CLK_DATA(_name, _shift, _div_bitmap)	\
-static struct clk_priv _name##_data = {			\
-	.shift		= _shift,			\
-	.div_bitmap	= _div_bitmap,			\
-							\
-	.freq_table[0]	= {				\
-		.index = 0,				\
-		.frequency = CPUFREQ_TABLE_END,		\
-	},						\
-}
-
-FRQMR_CLK_DATA(pfc,  0, 0x0f80);
-FRQMR_CLK_DATA(s3fc, 4, 0x0ff0);
-FRQMR_CLK_DATA(s2fc, 8, 0x0030);
-FRQMR_CLK_DATA(mfc, 12, 0x000c);
-FRQMR_CLK_DATA(bfc, 16, 0x0fe0);
-FRQMR_CLK_DATA(sfc, 20, 0x000c);
-FRQMR_CLK_DATA(ufc, 24, 0x000c);
-FRQMR_CLK_DATA(ifc, 28, 0x000e);
-
-static unsigned long frqmr_recalc(struct clk *clk)
-{
-	struct clk_priv *data = clk->priv;
-	unsigned int idx = (__raw_readl(FRQMR1) >> data->shift) & 0x000f;
-
-	clk_rate_table_build(clk, data->freq_table, ARRAY_SIZE(div2),
-			     &cpg_div, &data->div_bitmap);
-	
-	return data->freq_table[idx].frequency;
-}
-
-static long frqmr_round_rate(struct clk *clk, unsigned long rate)
-{
-	struct clk_priv *data = clk->priv;
-
-	return clk_rate_table_round(clk, data->freq_table, rate);
-}
-
-static struct clk_ops frqmr_clk_ops = {
-	.recalc			= frqmr_recalc,
-	.round_rate		= frqmr_round_rate,
+/*
+ * Default rate for the root input clock, reset this with clk_set_rate()
+ * from the platform code.
+ */
+static struct clk extal_clk = {
+	.name		= "extal",
+	.id		= -1,
+	.rate		= 33333333,
 };
 
 static unsigned long pll_recalc(struct clk *clk)
@@ -92,16 +41,6 @@ static struct clk_ops pll_clk_ops = {
 	.recalc		= pll_recalc,
 };
 
-/*
- * Default rate for the root input clock, reset this with clk_set_rate()
- * from the platform code.
- */
-static struct clk extal_clk = {
-	.name		= "extal",
-	.id		= -1,
-	.rate		= 33333333,
-};
-
 static struct clk pll_clk = {
 	.name		= "pll_clk",
 	.id		= -1,
@@ -110,87 +49,34 @@ static struct clk pll_clk = {
 	.flags		= CLK_ENABLE_ON_INIT,
 };
 
-static struct clk cpu_clk = {
-	.name		= "cpu_clk",		/* Ick */
-	.id		= -1,
-	.ops		= &frqmr_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-	.priv		= &ifc_data,
-};
-
-static struct clk shyway_clk = {
-	.name		= "shyway_clk",		/* SHck */
-	.id		= -1,
-	.ops		= &frqmr_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-	.priv		= &sfc_data,
-};
-
-static struct clk peripheral_clk = {
-	.name		= "peripheral_clk",	/* Pck */
-	.id		= -1,
-	.ops		= &frqmr_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-	.priv		= &pfc_data,
-};
-
-static struct clk ddr_clk = {
-	.name		= "ddr_clk",		/* DDRck */
-	.id		= -1,
-	.ops		= &frqmr_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-	.priv		= &mfc_data,
+static struct clk *clks[] = {
+	&extal_clk,
+	&pll_clk,
 };
 
-static struct clk bus_clk = {
-	.name		= "bus_clk",		/* Bck */
-	.id		= -1,
-	.ops		= &frqmr_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-	.priv		= &bfc_data,
-};
+static unsigned int div2[] = { 1, 2, 4, 6, 8, 12, 16, 18,
+			       24, 32, 36, 48 };
 
-static struct clk ga_clk = {
-	.name		= "ga_clk",		/* GAck */
-	.id		= -1,
-	.ops		= &frqmr_clk_ops,
-	.parent		= &pll_clk,
-	.priv		= &s2fc_data,
+static struct clk_div_mult_table div4_table = {
+	.divisors = div2,
+	.nr_divisors = ARRAY_SIZE(div2),
 };
 
-static struct clk du_clk = {
-	.name		= "du_clk",		/* DUck */
-	.id		= -1,
-	.ops		= &frqmr_clk_ops,
-	.parent		= &pll_clk,
-	.priv		= &s3fc_data,
-};
+enum { DIV4_I, DIV4_U, DIV4_SH, DIV4_B, DIV4_DDR, DIV4_GA,
+	DIV4_DU, DIV4_P, DIV4_NR };
 
-static struct clk umem_clk = {
-	.name		= "umem_clk",		/* uck */
-	.id		= -1,
-	.ops		= &frqmr_clk_ops,
-	.parent		= &pll_clk,
-	.flags		= CLK_ENABLE_ON_INIT,
-	.priv		= &ufc_data,
-};
+#define DIV4(_str, _bit, _mask, _flags) \
+  SH_CLK_DIV4(_str, &pll_clk, FRQMR1, _bit, _mask, _flags)
 
-static struct clk *clks[] = {
-	&extal_clk,
-	&pll_clk,
-	&cpu_clk,
-	&shyway_clk,
-	&peripheral_clk,
-	&ddr_clk,
-	&bus_clk,
-	&ga_clk,
-	&du_clk,
-	&umem_clk,
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_P] = DIV4("peripheral_clk", 0, 0x0f80, 0),
+	[DIV4_DU] = DIV4("du_clk", 4, 0x0ff0, 0),
+	[DIV4_GA] = DIV4("ga_clk", 8, 0x0030, 0),
+	[DIV4_DDR] = DIV4("ddr_clk", 12, 0x000c, CLK_ENABLE_ON_INIT),
+	[DIV4_B] = DIV4("bus_clk", 16, 0x0fe0, CLK_ENABLE_ON_INIT),
+	[DIV4_SH] = DIV4("shyway_clk", 20, 0x000c, CLK_ENABLE_ON_INIT),
+	[DIV4_U] = DIV4("umem_clk", 24, 0x000c, CLK_ENABLE_ON_INIT),
+	[DIV4_I] = DIV4("cpu_clk", 28, 0x000e, CLK_ENABLE_ON_INIT),
 };
 
 #define MSTPCR0		0xffc80030
@@ -198,22 +84,22 @@ static struct clk *clks[] = {
 
 static struct clk mstp_clks[] = {
 	/* MSTPCR0 */
-	SH_CLK_MSTP32("scif_fck", 5, &peripheral_clk, MSTPCR0, 29, 0),
-	SH_CLK_MSTP32("scif_fck", 4, &peripheral_clk, MSTPCR0, 28, 0),
-	SH_CLK_MSTP32("scif_fck", 3, &peripheral_clk, MSTPCR0, 27, 0),
-	SH_CLK_MSTP32("scif_fck", 2, &peripheral_clk, MSTPCR0, 26, 0),
-	SH_CLK_MSTP32("scif_fck", 1, &peripheral_clk, MSTPCR0, 25, 0),
-	SH_CLK_MSTP32("scif_fck", 0, &peripheral_clk, MSTPCR0, 24, 0),
-	SH_CLK_MSTP32("ssi_fck", 1, &peripheral_clk, MSTPCR0, 21, 0),
-	SH_CLK_MSTP32("ssi_fck", 0, &peripheral_clk, MSTPCR0, 20, 0),
-	SH_CLK_MSTP32("hac_fck", 1, &peripheral_clk, MSTPCR0, 17, 0),
-	SH_CLK_MSTP32("hac_fck", 0, &peripheral_clk, MSTPCR0, 16, 0),
-	SH_CLK_MSTP32("mmcif_fck", -1, &peripheral_clk, MSTPCR0, 13, 0),
-	SH_CLK_MSTP32("flctl_fck", -1, &peripheral_clk, MSTPCR0, 12, 0),
-	SH_CLK_MSTP32("tmu345_fck", -1, &peripheral_clk, MSTPCR0, 9, 0),
-	SH_CLK_MSTP32("tmu012_fck", -1, &peripheral_clk, MSTPCR0, 8, 0),
-	SH_CLK_MSTP32("siof_fck", -1, &peripheral_clk, MSTPCR0, 3, 0),
-	SH_CLK_MSTP32("hspi_fck", -1, &peripheral_clk, MSTPCR0, 2, 0),
+	SH_CLK_MSTP32("scif_fck", 5, &div4_clks[DIV4_P], MSTPCR0, 29, 0),
+	SH_CLK_MSTP32("scif_fck", 4, &div4_clks[DIV4_P], MSTPCR0, 28, 0),
+	SH_CLK_MSTP32("scif_fck", 3, &div4_clks[DIV4_P], MSTPCR0, 27, 0),
+	SH_CLK_MSTP32("scif_fck", 2, &div4_clks[DIV4_P], MSTPCR0, 26, 0),
+	SH_CLK_MSTP32("scif_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 25, 0),
+	SH_CLK_MSTP32("scif_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 24, 0),
+	SH_CLK_MSTP32("ssi_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 21, 0),
+	SH_CLK_MSTP32("ssi_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 20, 0),
+	SH_CLK_MSTP32("hac_fck", 1, &div4_clks[DIV4_P], MSTPCR0, 17, 0),
+	SH_CLK_MSTP32("hac_fck", 0, &div4_clks[DIV4_P], MSTPCR0, 16, 0),
+	SH_CLK_MSTP32("mmcif_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 13, 0),
+	SH_CLK_MSTP32("flctl_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 12, 0),
+	SH_CLK_MSTP32("tmu345_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 9, 0),
+	SH_CLK_MSTP32("tmu012_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 8, 0),
+	SH_CLK_MSTP32("siof_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 3, 0),
+	SH_CLK_MSTP32("hspi_fck", -1, &div4_clks[DIV4_P], MSTPCR0, 2, 0),
 
 	/* MSTPCR1 */
 	SH_CLK_MSTP32("hudi_fck", -1, NULL, MSTPCR1, 19, 0),
@@ -231,6 +117,9 @@ int __init arch_clk_init(void)
 		ret |= clk_register(clks[i]);
 
 	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, ARRAY_SIZE(div4_clks),
+					   &div4_table);
+	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
 
 	return ret;
