From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 08 Dec 2011 13:59:03 +0000
Subject: [PATCH 02/04] sh: use ioread32/iowrite32 and mapped_reg for mstp32
Message-Id: <20111208135903.18394.48027.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the CPG MSTP32 helper code to use the new mapped_reg
together with ioread32() and iowrite32().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/clk/cpg.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 0001/drivers/sh/clk/cpg.c
+++ work/drivers/sh/clk/cpg.c	2011-12-08 13:31:24.000000000 +0900
@@ -15,15 +15,15 @@
 
 static int sh_clk_mstp32_enable(struct clk *clk)
 {
-	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << clk->enable_bit),
-		     clk->enable_reg);
+	iowrite32(ioread32(clk->mapped_reg) & ~(1 << clk->enable_bit),
+		  clk->mapped_reg);
 	return 0;
 }
 
 static void sh_clk_mstp32_disable(struct clk *clk)
 {
-	__raw_writel(__raw_readl(clk->enable_reg) | (1 << clk->enable_bit),
-		     clk->enable_reg);
+	iowrite32(ioread32(clk->mapped_reg) | (1 << clk->enable_bit),
+		  clk->mapped_reg);
 }
 
 static struct clk_ops sh_clk_mstp32_clk_ops = {
