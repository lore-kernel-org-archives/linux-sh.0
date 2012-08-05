From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 05 Aug 2012 23:45:11 +0000
Subject: [PATCH 8/15] PM / Runtime: Allow helpers to be called by early platform drivers
Message-Id: <201208060145.11549.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl> <201208060138.03950.rjw@sisk.pl>
In-Reply-To: <201208060138.03950.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>


Runtime PM helper functions, like pm_runtime_get_sync(), cannot be
called by early platform device drivers, because the devices' power
management locks are not initialized at that time.  This is quite
inconvenient, so modify early_platform_add_devices() to initialize
the devices power management locks as appropriate and make sure that
they won't be initialized more than once if an early platform
device is going to be used as a regular one later.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/platform.c    |    2 ++
 drivers/base/power/power.h |   18 ++++++++++++++++--
 include/linux/pm.h         |    1 +
 3 files changed, 19 insertions(+), 2 deletions(-)

Index: linux/drivers/base/power/power.h
=================================--- linux.orig/drivers/base/power/power.h
+++ linux/drivers/base/power/power.h
@@ -2,17 +2,31 @@
 
 static inline void device_pm_init_common(struct device *dev)
 {
-	spin_lock_init(&dev->power.lock);
-	dev->power.power_state = PMSG_INVALID;
+	if (!dev->power.early_init) {
+		spin_lock_init(&dev->power.lock);
+		dev->power.power_state = PMSG_INVALID;
+		dev->power.early_init = true;
+	}
 }
 
 #ifdef CONFIG_PM_RUNTIME
 
+static inline void pm_runtime_early_init(struct device *dev)
+{
+	dev->power.disable_depth = 1;
+	device_pm_init_common(dev);
+}
+
 extern void pm_runtime_init(struct device *dev);
 extern void pm_runtime_remove(struct device *dev);
 
 #else /* !CONFIG_PM_RUNTIME */
 
+static inline void pm_runtime_early_init(struct device *dev)
+{
+	device_pm_init_common(dev);
+}
+
 static inline void pm_runtime_init(struct device *dev) {}
 static inline void pm_runtime_remove(struct device *dev) {}
 
Index: linux/include/linux/pm.h
=================================--- linux.orig/include/linux/pm.h
+++ linux/include/linux/pm.h
@@ -510,6 +510,7 @@ struct dev_pm_info {
 	bool			is_prepared:1;	/* Owned by the PM core */
 	bool			is_suspended:1;	/* Ditto */
 	bool			ignore_children:1;
+	bool			early_init:1;	/* Owned by the PM core */
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
 	struct list_head	entry;
Index: linux/drivers/base/platform.c
=================================--- linux.orig/drivers/base/platform.c
+++ linux/drivers/base/platform.c
@@ -22,6 +22,7 @@
 #include <linux/pm_runtime.h>
 
 #include "base.h"
+#include "power/power.h"
 
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
 				 driver))
@@ -948,6 +949,7 @@ void __init early_platform_add_devices(s
 		dev = &devs[i]->dev;
 
 		if (!dev->devres_head.next) {
+			pm_runtime_early_init(dev);
 			INIT_LIST_HEAD(&dev->devres_head);
 			list_add_tail(&dev->devres_head,
 				      &early_platform_device_list);

