From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 05 Aug 2012 23:44:28 +0000
Subject: [PATCH 7/15] PM: Reorganize device PM initialization
Message-Id: <201208060144.29037.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl> <201208060138.03950.rjw@sisk.pl>
In-Reply-To: <201208060138.03950.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>


Make the device power management initialization more straightforward
by moving the initialization of common (i.e. used by both runtime PM
and system suspend) fields to a separate routine.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c  |    7 ++-----
 drivers/base/power/power.h |   22 +++++++++++++++-------
 2 files changed, 17 insertions(+), 12 deletions(-)

Index: linux/drivers/base/power/main.c
=================================--- linux.orig/drivers/base/power/main.c
+++ linux/drivers/base/power/main.c
@@ -57,20 +57,17 @@ static pm_message_t pm_transition;
 static int async_error;
 
 /**
- * device_pm_init - Initialize the PM-related part of a device object.
+ * device_pm_sleep_init - Initialize system suspend-related device fields.
  * @dev: Device object being initialized.
  */
-void device_pm_init(struct device *dev)
+void device_pm_sleep_init(struct device *dev)
 {
 	dev->power.is_prepared = false;
 	dev->power.is_suspended = false;
 	init_completion(&dev->power.completion);
 	complete_all(&dev->power.completion);
 	dev->power.wakeup = NULL;
-	spin_lock_init(&dev->power.lock);
-	pm_runtime_init(dev);
 	INIT_LIST_HEAD(&dev->power.entry);
-	dev->power.power_state = PMSG_INVALID;
 }
 
 /**
Index: linux/drivers/base/power/power.h
=================================--- linux.orig/drivers/base/power/power.h
+++ linux/drivers/base/power/power.h
@@ -1,5 +1,11 @@
 #include <linux/pm_qos.h>
 
+static inline void device_pm_init_common(struct device *dev)
+{
+	spin_lock_init(&dev->power.lock);
+	dev->power.power_state = PMSG_INVALID;
+}
+
 #ifdef CONFIG_PM_RUNTIME
 
 extern void pm_runtime_init(struct device *dev);
@@ -25,7 +31,7 @@ static inline struct device *to_device(s
 	return container_of(entry, struct device, power.entry);
 }
 
-extern void device_pm_init(struct device *dev);
+extern void device_pm_sleep_init(struct device *dev);
 extern void device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
 extern void device_pm_move_before(struct device *, struct device *);
@@ -34,12 +40,7 @@ extern void device_pm_move_last(struct d
 
 #else /* !CONFIG_PM_SLEEP */
 
-static inline void device_pm_init(struct device *dev)
-{
-	spin_lock_init(&dev->power.lock);
-	dev->power.power_state = PMSG_INVALID;
-	pm_runtime_init(dev);
-}
+static inline void device_pm_sleep_init(struct device *dev) {}
 
 static inline void device_pm_add(struct device *dev)
 {
@@ -60,6 +61,13 @@ static inline void device_pm_move_last(s
 
 #endif /* !CONFIG_PM_SLEEP */
 
+static inline void device_pm_init(struct device *dev)
+{
+	device_pm_init_common(dev);
+	device_pm_sleep_init(dev);
+	pm_runtime_init(dev);
+}
+
 #ifdef CONFIG_PM
 
 /*

