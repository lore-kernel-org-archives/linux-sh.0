From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 25 Jun 2011 21:30:05 +0000
Subject: [PATCH 8/10 v6] PM: Allow the clocks management code to be used during system suspend
Message-Id: <201106252330.05596.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
In-Reply-To: <201106252324.13454.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

The common clocks management code in drivers/base/power/clock_ops.c
is going to be used during system-wide power transitions as well as
for runtime PM, so it shouldn't depend on CONFIG_PM_RUNTIME.
However, the suspend/resume functions provided by it for
CONFIG_PM_RUNTIME unset, to be used during system-wide power
transitions, should not behave in the same way as their counterparts
defined for CONFIG_PM_RUNTIME set, because in that case the clocks
are managed differently at run time.

The names of the functions still contain the word "runtime" after
this change, but that is going to be modified by a separate patch
later.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/clock_ops.c |   60 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/pm_runtime.h     |    2 -
 kernel/power/Kconfig           |    4 +-
 3 files changed, 62 insertions(+), 4 deletions(-)

Index: linux-2.6/include/linux/pm_runtime.h
=================================--- linux-2.6.orig/include/linux/pm_runtime.h
+++ linux-2.6/include/linux/pm_runtime.h
@@ -251,7 +251,7 @@ struct pm_clk_notifier_block {
 	char *con_ids[];
 };
 
-#ifdef CONFIG_PM_RUNTIME_CLK
+#ifdef CONFIG_PM_CLK
 extern int pm_runtime_clk_init(struct device *dev);
 extern void pm_runtime_clk_destroy(struct device *dev);
 extern int pm_runtime_clk_add(struct device *dev, const char *con_id);
Index: linux-2.6/kernel/power/Kconfig
=================================--- linux-2.6.orig/kernel/power/Kconfig
+++ linux-2.6/kernel/power/Kconfig
@@ -224,9 +224,9 @@ config PM_OPP
 	  implementations a ready to use framework to manage OPPs.
 	  For more information, read <file:Documentation/power/opp.txt>
 
-config PM_RUNTIME_CLK
+config PM_CLK
 	def_bool y
-	depends on PM_RUNTIME && HAVE_CLK
+	depends on PM && HAVE_CLK
 
 config PM_GENERIC_DOMAINS
 	bool
Index: linux-2.6/drivers/base/power/clock_ops.c
=================================--- linux-2.6.orig/drivers/base/power/clock_ops.c
+++ linux-2.6/drivers/base/power/clock_ops.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 
-#ifdef CONFIG_PM_RUNTIME
+#ifdef CONFIG_PM
 
 struct pm_runtime_clk_data {
 	struct list_head clock_list;
@@ -191,6 +191,10 @@ void pm_runtime_clk_destroy(struct devic
 	kfree(prd);
 }
 
+#endif /* CONFIG_PM */
+
+#ifdef CONFIG_PM_RUNTIME
+
 /**
  * pm_runtime_clk_acquire - Acquire a device clock.
  * @dev: Device whose clock is to be acquired.
@@ -330,6 +334,60 @@ static int pm_runtime_clk_notify(struct
 
 #else /* !CONFIG_PM_RUNTIME */
 
+#ifdef CONFIG_PM
+
+/**
+ * pm_runtime_clk_suspend - Disable clocks in a device's PM clock list.
+ * @dev: Device to disable the clocks for.
+ */
+int pm_runtime_clk_suspend(struct device *dev)
+{
+	struct pm_runtime_clk_data *prd = __to_prd(dev);
+	struct pm_clock_entry *ce;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	/* If there is no driver, the clocks are already disabled. */
+	if (!prd || !dev->driver)
+		return 0;
+
+	mutex_lock(&prd->lock);
+
+	list_for_each_entry_reverse(ce, &prd->clock_list, node)
+		clk_disable(ce->clk);
+
+	mutex_unlock(&prd->lock);
+
+	return 0;
+}
+
+/**
+ * pm_runtime_clk_resume - Enable clocks in a device's PM clock list.
+ * @dev: Device to enable the clocks for.
+ */
+int pm_runtime_clk_resume(struct device *dev)
+{
+	struct pm_runtime_clk_data *prd = __to_prd(dev);
+	struct pm_clock_entry *ce;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	/* If there is no driver, the clocks should remain disabled. */
+	if (!prd || !dev->driver)
+		return 0;
+
+	mutex_lock(&prd->lock);
+
+	list_for_each_entry(ce, &prd->clock_list, node)
+		clk_enable(ce->clk);
+
+	mutex_unlock(&prd->lock);
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 /**
  * enable_clock - Enable a device clock.
  * @dev: Device whose clock is to be enabled.

