From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Dec 2011 08:52:06 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: clock-r8a7779: add DIV4 clock support
Message-Id: <871urz7hhp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |   76 ++++++++++++++++++++++++-------
 1 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 8a90106..29c3306 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -45,36 +45,75 @@ static struct clk_mapping cpg_mapping = {
 	.len	= 0x80,
 };
 
-static struct clk clkp = {
-	.rate	= 62500000, /* FIXME: shortcut */
-	.flags	= CLK_ENABLE_ON_INIT,
-	.mapping = &cpg_mapping,
+/*
+ * Default rate for the root input clock, reset this with clk_set_rate()
+ * from the platform code.
+ */
+static struct clk plla_clk = {
+	.rate		= 1500000000,
+	.mapping	= &cpg_mapping,
 };
 
 static struct clk *main_clks[] = {
-	&clkp,
+	&plla_clk,
+};
+
+static int divisors[] = { 0, 0, 0, 6, 8, 12, 16, 0, 24, 32, 36, 0, 0, 0, 0, 0 };
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
+enum { DIV4_S, DIV4_OUT, DIV4_S4, DIV4_S3, DIV4_S1, DIV4_P, DIV4_NR };
+
+static struct clk div4_clks[DIV4_NR] = {
+	[DIV4_S]	= SH_CLK_DIV4(&plla_clk, FRQMR, 20,
+				      0x0018, CLK_ENABLE_ON_INIT),
+	[DIV4_OUT]	= SH_CLK_DIV4(&plla_clk, FRQMR, 16,
+				      0x0700, CLK_ENABLE_ON_INIT),
+	[DIV4_S4]	= SH_CLK_DIV4(&plla_clk, FRQMR, 12,
+				      0x0040, CLK_ENABLE_ON_INIT),
+	[DIV4_S3]	= SH_CLK_DIV4(&plla_clk, FRQMR, 8,
+				      0x0010, CLK_ENABLE_ON_INIT),
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
+	CLKDEV_CON_ID("plla_clk", &plla_clk),
+
+	/* DIV4 clocks */
+	CLKDEV_CON_ID("shyway_clk",	&div4_clks[DIV4_S]),
+	CLKDEV_CON_ID("bus_clk",	&div4_clks[DIV4_OUT]),
+	CLKDEV_CON_ID("shyway4_clk",	&div4_clks[DIV4_S4]),
+	CLKDEV_CON_ID("shyway3_clk",	&div4_clks[DIV4_S3]),
+	CLKDEV_CON_ID("shyway1_clk",	&div4_clks[DIV4_S1]),
+	CLKDEV_CON_ID("peripheral_clk",	&div4_clks[DIV4_P]),
+
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
@@ -94,6 +133,9 @@ void __init r8a7779_clock_init(void)
 		ret = clk_register(main_clks[k]);
 
 	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
+
+	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-- 
1.7.5.4

