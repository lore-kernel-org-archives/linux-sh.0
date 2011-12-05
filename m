From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 05 Dec 2011 06:32:16 +0000
Subject: [PATCH 4/4] sh: clock-sh73a0: all div6_clks use SH_CLK_DIV6_EXT()
Message-Id: <871usj8r6b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current div6 clocks can specify their current parent clocks
from its register value if it is registered
by sh_clk_div6_reparent_register().
This patch modifies all div6 clocks into SH_CLK_DIV6_EXT().

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c        |  132 +++++++++++++++++++++-----
 arch/arm/mach-shmobile/include/mach/common.h |    2 +
 2 files changed, 112 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 61a846b..8daf21a 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -92,6 +92,24 @@ static struct clk_ops div2_clk_ops = {
 	.recalc		= div2_recalc,
 };
 
+static unsigned long div7_recalc(struct clk *clk)
+{
+	return clk->parent->rate / 7;
+}
+
+static struct clk_ops div7_clk_ops = {
+	.recalc		= div7_recalc,
+};
+
+static unsigned long div13_recalc(struct clk *clk)
+{
+	return clk->parent->rate / 13;
+}
+
+static struct clk_ops div13_clk_ops = {
+	.recalc		= div13_recalc,
+};
+
 /* Divide extal1 by two */
 static struct clk extal1_div2_clk = {
 	.ops		= &div2_clk_ops,
@@ -113,6 +131,11 @@ static struct clk main_clk = {
 	.ops		= &main_clk_ops,
 };
 
+static struct clk main_div2_clk = {
+	.ops		= &div2_clk_ops,
+	.parent		= &main_clk,
+};
+
 /* PLL0, PLL1, PLL2, PLL3 */
 static unsigned long pll_recalc(struct clk *clk)
 {
@@ -168,12 +191,29 @@ static struct clk pll3_clk = {
 	.enable_bit	= 3,
 };
 
-/* Divide PLL1 by two */
+/* Divide PLL */
 static struct clk pll1_div2_clk = {
 	.ops		= &div2_clk_ops,
 	.parent		= &pll1_clk,
 };
 
+static struct clk pll1_div7_clk = {
+	.ops		= &div7_clk_ops,
+	.parent		= &pll1_clk,
+};
+
+static struct clk pll1_div13_clk = {
+	.ops		= &div13_clk_ops,
+	.parent		= &pll1_clk,
+};
+
+/* External input clock */
+struct clk sh73a0_extcki_clk = {
+};
+
+struct clk sh73a0_extalr_clk = {
+};
+
 static struct clk *main_clks[] = {
 	&r_clk,
 	&sh73a0_extal1_clk,
@@ -181,11 +221,16 @@ static struct clk *main_clks[] = {
 	&extal1_div2_clk,
 	&extal2_div2_clk,
 	&main_clk,
+	&main_div2_clk,
 	&pll0_clk,
 	&pll1_clk,
 	&pll2_clk,
 	&pll3_clk,
 	&pll1_div2_clk,
+	&pll1_div7_clk,
+	&pll1_div13_clk,
+	&sh73a0_extcki_clk,
+	&sh73a0_extalr_clk,
 };
 
 static void div4_kick(struct clk *clk)
@@ -239,27 +284,70 @@ enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, DIV6_ZB1,
 	DIV6_DSIT, DIV6_DSI0P, DIV6_DSI1P,
 	DIV6_NR };
 
+static struct clk *vck_parent[] = {
+	[0] = &pll1_div2_clk,
+	[1] = &pll2_clk,
+	[2] = &sh73a0_extcki_clk,
+	[3] = &sh73a0_extal2_clk,
+	[4] = &main_div2_clk,
+	[5] = &sh73a0_extalr_clk,
+	[6] = &main_clk,
+	[7] = NULL,
+};
+
+static struct clk *pll_parent[] = {
+	[0] = &pll1_div2_clk,
+	[1] = &pll2_clk,
+	[2] = &pll1_div13_clk,
+	[3] = NULL,
+};
+
+static struct clk *hsi_parent[] = {
+	[0] = &pll1_div2_clk,
+	[1] = &pll2_clk,
+	[2] = &pll1_div7_clk,
+	[3] = NULL,
+};
+
+static struct clk *pll_extal2_parent[] = {
+	[0] = &pll1_div2_clk,
+	[1] = &pll2_clk,
+	[2] = &sh73a0_extal2_clk,
+	[3] = &sh73a0_extal2_clk,
+};
+
+static struct clk *dsi_parent[] = {
+	[0] = &pll1_div2_clk,
+	[1] = &pll2_clk,
+	[2] = &main_clk,
+	[3] = &sh73a0_extal2_clk,
+	[4] = &sh73a0_extcki_clk,
+	[5] = NULL,
+	[6] = NULL,
+	[7] = NULL,
+};
+
 static struct clk div6_clks[DIV6_NR] = {
-	[DIV6_VCK1] = SH_CLK_DIV6(&pll1_div2_clk, VCLKCR1, 0),
-	[DIV6_VCK2] = SH_CLK_DIV6(&pll1_div2_clk, VCLKCR2, 0),
-	[DIV6_VCK3] = SH_CLK_DIV6(&pll1_div2_clk, VCLKCR3, 0),
-	[DIV6_ZB1] = SH_CLK_DIV6(&pll1_div2_clk, ZBCKCR, 0),
-	[DIV6_FLCTL] = SH_CLK_DIV6(&pll1_div2_clk, FLCKCR, 0),
-	[DIV6_SDHI0] = SH_CLK_DIV6(&pll1_div2_clk, SD0CKCR, 0),
-	[DIV6_SDHI1] = SH_CLK_DIV6(&pll1_div2_clk, SD1CKCR, 0),
-	[DIV6_SDHI2] = SH_CLK_DIV6(&pll1_div2_clk, SD2CKCR, 0),
-	[DIV6_FSIA] = SH_CLK_DIV6(&pll1_div2_clk, FSIACKCR, 0),
-	[DIV6_FSIB] = SH_CLK_DIV6(&pll1_div2_clk, FSIBCKCR, 0),
-	[DIV6_SUB] = SH_CLK_DIV6(&sh73a0_extal2_clk, SUBCKCR, 0),
-	[DIV6_SPUA] = SH_CLK_DIV6(&pll1_div2_clk, SPUACKCR, 0),
-	[DIV6_SPUV] = SH_CLK_DIV6(&pll1_div2_clk, SPUVCKCR, 0),
-	[DIV6_MSU] = SH_CLK_DIV6(&pll1_div2_clk, MSUCKCR, 0),
-	[DIV6_HSI] = SH_CLK_DIV6(&pll1_div2_clk, HSICKCR, 0),
-	[DIV6_MFG1] = SH_CLK_DIV6(&pll1_div2_clk, MFCK1CR, 0),
-	[DIV6_MFG2] = SH_CLK_DIV6(&pll1_div2_clk, MFCK2CR, 0),
-	[DIV6_DSIT] = SH_CLK_DIV6(&pll1_div2_clk, DSITCKCR, 0),
-	[DIV6_DSI0P] = SH_CLK_DIV6(&pll1_div2_clk, DSI0PCKCR, 0),
-	[DIV6_DSI1P] = SH_CLK_DIV6(&pll1_div2_clk, DSI1PCKCR, 0),
+	[DIV6_VCK1]	= SH_CLK_DIV6_EXT(VCLKCR1, vck_parent, 12, 3, 0),
+	[DIV6_VCK2]	= SH_CLK_DIV6_EXT(VCLKCR2, vck_parent, 12, 3, 0),
+	[DIV6_VCK3]	= SH_CLK_DIV6_EXT(VCLKCR3, vck_parent, 12, 3, 0),
+	[DIV6_ZB1]	= SH_CLK_DIV6_EXT(ZBCKCR,  pll_parent, 7, 1, 0),
+	[DIV6_FLCTL]	= SH_CLK_DIV6_EXT(FLCKCR,  pll_parent, 7, 1, 0),
+	[DIV6_SDHI0]	= SH_CLK_DIV6_EXT(SD0CKCR, pll_parent, 6, 2, 0),
+	[DIV6_SDHI1]	= SH_CLK_DIV6_EXT(SD1CKCR, pll_parent, 6, 2, 0),
+	[DIV6_SDHI2]	= SH_CLK_DIV6_EXT(SD2CKCR, pll_parent, 6, 2, 0),
+	[DIV6_FSIA]	= SH_CLK_DIV6_EXT(FSIACKCR, pll_parent, 6, 1, 0),
+	[DIV6_FSIB]	= SH_CLK_DIV6_EXT(FSIBCKCR, pll_parent, 6, 1, 0),
+	[DIV6_SUB]	= SH_CLK_DIV6_EXT(SUBCKCR,  pll_extal2_parent, 6, 2, 0),
+	[DIV6_SPUA]	= SH_CLK_DIV6_EXT(SPUACKCR, pll_extal2_parent, 6, 2, 0),
+	[DIV6_SPUV]	= SH_CLK_DIV6_EXT(SPUVCKCR, pll_extal2_parent, 6, 2, 0),
+	[DIV6_MSU]	= SH_CLK_DIV6_EXT(MSUCKCR, pll_parent, 7, 1, 0),
+	[DIV6_HSI]	= SH_CLK_DIV6_EXT(HSICKCR, hsi_parent, 6, 2, 0),
+	[DIV6_MFG1]	= SH_CLK_DIV6_EXT(MFCK1CR, pll_parent, 7, 1, 0),
+	[DIV6_MFG2]	= SH_CLK_DIV6_EXT(MFCK2CR, pll_parent, 7, 1, 0),
+	[DIV6_DSIT]	= SH_CLK_DIV6_EXT(DSITCKCR, pll_parent, 7, 1, 0),
+	[DIV6_DSI0P]	= SH_CLK_DIV6_EXT(DSI0PCKCR, dsi_parent, 12, 3, 0),
+	[DIV6_DSI1P]	= SH_CLK_DIV6_EXT(DSI1PCKCR, dsi_parent, 12, 3, 0),
 };
 
 enum { MSTP001,
@@ -387,7 +475,7 @@ void __init sh73a0_clock_init(void)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
-		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
+		ret = sh_clk_div6_reparent_register(div6_clks, DIV6_NR);
 
 	if (!ret)
 		ret = sh_clk_mstp32_register(mstp_clks, MSTP_NR);
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 834bd6c..d055d05 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -47,6 +47,8 @@ extern void sh73a0_clock_init(void);
 extern void sh73a0_pinmux_init(void);
 extern struct clk sh73a0_extal1_clk;
 extern struct clk sh73a0_extal2_clk;
+extern struct clk sh73a0_extcki_clk;
+extern struct clk sh73a0_extalr_clk;
 
 extern unsigned int sh73a0_get_core_count(void);
 extern void sh73a0_secondary_init(unsigned int cpu);
-- 
1.7.5.4

