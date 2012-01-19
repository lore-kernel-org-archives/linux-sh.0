From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Jan 2012 09:00:40 +0000
Subject: [PATCH] sh: clkfwk: bugfix: use clk_reparent() for div6 clocks
Message-Id: <87aa5k6p8r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Various problems will happen if clk parent was set up directly.
it should use clk_reparent()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This is for linus/master

 drivers/sh/clk/cpg.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index 45fee36..92d314a 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -190,7 +190,7 @@ static int __init sh_clk_init_parent(struct clk *clk)
 		return -EINVAL;
 	}
 
-	clk->parent = clk->parent_table[val];
+	clk_reparent(clk, clk->parent_table[val]);
 	if (!clk->parent) {
 		pr_err("sh_clk_init_parent: unable to set parent");
 		return -EINVAL;
-- 
1.7.5.4

