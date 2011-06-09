From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jun 2011 09:13:39 +0000
Subject: [PATCH][RFC] drivers: sh: late disabling of clocks
Message-Id: <20110609091339.14510.31590.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This RFC patch kills two birds with one stone:

1) Fix existing issue where in-use clocks without software
   reference are disabled during boot. One example of this
   is the handling of the Mackerel serial console output.

2) Make sure so far unused clocks actually get turned off 

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/clk/core.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- 0001/drivers/sh/clk/core.c
+++ work/drivers/sh/clk/core.c	2011-06-09 14:13:02.000000000 +0900
@@ -34,6 +34,9 @@ static LIST_HEAD(clock_list);
 static DEFINE_SPINLOCK(clock_lock);
 static DEFINE_MUTEX(clock_list_sem);
 
+/* clock disable operations are not passed on to hardware during boot */
+static int allow_disable;
+
 void clk_rate_table_build(struct clk *clk,
 			  struct cpufreq_frequency_table *freq_table,
 			  int nr_freqs,
@@ -228,7 +231,7 @@ static void __clk_disable(struct clk *cl
 		return;
 
 	if (!(--clk->usecount)) {
-		if (likely(clk->ops && clk->ops->disable))
+		if (likely(allow_disable && clk->ops && clk->ops->disable))
 			clk->ops->disable(clk);
 		if (likely(clk->parent))
 			__clk_disable(clk->parent);
@@ -747,3 +750,24 @@ err_out:
 	return err;
 }
 late_initcall(clk_debugfs_init);
+
+static int __init clk_late_init(void)
+{
+	unsigned long flags;
+	struct clk *clk;
+
+	/* from now on allow clock disable operations */
+	allow_disable = 1;
+
+	/* disable all clocks with zero use count */
+	mutex_lock(&clock_list_sem);
+	list_for_each_entry(clk, &clock_list, node) {
+		spin_lock_irqsave(&clock_lock, flags);
+		if (!clk->usecount && clk->ops && clk->ops->disable)
+			clk->ops->disable(clk);
+		spin_unlock_irqrestore(&clock_lock, flags);
+	}
+	mutex_unlock(&clock_list_sem);
+	return 0;
+}
+late_initcall(clk_late_init);
