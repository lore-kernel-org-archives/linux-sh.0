From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 04 May 2010 14:15:09 +0000
Subject: [PATCH] sh: simplify WARN usage in SH clock driver
Message-Id: <Pine.LNX.4.64.1005041613210.4925@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/sh/clk.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/sh/clk.c b/drivers/sh/clk.c
index f8c1740..b0cfb75 100644
--- a/drivers/sh/clk.c
+++ b/drivers/sh/clk.c
@@ -163,12 +163,9 @@ void propagate_rate(struct clk *tclk)
 
 static void __clk_disable(struct clk *clk)
 {
-	if (clk->usecount = 0) {
-		printk(KERN_ERR "Trying disable clock %s with 0 usecount\n",
-		       clk->name);
-		WARN_ON(1);
+	if (WARN(!clk->usecount, "Trying to disable clock %s with 0 usecount\n",
+		 clk->name))
 		return;
-	}
 
 	if (!(--clk->usecount)) {
 		if (likely(clk->ops && clk->ops->disable))
-- 
1.6.2.4

