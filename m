From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 08 Dec 2011 13:59:13 +0000
Subject: [PATCH 03/04] sh: use ioread32/iowrite32 and mapped_reg for div4
Message-Id: <20111208135913.18394.31847.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the CPG DIV4 helper code to use the new mapped_reg
together with ioread32() and iowrite32().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/clk/cpg.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- 0010/drivers/sh/clk/cpg.c
+++ work/drivers/sh/clk/cpg.c	2011-12-08 22:20:29.000000000 +0900
@@ -217,7 +217,7 @@ static unsigned long sh_clk_div4_recalc(
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
 			     table, &clk->arch_flags);
 
-	idx = (__raw_readl(clk->enable_reg) >> clk->enable_bit) & 0x000f;
+	idx = (ioread32(clk->mapped_reg) >> clk->enable_bit) & 0x000f;
 
 	return clk->freq_table[idx].frequency;
 }
@@ -235,15 +235,15 @@ static int sh_clk_div4_set_parent(struct
 	 */
 
 	if (parent->flags & CLK_ENABLE_ON_INIT)
-		value = __raw_readl(clk->enable_reg) & ~(1 << 7);
+		value = ioread32(clk->mapped_reg) & ~(1 << 7);
 	else
-		value = __raw_readl(clk->enable_reg) | (1 << 7);
+		value = ioread32(clk->mapped_reg) | (1 << 7);
 
 	ret = clk_reparent(clk, parent);
 	if (ret < 0)
 		return ret;
 
-	__raw_writel(value, clk->enable_reg);
+	iowrite32(value, clk->mapped_reg);
 
 	/* Rebiuld the frequency table */
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
@@ -260,10 +260,10 @@ static int sh_clk_div4_set_rate(struct c
 	if (idx < 0)
 		return idx;
 
-	value = __raw_readl(clk->enable_reg);
+	value = ioread32(clk->mapped_reg);
 	value &= ~(0xf << clk->enable_bit);
 	value |= (idx << clk->enable_bit);
-	__raw_writel(value, clk->enable_reg);
+	iowrite32(value, clk->mapped_reg);
 
 	if (d4t->kick)
 		d4t->kick(clk);
@@ -273,13 +273,13 @@ static int sh_clk_div4_set_rate(struct c
 
 static int sh_clk_div4_enable(struct clk *clk)
 {
-	__raw_writel(__raw_readl(clk->enable_reg) & ~(1 << 8), clk->enable_reg);
+	iowrite32(ioread32(clk->mapped_reg) & ~(1 << 8), clk->mapped_reg);
 	return 0;
 }
 
 static void sh_clk_div4_disable(struct clk *clk)
 {
-	__raw_writel(__raw_readl(clk->enable_reg) | (1 << 8), clk->enable_reg);
+	iowrite32(ioread32(clk->mapped_reg) | (1 << 8), clk->mapped_reg);
 }
 
 static struct clk_ops sh_clk_div4_clk_ops = {
