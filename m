From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 08 Dec 2011 13:59:22 +0000
Subject: [PATCH 04/04] sh: use ioread32/iowrite32 and mapped_reg for div6
Message-Id: <20111208135922.18394.95163.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the CPG DIV6 helper code to use the new mapped_reg
together with ioread32() and iowrite32().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/clk/cpg.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- 0011/drivers/sh/clk/cpg.c
+++ work/drivers/sh/clk/cpg.c	2011-12-08 22:19:00.000000000 +0900
@@ -72,7 +72,7 @@ static unsigned long sh_clk_div6_recalc(
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
 			     table, NULL);
 
-	idx = __raw_readl(clk->enable_reg) & 0x003f;
+	idx = ioread32(clk->mapped_reg) & 0x003f;
 
 	return clk->freq_table[idx].frequency;
 }
@@ -98,10 +98,10 @@ static int sh_clk_div6_set_parent(struct
 	if (ret < 0)
 		return ret;
 
-	value = __raw_readl(clk->enable_reg) &
+	value = ioread32(clk->mapped_reg) &
 		~(((1 << clk->src_width) - 1) << clk->src_shift);
 
-	__raw_writel(value | (i << clk->src_shift), clk->enable_reg);
+	iowrite32(value | (i << clk->src_shift), clk->mapped_reg);
 
 	/* Rebuild the frequency table */
 	clk_rate_table_build(clk, clk->freq_table, table->nr_divisors,
@@ -119,10 +119,10 @@ static int sh_clk_div6_set_rate(struct c
 	if (idx < 0)
 		return idx;
 
-	value = __raw_readl(clk->enable_reg);
+	value = ioread32(clk->mapped_reg);
 	value &= ~0x3f;
 	value |= idx;
-	__raw_writel(value, clk->enable_reg);
+	iowrite32(value, clk->mapped_reg);
 	return 0;
 }
 
@@ -133,9 +133,9 @@ static int sh_clk_div6_enable(struct clk
 
 	ret = sh_clk_div6_set_rate(clk, clk->rate);
 	if (ret = 0) {
-		value = __raw_readl(clk->enable_reg);
+		value = ioread32(clk->mapped_reg);
 		value &= ~0x100; /* clear stop bit to enable clock */
-		__raw_writel(value, clk->enable_reg);
+		iowrite32(value, clk->mapped_reg);
 	}
 	return ret;
 }
@@ -144,10 +144,10 @@ static void sh_clk_div6_disable(struct c
 {
 	unsigned long value;
 
-	value = __raw_readl(clk->enable_reg);
+	value = ioread32(clk->mapped_reg);
 	value |= 0x100; /* stop clock */
 	value |= 0x3f; /* VDIV bits must be non-zero, overwrite divider */
-	__raw_writel(value, clk->enable_reg);
+	iowrite32(value, clk->mapped_reg);
 }
 
 static struct clk_ops sh_clk_div6_clk_ops = {
