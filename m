From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Feb 2012 13:16:21 +0000
Subject: [PATCH 02/17] sh: convert cpg code to sh_clk_ops
Message-Id: <20120229131621.29154.89090.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the CPG code to use sh_clk_ops.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/clk/cpg.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- 0001/drivers/sh/clk/cpg.c
+++ work/drivers/sh/clk/cpg.c	2012-02-28 21:54:15.000000000 +0900
@@ -26,7 +26,7 @@ static void sh_clk_mstp32_disable(struct
 		  clk->mapped_reg);
 }
 
-static struct clk_ops sh_clk_mstp32_clk_ops = {
+static struct sh_clk_ops sh_clk_mstp32_clk_ops = {
 	.enable		= sh_clk_mstp32_enable,
 	.disable	= sh_clk_mstp32_disable,
 	.recalc		= followparent_recalc,
@@ -150,7 +150,7 @@ static void sh_clk_div6_disable(struct c
 	iowrite32(value, clk->mapped_reg);
 }
 
-static struct clk_ops sh_clk_div6_clk_ops = {
+static struct sh_clk_ops sh_clk_div6_clk_ops = {
 	.recalc		= sh_clk_div6_recalc,
 	.round_rate	= sh_clk_div_round_rate,
 	.set_rate	= sh_clk_div6_set_rate,
@@ -158,7 +158,7 @@ static struct clk_ops sh_clk_div6_clk_op
 	.disable	= sh_clk_div6_disable,
 };
 
-static struct clk_ops sh_clk_div6_reparent_clk_ops = {
+static struct sh_clk_ops sh_clk_div6_reparent_clk_ops = {
 	.recalc		= sh_clk_div6_recalc,
 	.round_rate	= sh_clk_div_round_rate,
 	.set_rate	= sh_clk_div6_set_rate,
@@ -200,7 +200,7 @@ static int __init sh_clk_init_parent(str
 }
 
 static int __init sh_clk_div6_register_ops(struct clk *clks, int nr,
-					   struct clk_ops *ops)
+					   struct sh_clk_ops *ops)
 {
 	struct clk *clkp;
 	void *freq_table;
@@ -317,13 +317,13 @@ static void sh_clk_div4_disable(struct c
 	iowrite32(ioread32(clk->mapped_reg) | (1 << 8), clk->mapped_reg);
 }
 
-static struct clk_ops sh_clk_div4_clk_ops = {
+static struct sh_clk_ops sh_clk_div4_clk_ops = {
 	.recalc		= sh_clk_div4_recalc,
 	.set_rate	= sh_clk_div4_set_rate,
 	.round_rate	= sh_clk_div_round_rate,
 };
 
-static struct clk_ops sh_clk_div4_enable_clk_ops = {
+static struct sh_clk_ops sh_clk_div4_enable_clk_ops = {
 	.recalc		= sh_clk_div4_recalc,
 	.set_rate	= sh_clk_div4_set_rate,
 	.round_rate	= sh_clk_div_round_rate,
@@ -331,7 +331,7 @@ static struct clk_ops sh_clk_div4_enable
 	.disable	= sh_clk_div4_disable,
 };
 
-static struct clk_ops sh_clk_div4_reparent_clk_ops = {
+static struct sh_clk_ops sh_clk_div4_reparent_clk_ops = {
 	.recalc		= sh_clk_div4_recalc,
 	.set_rate	= sh_clk_div4_set_rate,
 	.round_rate	= sh_clk_div_round_rate,
@@ -341,7 +341,7 @@ static struct clk_ops sh_clk_div4_repare
 };
 
 static int __init sh_clk_div4_register_ops(struct clk *clks, int nr,
-			struct clk_div4_table *table, struct clk_ops *ops)
+			struct clk_div4_table *table, struct sh_clk_ops *ops)
 {
 	struct clk *clkp;
 	void *freq_table;
