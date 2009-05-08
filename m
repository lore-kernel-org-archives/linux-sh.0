From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 May 2009 08:23:29 +0000
Subject: [PATCH] sh: clock framework update, fix count and kill off kref
Message-Id: <20090508082329.30220.74580.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the clock framework use count code.
With this patch the enable() and disable() callbacks
only get called when counting from and to zero.
While at it the kref stuff gets replaced with an int.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/clock.h |    4 +-
 arch/sh/kernel/cpu/clock.c  |   69 +++++++++++++++++++++++--------------------
 2 files changed, 39 insertions(+), 34 deletions(-)

--- 0001/arch/sh/include/asm/clock.h
+++ work/arch/sh/include/asm/clock.h	2009-05-08 15:36:21.000000000 +0900
@@ -1,7 +1,6 @@
 #ifndef __ASM_SH_CLOCK_H
 #define __ASM_SH_CLOCK_H
 
-#include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/seq_file.h>
 #include <linux/clk.h>
@@ -28,7 +27,7 @@ struct clk {
 	struct clk		*parent;
 	struct clk_ops		*ops;
 
-	struct kref		kref;
+	int			usecount;
 
 	unsigned long		rate;
 	unsigned long		flags;
@@ -37,6 +36,7 @@ struct clk {
 
 #define CLK_ALWAYS_ENABLED	(1 << 0)
 #define CLK_RATE_PROPAGATES	(1 << 1)
+#define CLK_NEEDS_INIT		(1 << 2)
 
 /* Should be defined by processor-specific code */
 void arch_init_clk_ops(struct clk_ops **, int type);
--- 0003/arch/sh/kernel/cpu/clock.c
+++ work/arch/sh/kernel/cpu/clock.c	2009-05-08 15:36:21.000000000 +0900
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
-#include <linux/kref.h>
 #include <linux/kobject.h>
 #include <linux/sysdev.h>
 #include <linux/seq_file.h>
@@ -90,7 +89,7 @@ static void propagate_rate(struct clk *c
 	}
 }
 
-static int __clk_enable(struct clk *clk)
+static void __clk_init(struct clk *clk)
 {
 	/*
 	 * See if this is the first time we're enabling the clock, some
@@ -100,19 +99,33 @@ static int __clk_enable(struct clk *clk)
 	 * divisors to use before it can effectively recalc.
 	 */
 
-	if (clk->flags & CLK_ALWAYS_ENABLED) {
-		kref_get(&clk->kref);
-		return 0;
-	}
-
-	if (unlikely(atomic_read(&clk->kref.refcount) = 1))
+	if (clk->flags & CLK_NEEDS_INIT) {
 		if (clk->ops && clk->ops->init)
 			clk->ops->init(clk);
 
-	kref_get(&clk->kref);
+		clk->flags &= ~CLK_NEEDS_INIT;
+	}
+}
+
+static int __clk_enable(struct clk *clk)
+{
+	if (!clk)
+		return -EINVAL;
+
+	clk->usecount++;
+
+	/* nothing to do if always enabled */
+	if (clk->flags & CLK_ALWAYS_ENABLED)
+		return 0;
+
+	if (clk->usecount = 1) {
+		__clk_init(clk);
 
-	if (likely(clk->ops && clk->ops->enable))
-		clk->ops->enable(clk);
+		__clk_enable(clk->parent);
+
+		if (clk->ops && clk->ops->enable)
+			clk->ops->enable(clk);
+	}
 
 	return 0;
 }
@@ -122,11 +135,6 @@ int clk_enable(struct clk *clk)
 	unsigned long flags;
 	int ret;
 
-	if (!clk)
-		return -EINVAL;
-
-	clk_enable(clk->parent);
-
 	spin_lock_irqsave(&clock_lock, flags);
 	ret = __clk_enable(clk);
 	spin_unlock_irqrestore(&clock_lock, flags);
@@ -135,21 +143,23 @@ int clk_enable(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_enable);
 
-static void clk_kref_release(struct kref *kref)
-{
-	/* Nothing to do */
-}
-
 static void __clk_disable(struct clk *clk)
 {
-	int count = kref_put(&clk->kref, clk_kref_release);
+	if (!clk)
+		return;
+
+	clk->usecount--;
+
+	WARN_ON(clk->usecount < 0);
 
 	if (clk->flags & CLK_ALWAYS_ENABLED)
 		return;
 
-	if (!count) {	/* count reaches zero, disable the clock */
+	if (clk->usecount = 0) {
 		if (likely(clk->ops && clk->ops->disable))
 			clk->ops->disable(clk);
+
+		__clk_disable(clk->parent);
 	}
 }
 
@@ -157,14 +167,9 @@ void clk_disable(struct clk *clk)
 {
 	unsigned long flags;
 
-	if (!clk)
-		return;
-
 	spin_lock_irqsave(&clock_lock, flags);
 	__clk_disable(clk);
 	spin_unlock_irqrestore(&clock_lock, flags);
-
-	clk_disable(clk->parent);
 }
 EXPORT_SYMBOL_GPL(clk_disable);
 
@@ -173,14 +178,14 @@ int clk_register(struct clk *clk)
 	mutex_lock(&clock_list_sem);
 
 	list_add(&clk->node, &clock_list);
-	kref_init(&clk->kref);
+	clk->usecount = 0;
+	clk->flags |= CLK_NEEDS_INIT;
 
 	mutex_unlock(&clock_list_sem);
 
 	if (clk->flags & CLK_ALWAYS_ENABLED) {
+		__clk_init(clk);
 		pr_debug( "Clock '%s' is ALWAYS_ENABLED\n", clk->name);
-		if (clk->ops && clk->ops->init)
-			clk->ops->init(clk);
 		if (clk->ops && clk->ops->enable)
 			clk->ops->enable(clk);
 		pr_debug( "Enabled.");
@@ -356,7 +361,7 @@ static int show_clocks(char *buf, char *
 		p += sprintf(p, "%-12s\t: %ld.%02ldMHz\t%s\n", clk->name,
 			     rate / 1000000, (rate % 1000000) / 10000,
 			     ((clk->flags & CLK_ALWAYS_ENABLED) ||
-			      (atomic_read(&clk->kref.refcount) != 1)) ?
+			      clk->usecount > 0) ?
 			     "enabled" : "disabled");
 	}
 
