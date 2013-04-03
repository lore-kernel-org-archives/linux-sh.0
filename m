From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 03 Apr 2013 07:30:28 +0000
Subject: [RFC][PATCH 2/3] ARM: shmobile: r8a7790: add div4 clocks
Message-Id: <87bo9wcbqn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

DIV4 clocks control SD* core clocks.
This patch is based on Rev 0.05 datasheet.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index e7282ef..f50229c 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -48,6 +48,7 @@
 #define SMSTPCR7 0xe615014c
 
 #define MODEMR		0xE6160060
+#define SDCKCR		0xE6150074
 
 static struct clk_mapping cpg_mapping = {
 	.phys   = CPG_BASE,
@@ -124,6 +125,29 @@ static struct clk *main_clks[] = {
 	&cp_clk,
 };
 
+/* SDHI (DIV4) clock */
+static int divisors[] = { 2, 3, 4, 6, 8, 12, 16, 18, 24, 0, 36, 48, 10 };
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
+enum {
+	DIV4_SDH, DIV4_SD0, DIV4_SD1, DIV4_NR
+};
+
+struct clk div4_clks[DIV4_NR] = {
+	[DIV4_SDH] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 8, 0x0dff, CLK_ENABLE_ON_INIT),
+	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1de0, CLK_ENABLE_ON_INIT),
+	[DIV4_SD1] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 0, 0x1de0, CLK_ENABLE_ON_INIT),
+};
+
+/* MSTP */
 enum { MSTP721, MSTP720,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP_NR };
 static struct clk mstp_clks[MSTP_NR] = {
@@ -165,6 +189,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("mp",		&mp_clk),
 	CLKDEV_CON_ID("cp",		&cp_clk),
 
+	/* DIV4 */
+	CLKDEV_CON_ID("sdh",		&div4_clks[DIV4_SDH]),
+	CLKDEV_CON_ID("sd0",		&div4_clks[DIV4_SD0]),
+	CLKDEV_CON_ID("sd1",		&div4_clks[DIV4_SD1]),
+
 	/* MSTP */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
@@ -215,6 +244,9 @@ void __init r8a7790_clock_init(void)
 		ret = clk_register(main_clks[k]);
 
 	if (!ret)
+		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
+
+	if (!ret)
 		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-- 
1.7.9.5

