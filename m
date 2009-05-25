From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 May 2009 08:10:45 +0000
Subject: [PATCH 04/04] sh: remove clk_ops->build_rate_table()
Message-Id: <20090525081045.7893.62851.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes the ->build_rate_table() callback,
->recalc() may instead be used for this purpose.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 For the clkfwk topic branch.

 arch/sh/include/asm/clock.h |    1 -
 arch/sh/kernel/cpu/clock.c  |    2 --
 2 files changed, 3 deletions(-)

--- 0003/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2009-05-25 16:23:49.000000000 +0900
@@ -16,7 +16,6 @@ struct clk_ops {
 	int (*set_rate)(struct clk *clk, unsigned long rate, int algo_id);
 	int (*set_parent)(struct clk *clk, struct clk *parent);
 	long (*round_rate)(struct clk *clk, unsigned long rate);
-	void (*build_rate_table)(struct clk *clk);
 };
 
 struct clk {
--- 0003/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2009-05-25 16:23:35.000000000 +0900
@@ -138,8 +138,6 @@ void propagate_rate(struct clk *tclk)
 	list_for_each_entry(clkp, &tclk->children, sibling) {
 		if (clkp->ops && clkp->ops->recalc)
 			clkp->rate = clkp->ops->recalc(clkp);
-		if (clkp->ops && clkp->ops->build_rate_table)
-			clkp->ops->build_rate_table(clkp);
 
 		propagate_rate(clkp);
 	}
