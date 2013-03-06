From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Mar 2013 04:34:20 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-r8a7779: add DIV4 clock support
Message-Id: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current R8A7778 clock is using temporary setting as quick hack.
To correct it, this patch adds PLL-A and DIV4 clocks

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---

This patch is based on my previous R-Car M1A patch set

 arch/arm/mach-shmobile/clock-r8a7778.c |  107 ++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index bffa206..b49bcef 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -29,6 +29,19 @@
 #include <linux/clkdev.h>
 #include <mach/common.h>
 
+/*
+ *	MD	MD	MD	MD	 PLLA	PLLB	EXTAL	clki	clkz
+ *	19	18	12	11			(HMz)	(MHz)	(MHz)
+ *----------------------------------------------------------------------------
+ *	1	0	0	0	x21	x21	38.00	800	800
+ *	1	0	0	1	x24	x24	33.33	800	800
+ *	1	0	1	0	x28	x28	28.50	800	800
+ *	1	0	1	1	x32	x32	25.00	800	800
+ *	1	1	0	1	x24	x21	33.33	800	700
+ *	1	1	1	0	x28	x21	28.50	800	600
+ *	1	1	1	1	x32	x24	25.00	800	600
+ */
+
 #define FRQMR		IOMEM(0xffc80014)
 #define MSTPCR0		IOMEM(0xffc80030)
 #define MSTPCR1		IOMEM(0xffc80034)
@@ -49,45 +62,86 @@ static struct clk_mapping cpg_mapping = {
 	.len	= 0x80,
 };
 
-static struct clk clkp = {
-	.rate   = 62500000, /* FIXME: shortcut */
-	.flags  = CLK_ENABLE_ON_INIT,
-	.mapping = &cpg_mapping,
+static struct clk plla_clk = {
+	.rate		= 800000000,
+	.mapping	= &cpg_mapping,
 };
 
 static struct clk *main_clks[] = {
-	&clkp,
+	&plla_clk,
+};
+
+static int divisors[] = { 0, 1, 0, 3, 4, 6, 8, 0, 12, 16, 18 };
+
+static struct clk_div_mult_table div4_div_mult_table = {
+	.divisors = divisors,
+	.nr_divisors = ARRAY_SIZE(divisors),
+};
+
+static struct clk_div4_table div4_table = {
+	.div_mult_table = &div4_div_mult_table,
+};
+
+enum { DIV4_I, DIV4_S, DIV4_B, DIV4_OUT, DIV4_S4,
+       DIV4_S3, DIV4_S1, DIV4_P, DIV4_NR };
+
+static struct clk div4_clks[DIV4_NR] = {
+	[DIV4_I]	= SH_CLK_DIV4(&plla_clk, FRQMR, 28,
+				      0x0002, CLK_ENABLE_ON_INIT),
+	[DIV4_S]	= SH_CLK_DIV4(&plla_clk, FRQMR, 20,
+				      0x0018, CLK_ENABLE_ON_INIT),
+	[DIV4_OUT]	= SH_CLK_DIV4(&plla_clk, FRQMR, 16,
+				      0x0700, CLK_ENABLE_ON_INIT),
+	[DIV4_B]	= SH_CLK_DIV4(&plla_clk, FRQMR, 16,
+				      0x0700, CLK_ENABLE_ON_INIT),
+	[DIV4_S4]	= SH_CLK_DIV4(&plla_clk, FRQMR, 12,
+				      0x0060, CLK_ENABLE_ON_INIT),
+	[DIV4_S3]	= SH_CLK_DIV4(&plla_clk, FRQMR, 8,
+				      0x0018, CLK_ENABLE_ON_INIT),
+	[DIV4_S1]	= SH_CLK_DIV4(&plla_clk, FRQMR, 4,
+				      0x0060, CLK_ENABLE_ON_INIT),
+	[DIV4_P]	= SH_CLK_DIV4(&plla_clk, FRQMR, 0,
+				      0x0300, CLK_ENABLE_ON_INIT),
 };
 
 enum { MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015, MSTP014,
 	MSTP_NR };
 
-#define MSTP(_parent, _reg, _bit, _flags) \
-	SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
-
 static struct clk mstp_clks[MSTP_NR] = {
-	[MSTP026] = MSTP(&clkp, MSTPCR0, 26, 0), /* SCIF0 */
-	[MSTP025] = MSTP(&clkp, MSTPCR0, 25, 0), /* SCIF1 */
-	[MSTP024] = MSTP(&clkp, MSTPCR0, 24, 0), /* SCIF2 */
-	[MSTP023] = MSTP(&clkp, MSTPCR0, 23, 0), /* SCIF3 */
-	[MSTP022] = MSTP(&clkp, MSTPCR0, 22, 0), /* SCIF4 */
-	[MSTP021] = MSTP(&clkp, MSTPCR0, 21, 0), /* SCIF5 */
-	[MSTP016] = MSTP(&clkp, MSTPCR0, 16, 0), /* TMU0 */
-	[MSTP015] = MSTP(&clkp, MSTPCR0, 15, 0), /* TMU1 */
-	[MSTP014] = MSTP(&clkp, MSTPCR0, 14, 0), /* TMU2 */
+	[MSTP026] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 26, 0), /* SCIF0 */
+	[MSTP025] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 25, 0), /* SCIF1 */
+	[MSTP024] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 24, 0), /* SCIF2 */
+	[MSTP023] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 23, 0), /* SCIF3 */
+	[MSTP022] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 22, 0), /* SCIF4 */
+	[MSTP021] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 21, 0), /* SCIF5 */
+	[MSTP016] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 16, 0), /* TMU0 */
+	[MSTP015] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 15, 0), /* TMU1 */
+	[MSTP014] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 14, 0), /* TMU2 */
 };
 
 static struct clk_lookup lookups[] = {
+	/* main clocks */
+	CLKDEV_CON_ID("plla_clk",	&plla_clk),
+
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("shyway_clk",	&div4_clks[DIV4_S]),
+	CLKDEV_CON_ID("bus_clk",	&div4_clks[DIV4_B]),
+	CLKDEV_CON_ID("clkout",		&div4_clks[DIV4_OUT]),
+	CLKDEV_CON_ID("shyway4_clk",	&div4_clks[DIV4_S4]),
+	CLKDEV_CON_ID("shyway3_clk",	&div4_clks[DIV4_S3]),
+	CLKDEV_CON_ID("shyway1_clk",	&div4_clks[DIV4_S1]),
+	CLKDEV_CON_ID("peripheral_clk",	&div4_clks[DIV4_P]),
+
 	/* MSTP32 clocks */
-	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
-	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
-	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
-	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
-	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
-	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP023]), /* SCIF3 */
-	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
-	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
+	CLKDEV_DEV_ID("sh_tmu.0",	&mstp_clks[MSTP016]), /* TMU00 */
+	CLKDEV_DEV_ID("sh_tmu.1",	&mstp_clks[MSTP016]), /* TMU01 */
+	CLKDEV_DEV_ID("sh-sci.0",	&mstp_clks[MSTP026]), /* SCIF0 */
+	CLKDEV_DEV_ID("sh-sci.1",	&mstp_clks[MSTP025]), /* SCIF1 */
+	CLKDEV_DEV_ID("sh-sci.2",	&mstp_clks[MSTP024]), /* SCIF2 */
+	CLKDEV_DEV_ID("sh-sci.3",	&mstp_clks[MSTP023]), /* SCIF3 */
+	CLKDEV_DEV_ID("sh-sci.4",	&mstp_clks[MSTP022]), /* SCIF4 */
+	CLKDEV_DEV_ID("sh-sci.5",	&mstp_clks[MSTP021]), /* SCIF6 */
 };
 
 void __init r8a7778_clock_init(void)
@@ -98,6 +152,9 @@ void __init r8a7778_clock_init(void)
 		ret = clk_register(main_clks[k]);
 
 	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
+
+	if (!ret)
 		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-- 
1.7.9.5

