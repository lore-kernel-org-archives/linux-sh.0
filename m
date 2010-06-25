From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Jun 2010 07:20:29 +0000
Subject: [PATCH] sh: move a debug printk() to a more meaningful location in
Message-Id: <Pine.LNX.4.64.1006250919410.1223@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To actually output the _new_ clock rate it first has to be set.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/sh/clk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/clk.c b/drivers/sh/clk.c
index 691f829..cede14e 100644
--- a/drivers/sh/clk.c
+++ b/drivers/sh/clk.c
@@ -341,10 +341,10 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 			ret = clk_reparent(clk, parent);
 
 		if (ret = 0) {
-			pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
-				 clk->name, clk->parent->name, clk->rate);
 			if (clk->ops->recalc)
 				clk->rate = clk->ops->recalc(clk);
+			pr_debug("clock: set parent of %s to %s (new rate %ld)\n",
+				 clk->name, clk->parent->name, clk->rate);
 			propagate_rate(clk);
 		}
 	} else
-- 
1.6.2.4

