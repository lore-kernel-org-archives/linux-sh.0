From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 27 May 2012 23:58:45 +0000
Subject: [PATCH] PM / Domains: Do not stop devices after restoring their states
Message-Id: <201205280158.45455.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

While resuming a device belonging to a PM domain,
pm_genpd_runtime_resume() calls __pm_genpd_restore_device() to
restore its state, if necessary.  The latter starts the device,
using genpd_start_dev(), restores its state, using
genpd_restore_dev(), and then stops it, using genpd_stop_dev().
However, this last operation is not necessary, because the
device is supposed to be operational after pm_genpd_runtime_resume()
has returned and because of it pm_genpd_runtime_resume() has to
call genpd_start_dev() once again for the "restored" device, which
is inefficient.

To make things more efficient, remove the call to genpd_stop_dev()
from __pm_genpd_restore_device() and the direct call to
genpd_start_dev() from pm_genpd_runtime_resume().  [Of course,
genpd_start_dev() still has to be called by it for devices with the
power.irq_safe flag set, because __pm_genpd_restore_device() is not
executed for them.]

This change has been tested on the SH7372 Mackerel board.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -363,19 +363,16 @@ static void __pm_genpd_restore_device(st
 {
 	struct generic_pm_domain_data *gpd_data = to_gpd_data(pdd);
 	struct device *dev = pdd->dev;
+	bool need_restore = gpd_data->need_restore;
 
-	if (!gpd_data->need_restore)
-		return;
-
+	gpd_data->need_restore = false;
 	mutex_unlock(&genpd->lock);
 
 	genpd_start_dev(genpd, dev);
-	genpd_restore_dev(genpd, dev);
-	genpd_stop_dev(genpd, dev);
+	if (need_restore)
+		genpd_restore_dev(genpd, dev);
 
 	mutex_lock(&genpd->lock);
-
-	gpd_data->need_restore = false;
 }
 
 /**
@@ -638,7 +635,7 @@ static int pm_genpd_runtime_resume(struc
 
 	/* If power.irq_safe, the PM domain is never powered off. */
 	if (dev->power.irq_safe)
-		goto out;
+		return genpd_start_dev(genpd, dev);
 
 	mutex_lock(&genpd->lock);
 	ret = __pm_genpd_poweron(genpd);
@@ -671,9 +668,6 @@ static int pm_genpd_runtime_resume(struc
 	wake_up_all(&genpd->status_wait_queue);
 	mutex_unlock(&genpd->lock);
 
- out:
-	genpd_start_dev(genpd, dev);
-
 	return 0;
 }
 
