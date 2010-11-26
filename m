From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Nov 2010 09:40:22 +0000
Subject: [PATCH] sh: Add div6_reparent_clks to clock framework for FSI
Message-Id: <w3ptyj4o22h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current clk_ops doesn't support .init which
is used to select external clock on ecovec
without CONFIG_SH_CLK_CPG_LEGACY.
To solve this problem, this patch add div6_reparent_clks
to clock-sh7724.
This patch solve compile error too.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
I tested it on latest Linus tree

 arch/sh/boards/mach-ecovec24/setup.c   |   34 +++---------------------
 arch/sh/include/cpu-sh4/cpu/sh7724.h   |    3 ++
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   44 ++++++++++++++++++++++++++++---
 3 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 2eaeb9e..f48c492 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -720,32 +720,6 @@ static struct platform_device camera_devices[] = {
 };
 
 /* FSI */
-/*
- * FSI-B use external clock which came from da7210.
- * So, we should change parent of fsi
- */
-#define FCLKBCR		0xa415000c
-static void fsimck_init(struct clk *clk)
-{
-	u32 status = __raw_readl(clk->enable_reg);
-
-	/* use external clock */
-	status &= ~0x000000ff;
-	status |= 0x00000080;
-
-	__raw_writel(status, clk->enable_reg);
-}
-
-static struct clk_ops fsimck_clk_ops = {
-	.init = fsimck_init,
-};
-
-static struct clk fsimckb_clk = {
-	.ops		= &fsimck_clk_ops,
-	.enable_reg	= (void __iomem *)FCLKBCR,
-	.rate		= 0, /* unknown */
-};
-
 static struct sh_fsi_platform_info fsi_info = {
 	.portb_flags = SH_FSI_BRS_INV |
 		       SH_FSI_OUT_SLAVE_MODE |
@@ -1264,10 +1238,10 @@ static int __init arch_setup(void)
 	/* change parent of FSI B */
 	clk = clk_get(NULL, "fsib_clk");
 	if (!IS_ERR(clk)) {
-		clk_register(&fsimckb_clk);
-		clk_set_parent(clk, &fsimckb_clk);
-		clk_set_rate(clk, 11000);
-		clk_set_rate(&fsimckb_clk, 11000);
+		/* 48kHz dummy clock was used to make sure 1/1 divide */
+		clk_set_rate(&sh7724_fsimckb_clk, 48000);
+		clk_set_parent(clk, &sh7724_fsimckb_clk);
+		clk_set_rate(clk, 48000);
 		clk_put(clk);
 	}
 
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
index 4c27b68..7eb4359 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
@@ -303,4 +303,7 @@ enum {
 	SHDMA_SLAVE_SDHI1_RX,
 };
 
+extern struct clk sh7724_fsimcka_clk;
+extern struct clk sh7724_fsimckb_clk;
+
 #endif /* __ASM_SH7724_H__ */
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 0fe2e93..271c0b3 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -111,12 +111,21 @@ static struct clk div3_clk = {
 	.parent		= &pll_clk,
 };
 
+/* External input clock (pin name: FSIMCKA/FSIMCKB ) */
+struct clk sh7724_fsimcka_clk = {
+};
+
+struct clk sh7724_fsimckb_clk = {
+};
+
 static struct clk *main_clks[] = {
 	&r_clk,
 	&extal_clk,
 	&fll_clk,
 	&pll_clk,
 	&div3_clk,
+	&sh7724_fsimcka_clk,
+	&sh7724_fsimckb_clk,
 };
 
 static void div4_kick(struct clk *clk)
@@ -154,16 +163,38 @@ struct clk div4_clks[DIV4_NR] = {
 	[DIV4_M1] = DIV4(FRQCRB, 4, 0x2f7c, CLK_ENABLE_ON_INIT),
 };
 
-enum { DIV6_V, DIV6_FA, DIV6_FB, DIV6_I, DIV6_S, DIV6_NR };
+enum { DIV6_V, DIV6_I, DIV6_S, DIV6_NR };
 
 static struct clk div6_clks[DIV6_NR] = {
 	[DIV6_V] = SH_CLK_DIV6(&div3_clk, VCLKCR, 0),
-	[DIV6_FA] = SH_CLK_DIV6(&div3_clk, FCLKACR, 0),
-	[DIV6_FB] = SH_CLK_DIV6(&div3_clk, FCLKBCR, 0),
 	[DIV6_I] = SH_CLK_DIV6(&div3_clk, IRDACLKCR, 0),
 	[DIV6_S] = SH_CLK_DIV6(&div3_clk, SPUCLKCR, CLK_ENABLE_ON_INIT),
 };
 
+enum { DIV6_FA, DIV6_FB, DIV6_REPARENT_NR };
+
+/* Indices are important - they are the actual src selecting values */
+static struct clk *fclkacr_parent[] = {
+	[0] = &div3_clk,
+	[1] = NULL,
+	[2] = &sh7724_fsimcka_clk,
+	[3] = NULL,
+};
+
+static struct clk *fclkbcr_parent[] = {
+	[0] = &div3_clk,
+	[1] = NULL,
+	[2] = &sh7724_fsimckb_clk,
+	[3] = NULL,
+};
+
+static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
+	[DIV6_FA] = SH_CLK_DIV6_EXT(&div3_clk, FCLKACR, 0,
+				      fclkacr_parent, ARRAY_SIZE(fclkacr_parent), 6, 2),
+	[DIV6_FB] = SH_CLK_DIV6_EXT(&div3_clk, FCLKBCR, 0,
+				      fclkbcr_parent, ARRAY_SIZE(fclkbcr_parent), 6, 2),
+};
+
 static struct clk mstp_clks[HWBLK_NR] = {
 	SH_HWBLK_CLK(HWBLK_TLB, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
 	SH_HWBLK_CLK(HWBLK_IC, &div4_clks[DIV4_I], CLK_ENABLE_ON_INIT),
@@ -240,8 +271,8 @@ static struct clk_lookup lookups[] = {
 
 	/* DIV6 clocks */
 	CLKDEV_CON_ID("video_clk", &div6_clks[DIV6_V]),
-	CLKDEV_CON_ID("fsia_clk", &div6_clks[DIV6_FA]),
-	CLKDEV_CON_ID("fsib_clk", &div6_clks[DIV6_FB]),
+	CLKDEV_CON_ID("fsia_clk", &div6_reparent_clks[DIV6_FA]),
+	CLKDEV_CON_ID("fsib_clk", &div6_reparent_clks[DIV6_FB]),
 	CLKDEV_CON_ID("irda_clk", &div6_clks[DIV6_I]),
 	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_S]),
 
@@ -376,6 +407,9 @@ int __init arch_clk_init(void)
 		ret = sh_clk_div6_register(div6_clks, DIV6_NR);
 
 	if (!ret)
+		ret = sh_clk_div6_reparent_register(div6_reparent_clks, DIV6_REPARENT_NR);
+
+	if (!ret)
 		ret = sh_hwblk_clk_register(mstp_clks, HWBLK_NR);
 
 	return ret;
-- 
1.7.0.4

