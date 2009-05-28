From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 13:01:53 +0000
Subject: [PATCH] sh: hook upshared mstp32 clock code to sh7785
Message-Id: <20090528130153.6566.78971.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Hook up the shared 32-bit module stop bit code to sh7785.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   80 ++++++++++----------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

--- 0005/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7785.c	2009-05-28 16:58:07.000000000 +0900
@@ -193,65 +193,34 @@ static struct clk *clks[] = {
 	&umem_clk,
 };
 
-static int mstpcr_clk_enable(struct clk *clk)
-{
-	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << clk->enable_bit),
-		     clk->enable_reg);
-	return 0;
-}
-
-static void mstpcr_clk_disable(struct clk *clk)
-{
-	__raw_writel(__raw_readl(clk->enable_reg) | (1 << clk->enable_bit),
-		     clk->enable_reg);
-}
-
-static struct clk_ops mstpcr_clk_ops = {
-	.enable		= mstpcr_clk_enable,
-	.disable	= mstpcr_clk_disable,
-	.recalc		= followparent_recalc,
-};
-
 #define MSTPCR0		0xffc80030
 #define MSTPCR1		0xffc80034
 
-#define CLK(_name, _id, _parent, _enable_reg,		\
-	    _enable_bit, _flags)			\
-{							\
-	.name		= _name,			\
-	.id		= _id,				\
-	.parent		= _parent,			\
-	.enable_reg	= (void __iomem *)_enable_reg,	\
-	.enable_bit	= _enable_bit,			\
-	.flags		= _flags,			\
-	.ops		= &mstpcr_clk_ops,		\
-}
-
-static struct clk mstpcr_clks[] = {
+static struct clk mstp_clks[] = {
 	/* MSTPCR0 */
-	CLK("scif_fck", 5, &peripheral_clk, MSTPCR0, 29, 0),
-	CLK("scif_fck", 4, &peripheral_clk, MSTPCR0, 28, 0),
-	CLK("scif_fck", 3, &peripheral_clk, MSTPCR0, 27, 0),
-	CLK("scif_fck", 2, &peripheral_clk, MSTPCR0, 26, 0),
-	CLK("scif_fck", 1, &peripheral_clk, MSTPCR0, 25, 0),
-	CLK("scif_fck", 0, &peripheral_clk, MSTPCR0, 24, 0),
-	CLK("ssi_fck", 1, &peripheral_clk, MSTPCR0, 21, 0),
-	CLK("ssi_fck", 0, &peripheral_clk, MSTPCR0, 20, 0),
-	CLK("hac_fck", 1, &peripheral_clk, MSTPCR0, 17, 0),
-	CLK("hac_fck", 0, &peripheral_clk, MSTPCR0, 16, 0),
-	CLK("mmcif_fck", -1, &peripheral_clk, MSTPCR0, 13, 0),
-	CLK("flctl_fck", -1, &peripheral_clk, MSTPCR0, 12, 0),
-	CLK("tmu345_fck", -1, &peripheral_clk, MSTPCR0, 9, 0),
-	CLK("tmu012_fck", -1, &peripheral_clk, MSTPCR0, 8, 0),
-	CLK("siof_fck", -1, &peripheral_clk, MSTPCR0, 3, 0),
-	CLK("hspi_fck", -1, &peripheral_clk, MSTPCR0, 2, 0),
+	SH_CLK_MSTP32("scif_fck", 5, &peripheral_clk, MSTPCR0, 29, 0),
+	SH_CLK_MSTP32("scif_fck", 4, &peripheral_clk, MSTPCR0, 28, 0),
+	SH_CLK_MSTP32("scif_fck", 3, &peripheral_clk, MSTPCR0, 27, 0),
+	SH_CLK_MSTP32("scif_fck", 2, &peripheral_clk, MSTPCR0, 26, 0),
+	SH_CLK_MSTP32("scif_fck", 1, &peripheral_clk, MSTPCR0, 25, 0),
+	SH_CLK_MSTP32("scif_fck", 0, &peripheral_clk, MSTPCR0, 24, 0),
+	SH_CLK_MSTP32("ssi_fck", 1, &peripheral_clk, MSTPCR0, 21, 0),
+	SH_CLK_MSTP32("ssi_fck", 0, &peripheral_clk, MSTPCR0, 20, 0),
+	SH_CLK_MSTP32("hac_fck", 1, &peripheral_clk, MSTPCR0, 17, 0),
+	SH_CLK_MSTP32("hac_fck", 0, &peripheral_clk, MSTPCR0, 16, 0),
+	SH_CLK_MSTP32("mmcif_fck", -1, &peripheral_clk, MSTPCR0, 13, 0),
+	SH_CLK_MSTP32("flctl_fck", -1, &peripheral_clk, MSTPCR0, 12, 0),
+	SH_CLK_MSTP32("tmu345_fck", -1, &peripheral_clk, MSTPCR0, 9, 0),
+	SH_CLK_MSTP32("tmu012_fck", -1, &peripheral_clk, MSTPCR0, 8, 0),
+	SH_CLK_MSTP32("siof_fck", -1, &peripheral_clk, MSTPCR0, 3, 0),
+	SH_CLK_MSTP32("hspi_fck", -1, &peripheral_clk, MSTPCR0, 2, 0),
 
 	/* MSTPCR1 */
-	CLK("hudi_fck", -1, NULL, MSTPCR1, 19, 0),
-	CLK("ubc_fck", -1, NULL, MSTPCR1, 17, 0),
-	CLK("dmac_11_6_fck", -1, NULL, MSTPCR1, 5, 0),
-	CLK("dmac_5_0_fck", -1, NULL, MSTPCR1, 4, 0),
-	CLK("gdta_fck", -1, NULL, MSTPCR1, 0, 0),
+	SH_CLK_MSTP32("hudi_fck", -1, NULL, MSTPCR1, 19, 0),
+	SH_CLK_MSTP32("ubc_fck", -1, NULL, MSTPCR1, 17, 0),
+	SH_CLK_MSTP32("dmac_11_6_fck", -1, NULL, MSTPCR1, 5, 0),
+	SH_CLK_MSTP32("dmac_5_0_fck", -1, NULL, MSTPCR1, 4, 0),
+	SH_CLK_MSTP32("gdta_fck", -1, NULL, MSTPCR1, 0, 0),
 };
 
 int __init arch_clk_init(void)
@@ -260,8 +229,9 @@ int __init arch_clk_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++)
 		ret |= clk_register(clks[i]);
-	for (i = 0; i < ARRAY_SIZE(mstpcr_clks); i++)
-		ret |= clk_register(&mstpcr_clks[i]);
+
+	if (!ret)
+		ret = sh_clk_mstp32_register(mstp_clks, ARRAY_SIZE(mstp_clks));
 
 	return ret;
 }
