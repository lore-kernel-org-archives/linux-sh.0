From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Oct 2010 07:44:36 +0000
Subject: [PATCH] sh: remove name and id from struct clk
Message-Id: <20101013074436.19791.66447.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Remove "name" and "id" from drivers/sh/ struct clk.

The struct clk members "name" and "id" are not used
now when matching is done through clkdev.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/clk-cpg.c   |    2 --
 drivers/sh/clk.c       |   14 ++++++--------
 include/linux/sh_clk.h |    3 ---
 3 files changed, 6 insertions(+), 13 deletions(-)

--- 0001/drivers/sh/clk-cpg.c
+++ work/drivers/sh/clk-cpg.c	2010-10-13 15:59:17.000000000 +0900
@@ -180,7 +180,6 @@ static int __init sh_clk_div6_register_o
 		clkp = clks + k;
 
 		clkp->ops = ops;
-		clkp->id = -1;
 		clkp->freq_table = freq_table + (k * freq_table_size);
 		clkp->freq_table[nr_divs].frequency = CPUFREQ_TABLE_END;
 
@@ -319,7 +318,6 @@ static int __init sh_clk_div4_register_o
 		clkp = clks + k;
 
 		clkp->ops = ops;
-		clkp->id = -1;
 		clkp->priv = table;
 
 		clkp->freq_table = freq_table + (k * freq_table_size);
--- 0001/drivers/sh/clk.c
+++ work/drivers/sh/clk.c	2010-10-13 15:58:42.000000000 +0900
@@ -160,8 +160,8 @@ void propagate_rate(struct clk *tclk)
 
 static void __clk_disable(struct clk *clk)
 {
-	if (WARN(!clk->usecount, "Trying to disable clock %s with 0 usecount\n",
-		 clk->name))
+	if (WARN(!clk->usecount, "Trying to disable clock %p with 0 usecount\n",
+		 clk))
 		return;
 
 	if (!(--clk->usecount)) {
@@ -354,8 +354,8 @@ int clk_set_parent(struct clk *clk, stru
 			ret = clk_reparent(clk, parent);
 
 		if (ret = 0) {
-			pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
-				 clk->name, clk->parent->name, clk->rate);
+			pr_debug("clock: set parent of %p to %p (new rate %ld)\n",
+				 clk, clk->parent, clk->rate);
 			if (clk->ops->recalc)
 				clk->rate = clk->ops->recalc(clk);
 			propagate_rate(clk);
@@ -469,9 +469,7 @@ static int clk_debugfs_register_one(stru
 	char s[255];
 	char *p = s;
 
-	p += sprintf(p, "%s", c->name);
-	if (c->id >= 0)
-		sprintf(p, ":%d", c->id);
+	p += sprintf(p, "%p", c);
 	d = debugfs_create_dir(s, pa ? pa->dentry : clk_debugfs_root);
 	if (!d)
 		return -ENOMEM;
@@ -513,7 +511,7 @@ static int clk_debugfs_register(struct c
 			return err;
 	}
 
-	if (!c->dentry && c->name) {
+	if (!c->dentry) {
 		err = clk_debugfs_register_one(c);
 		if (err)
 			return err;
--- 0001/include/linux/sh_clk.h
+++ work/include/linux/sh_clk.h	2010-10-13 15:55:08.000000000 +0900
@@ -21,9 +21,6 @@ struct clk_ops {
 
 struct clk {
 	struct list_head	node;
-	const char		*name;
-	int			id;
-
 	struct clk		*parent;
 	struct clk		**parent_table;	/* list of parents to */
 	unsigned short		parent_num;	/* choose between */
