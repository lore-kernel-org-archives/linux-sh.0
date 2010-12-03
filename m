From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 03 Dec 2010 05:37:53 +0000
Subject: [PATCH] sh: se/7724: Update clock framework of FSI clock to non-legacy
Message-Id: <1291354674-13100-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |   33 ++++-----------------------------
 1 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 6735305..1486ab7 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -283,31 +283,6 @@ static struct platform_device ceu1_device = {
 };
 
 /* FSI */
-/*
- * FSI-A use external clock which came from ak464x.
- * So, we should change parent of fsi
- */
-#define FCLKACR		0xa4150008
-static void fsimck_init(struct clk *clk)
-{
-	u32 status = __raw_readl(clk->enable_reg);
-
-	/* use external clock */
-	status &= ~0x000000ff;
-	status |= 0x00000080;
-	__raw_writel(status, clk->enable_reg);
-}
-
-static struct clk_ops fsimck_clk_ops = {
-	.init = fsimck_init,
-};
-
-static struct clk fsimcka_clk = {
-	.ops		= &fsimck_clk_ops,
-	.enable_reg	= (void __iomem *)FCLKACR,
-	.rate		= 0, /* unknown */
-};
-
 /* change J20, J21, J22 pin to 1-2 connection to use slave mode */
 static struct sh_fsi_platform_info fsi_info = {
 	.porta_flags = SH_FSI_BRS_INV |
@@ -879,10 +854,10 @@ static int __init devices_setup(void)
 	/* change parent of FSI A */
 	clk = clk_get(NULL, "fsia_clk");
 	if (!IS_ERR(clk)) {
-		clk_register(&fsimcka_clk);
-		clk_set_parent(clk, &fsimcka_clk);
-		clk_set_rate(clk, 11000);
-		clk_set_rate(&fsimcka_clk, 11000);
+		/* 48kHz dummy clock was used to make sure 1/1 divide */
+		clk_set_rate(&sh7724_fsimcka_clk, 48000);
+		clk_set_parent(clk, &sh7724_fsimcka_clk);
+		clk_set_rate(clk, 48000);
 		clk_put(clk);
 	}
 
-- 
1.7.2.3

