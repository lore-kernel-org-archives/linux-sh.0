From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 Sep 2010 09:25:10 +0000
Subject: [PATCH] sh: fix a kfree address in clkdev code
Message-Id: <Pine.LNX.4.64.1009171124350.4988@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

kfree() in clkdev_drop() function should actually be called with an address of
a struct clk_lookup_alloc object, and not struct clk_lookup, as presently done.
This just happens to work, because "struct clk_lookup cl" is the first
member in struct clk_lookup_alloc.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/kernel/clkdev.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/clkdev.c b/arch/sh/kernel/clkdev.c
index befc255..1f800ef 100644
--- a/arch/sh/kernel/clkdev.c
+++ b/arch/sh/kernel/clkdev.c
@@ -161,9 +161,11 @@ EXPORT_SYMBOL(clk_add_alias);
  */
 void clkdev_drop(struct clk_lookup *cl)
 {
+	struct clk_lookup_alloc *cla = container_of(cl, struct clk_lookup_alloc, cl);
+
 	mutex_lock(&clocks_mutex);
 	list_del(&cl->node);
 	mutex_unlock(&clocks_mutex);
-	kfree(cl);
+	kfree(cla);
 }
 EXPORT_SYMBOL(clkdev_drop);
-- 
1.7.1

