From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 24 Sep 2011 13:07:07 +0000
Subject: Re: [BUG] on sh7372 (mackerel) with today's Linus' (github) master
Message-Id: <201109241507.07990.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1109231012490.25166@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1109231012490.25166@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Saturday, September 24, 2011, Russell King - ARM Linux wrote:
> On Sat, Sep 24, 2011 at 12:58:37AM +0200, Rafael J. Wysocki wrote:
> > Well, since nobody seems to execute anything that may sleep under
> > clocks_mutex, perhaps we can do something like this:
> 
> No - a spinlock prevents preemption, a mutex does not.
> 
> It's runtime PM which is doing stuff wrong here.  You're not supposed to
> give up the clk struct with it enabled.

OK, so below is a fix confined to clock_ops.c.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: PM / Clocks: Do not acquire a mutex under a spinlock

Commit b7ab83e (PM: Use spinlock instead of mutex in clock
management functions) introduced a regression causing clocks_mutex
to be acquired under a spinlock.  This happens because
pm_clk_suspend() and pm_clk_resume() call pm_clk_acquire() under
pcd->lock, but pm_clk_acquire() executes clk_get() which causes
clocks_mutex to be acquired.  Similarly, __pm_clk_remove(),
executed under pcd->lock, calls clk_put(), which also causes
clocks_mutex to be acquired.

To fix those problems make pm_clk_add() call pm_clk_acquire(), so
that pm_clk_suspend() and pm_clk_resume() don't have to do that.
Change pm_clk_remove() and pm_clk_destroy() to separate
modifications of the pcd->clock_list list from the actual removal of
PM clock entry objects done by __pm_clk_remove().

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/clock_ops.c |   75 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

Index: linux/drivers/base/power/clock_ops.c
=================================--- linux.orig/drivers/base/power/clock_ops.c
+++ linux/drivers/base/power/clock_ops.c
@@ -42,6 +42,22 @@ static struct pm_clk_data *__to_pcd(stru
 }
 
 /**
+ * pm_clk_acquire - Acquire a device clock.
+ * @dev: Device whose clock is to be acquired.
+ * @ce: PM clock entry corresponding to the clock.
+ */
+static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
+{
+	ce->clk = clk_get(dev, ce->con_id);
+	if (IS_ERR(ce->clk)) {
+		ce->status = PCE_STATUS_ERROR;
+	} else {
+		ce->status = PCE_STATUS_ACQUIRED;
+		dev_dbg(dev, "Clock %s managed by runtime PM.\n", ce->con_id);
+	}
+}
+
+/**
  * pm_clk_add - Start using a device clock for power management.
  * @dev: Device whose clock is going to be used for power management.
  * @con_id: Connection ID of the clock.
@@ -73,6 +89,8 @@ int pm_clk_add(struct device *dev, const
 		}
 	}
 
+	pm_clk_acquire(dev, ce);
+
 	spin_lock_irq(&pcd->lock);
 	list_add_tail(&ce->node, &pcd->clock_list);
 	spin_unlock_irq(&pcd->lock);
@@ -82,17 +100,12 @@ int pm_clk_add(struct device *dev, const
 /**
  * __pm_clk_remove - Destroy PM clock entry.
  * @ce: PM clock entry to destroy.
- *
- * This routine must be called under the spinlock protecting the PM list of
- * clocks corresponding the the @ce's device.
  */
 static void __pm_clk_remove(struct pm_clock_entry *ce)
 {
 	if (!ce)
 		return;
 
-	list_del(&ce->node);
-
 	if (ce->status < PCE_STATUS_ERROR) {
 		if (ce->status = PCE_STATUS_ENABLED)
 			clk_disable(ce->clk);
@@ -126,18 +139,22 @@ void pm_clk_remove(struct device *dev, c
 	spin_lock_irq(&pcd->lock);
 
 	list_for_each_entry(ce, &pcd->clock_list, node) {
-		if (!con_id && !ce->con_id) {
-			__pm_clk_remove(ce);
-			break;
-		} else if (!con_id || !ce->con_id) {
+		if (!con_id && !ce->con_id)
+			goto remove;
+		else if (!con_id || !ce->con_id)
 			continue;
-		} else if (!strcmp(con_id, ce->con_id)) {
-			__pm_clk_remove(ce);
-			break;
-		}
+		else if (!strcmp(con_id, ce->con_id))
+			goto remove;
 	}
 
 	spin_unlock_irq(&pcd->lock);
+	return;
+
+ remove:
+	list_del(&ce->node);
+	spin_unlock_irq(&pcd->lock);
+
+	__pm_clk_remove(ce);
 }
 
 /**
@@ -175,20 +192,27 @@ void pm_clk_destroy(struct device *dev)
 {
 	struct pm_clk_data *pcd = __to_pcd(dev);
 	struct pm_clock_entry *ce, *c;
+	struct list_head list;
 
 	if (!pcd)
 		return;
 
 	dev->power.subsys_data = NULL;
+	INIT_LIST_HEAD(&list);
 
 	spin_lock_irq(&pcd->lock);
 
 	list_for_each_entry_safe_reverse(ce, c, &pcd->clock_list, node)
-		__pm_clk_remove(ce);
+		list_move(&ce->node, &list);
 
 	spin_unlock_irq(&pcd->lock);
 
 	kfree(pcd);
+
+	list_for_each_entry_safe_reverse(ce, c, &list, node) {
+		list_del(&ce->node);
+		__pm_clk_remove(ce);
+	}
 }
 
 #endif /* CONFIG_PM */
@@ -196,23 +220,6 @@ void pm_clk_destroy(struct device *dev)
 #ifdef CONFIG_PM_RUNTIME
 
 /**
- * pm_clk_acquire - Acquire a device clock.
- * @dev: Device whose clock is to be acquired.
- * @con_id: Connection ID of the clock.
- */
-static void pm_clk_acquire(struct device *dev,
-				    struct pm_clock_entry *ce)
-{
-	ce->clk = clk_get(dev, ce->con_id);
-	if (IS_ERR(ce->clk)) {
-		ce->status = PCE_STATUS_ERROR;
-	} else {
-		ce->status = PCE_STATUS_ACQUIRED;
-		dev_dbg(dev, "Clock %s managed by runtime PM.\n", ce->con_id);
-	}
-}
-
-/**
  * pm_clk_suspend - Disable clocks in a device's PM clock list.
  * @dev: Device to disable the clocks for.
  */
@@ -230,9 +237,6 @@ int pm_clk_suspend(struct device *dev)
 	spin_lock_irqsave(&pcd->lock, flags);
 
 	list_for_each_entry_reverse(ce, &pcd->clock_list, node) {
-		if (ce->status = PCE_STATUS_NONE)
-			pm_clk_acquire(dev, ce);
-
 		if (ce->status < PCE_STATUS_ERROR) {
 			clk_disable(ce->clk);
 			ce->status = PCE_STATUS_ACQUIRED;
@@ -262,9 +266,6 @@ int pm_clk_resume(struct device *dev)
 	spin_lock_irqsave(&pcd->lock, flags);
 
 	list_for_each_entry(ce, &pcd->clock_list, node) {
-		if (ce->status = PCE_STATUS_NONE)
-			pm_clk_acquire(dev, ce);
-
 		if (ce->status < PCE_STATUS_ERROR) {
 			clk_enable(ce->clk);
 			ce->status = PCE_STATUS_ENABLED;
