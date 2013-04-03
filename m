From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 03 Apr 2013 07:30:37 +0000
Subject: [RFC][PATCH 3/3] ARM: shmobile: r8a7790: add div6 clocks
Message-Id: <87a9pgcbqe.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

DIV6 clocks control SD*/MMC* core clocks.
This patch is based on Rev 0.05 datasheet.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |   34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index f50229c..09be2db 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -49,6 +49,12 @@
 
 #define MODEMR		0xE6160060
 #define SDCKCR		0xE6150074
+#define SD2CKCR		0xE6150078
+#define SD3CKCR		0xE615007C
+#define MMC0CKCR	0xE6150240
+#define MMC1CKCR	0xE6150244
+#define SSPCKCR		0xE6150248
+#define SSPRSCKCR	0xE615024C
 
 static struct clk_mapping cpg_mapping = {
 	.phys   = CPG_BASE,
@@ -147,6 +153,23 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_SD1] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 0, 0x1de0, CLK_ENABLE_ON_INIT),
 };
 
+/* DIV6 clocks */
+enum {
+	DIV6_SD2, DIV6_SD3,
+	DIV6_MMC0, DIV6_MMC1,
+	DIV6_SSP, DIV6_SSPRS,
+	DIV6_NR
+};
+
+static struct clk div6_clks[DIV6_NR] = {
+	[DIV6_SD2]	= SH_CLK_DIV6(&pll1_div2_clk, SD2CKCR, 0),
+	[DIV6_SD3]	= SH_CLK_DIV6(&pll1_div2_clk, SD3CKCR, 0),
+	[DIV6_MMC0]	= SH_CLK_DIV6(&pll1_div2_clk, MMC0CKCR, 0),
+	[DIV6_MMC1]	= SH_CLK_DIV6(&pll1_div2_clk, MMC1CKCR, 0),
+	[DIV6_SSP]	= SH_CLK_DIV6(&pll1_div2_clk, SSPCKCR, 0),
+	[DIV6_SSPRS]	= SH_CLK_DIV6(&pll1_div2_clk, SSPRSCKCR, 0),
+};
+
 /* MSTP */
 enum { MSTP721, MSTP720,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP_NR };
@@ -194,6 +217,14 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("sd0",		&div4_clks[DIV4_SD0]),
 	CLKDEV_CON_ID("sd1",		&div4_clks[DIV4_SD1]),
 
+	/* DIV6 */
+	CLKDEV_CON_ID("sd2",		&div6_clks[DIV6_SD2]),
+	CLKDEV_CON_ID("sd3",		&div6_clks[DIV6_SD3]),
+	CLKDEV_CON_ID("mmc0",		&div6_clks[DIV6_MMC0]),
+	CLKDEV_CON_ID("mmc1",		&div6_clks[DIV6_MMC1]),
+	CLKDEV_CON_ID("ssp",		&div6_clks[DIV6_SSP]),
+	CLKDEV_CON_ID("ssprs",		&div6_clks[DIV6_SSPRS]),
+
 	/* MSTP */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
@@ -247,6 +278,9 @@ void __init r8a7790_clock_init(void)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
+		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
+
+	if (!ret)
 		ret = sh_clk_mstp_register(mstp_clks, MSTP_NR);
 
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-- 
1.7.9.5

