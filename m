From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 06 Dec 2011 06:28:18 +0000
Subject: [PATCH v2 2/3] sh: clkfwk: clock-sh7724: all div6_clks use SH_CLK_DIV6_EXT()
Message-Id: <87ehwimcxt.wl%kuninori.morimoto.gx@renesas.com>
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
v1 -> v2

- normal SH_CLK_DIV6_EXT() macro
- drop un-needed NULL from clock parent table, and add array size in table

 arch/sh/include/cpu-sh4/cpu/sh7724.h   |    1 +
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   40 ++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
index cbc47e6..36ce466 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
@@ -314,5 +314,6 @@ enum {
 
 extern struct clk sh7724_fsimcka_clk;
 extern struct clk sh7724_fsimckb_clk;
+extern struct clk sh7724_dv_clki;
 
 #endif /* __ASM_SH7724_H__ */
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 7711838..9ee4b36 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -111,13 +111,16 @@ static struct clk div3_clk = {
 	.parent		= &pll_clk,
 };
 
-/* External input clock (pin name: FSIMCKA/FSIMCKB ) */
+/* External input clock (pin name: FSIMCKA/FSIMCKB/DV_CLKI ) */
 struct clk sh7724_fsimcka_clk = {
 };
 
 struct clk sh7724_fsimckb_clk = {
 };
 
+struct clk sh7724_dv_clki = {
+};
+
 static struct clk *main_clks[] = {
 	&r_clk,
 	&extal_clk,
@@ -126,6 +129,7 @@ static struct clk *main_clks[] = {
 	&div3_clk,
 	&sh7724_fsimcka_clk,
 	&sh7724_fsimckb_clk,
+	&sh7724_dv_clki,
 };
 
 static void div4_kick(struct clk *clk)
@@ -163,17 +167,20 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_M1] = DIV4(FRQCRB, 4, 0x2f7c, CLK_ENABLE_ON_INIT),
 };
 
-enum { DIV6_V, DIV6_I, DIV6_S, DIV6_NR };
+enum { DIV6_V, DIV6_I, DIV6_S, DIV6_FA, DIV6_FB, DIV6_NR };
 
-static struct clk div6_clks[DIV6_NR] = {
-	[DIV6_V] = SH_CLK_DIV6(&div3_clk, VCLKCR, 0),
-	[DIV6_I] = SH_CLK_DIV6(&div3_clk, IRDACLKCR, 0),
-	[DIV6_S] = SH_CLK_DIV6(&div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
+/* Indices are important - they are the actual src selecting values */
+static struct clk *common_parent[] = {
+	[0] = &div3_clk,
+	[1] = NULL,
 };
 
-enum { DIV6_FA, DIV6_FB, DIV6_REPARENT_NR };
+static struct clk *vclkcr_parent[8] = {
+	[0] = &div3_clk,
+	[2] = &sh7724_dv_clki,
+	[4] = &extal_clk,
+};
 
-/* Indices are important - they are the actual src selecting values */
 static struct clk *fclkacr_parent[] = {
 	[0] = &div3_clk,
 	[1] = NULL,
@@ -188,7 +195,13 @@ static struct clk *fclkbcr_parent[] = {
 	[3] = NULL,
 };
 
-static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
+static struct clk div6_clks[DIV6_NR] = {
+	[DIV6_V] = SH_CLK_DIV6_EXT(VCLKCR, 0,
+			vclkcr_parent, ARRAY_SIZE(vclkcr_parent), 12, 3),
+	[DIV6_I] = SH_CLK_DIV6_EXT(IRDACLKCR, 0,
+			common_parent, ARRAY_SIZE(common_parent), 6, 1),
+	[DIV6_S] = SH_CLK_DIV6_EXT(SPUCLKCR, CLK_ENABLE_ON_INIT,
+			common_parent, ARRAY_SIZE(common_parent), 6, 1),
 	[DIV6_FA] = SH_CLK_DIV6_EXT(FCLKACR, 0,
 				      fclkacr_parent, ARRAY_SIZE(fclkacr_parent), 6, 2),
 	[DIV6_FB] = SH_CLK_DIV6_EXT(FCLKBCR, 0,
@@ -269,8 +282,8 @@ static struct clk_lookup lookups[] = {
 
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
-	CLKDEV_CON_ID("fsia_clk", &div6_reparent_clks[DIV6_FA]),
-	CLKDEV_CON_ID("fsib_clk", &div6_reparent_clks[DIV6_FB]),
+	CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FA]),
+	CLKDEV_CON_ID("fsib_clk", &div6_clks[DIV6_FB]),
 	CLKDEV_CON_ID("irda_clk", &div6_clks[DIV6_I]),
 	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_S]),
 
@@ -356,10 +369,7 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div4_register(div4_clks, DIV4_NR, &div4_table);
 
 	if (!ret)
-		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
-
-	if (!ret)
-		ret = sh_clk_div6_reparent_register(div6_reparent_clks, DIV6_REPARENT_NR);
+		ret = sh_clk_div6_reparent_register(div6_clks, DIV6_NR);
 
 	if (!ret)
 		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
-- 
1.7.5.4

