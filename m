From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:37:12 +0000
Subject: [PATCH 15/15] sh: remove unused clock lookup
Message-Id: <20100511093712.28210.92591.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Now when all clocks are registered using clkdev,
get rid of the special SH-specific clock lookup.

Also ditch the unused module ref counting code.
This patch syncs the SH behaviour with ARM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h |    1 -
 arch/sh/kernel/cpu/clock.c  |   37 ++-----------------------------------
 2 files changed, 2 insertions(+), 36 deletions(-)

--- 0011/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2010-05-10 19:50:07.000000000 +0900
@@ -23,7 +23,6 @@ struct clk {
 	struct list_head	node;
 	const char		*name;
 	int			id;
-	struct module		*owner;
 
 	struct clk		*parent;
 	struct clk_ops		*ops;
--- 0006/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2010-05-10 19:49:41.000000000 +0900
@@ -398,49 +398,16 @@ EXPORT_SYMBOL_GPL(clk_round_rate);
  * Returns a clock. Note that we first try to use device id on the bus
  * and clock name. If this fails, we try to use clock name only.
  */
-struct clk *clk_get(struct device *dev, const char *id)
+struct clk *clk_get(struct device *dev, const char *con_id)
 {
 	const char *dev_id = dev ? dev_name(dev) : NULL;
-	struct clk *p, *clk = ERR_PTR(-ENOENT);
-	int idno;
 
-	clk = clk_get_sys(dev_id, id);
-	if (clk && !IS_ERR(clk))
-		return clk;
-
-	if (dev = NULL || dev->bus != &platform_bus_type)
-		idno = -1;
-	else
-		idno = to_platform_device(dev)->id;
-
-	mutex_lock(&clock_list_sem);
-	list_for_each_entry(p, &clock_list, node) {
-		if (p->name && p->id = idno &&
-		    strcmp(id, p->name) = 0 && try_module_get(p->owner)) {
-			clk = p;
-			goto found;
-		}
-	}
-
-	list_for_each_entry(p, &clock_list, node) {
-		if (p->name &&
-		    strcmp(id, p->name) = 0 && try_module_get(p->owner)) {
-			clk = p;
-			break;
-		}
-	}
-
-found:
-	mutex_unlock(&clock_list_sem);
-
-	return clk;
+	return clk_get_sys(dev_id, con_id);
 }
 EXPORT_SYMBOL_GPL(clk_get);
 
 void clk_put(struct clk *clk)
 {
-	if (clk && !IS_ERR(clk))
-		module_put(clk->owner);
 }
 EXPORT_SYMBOL_GPL(clk_put);
 
