From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 29 Jul 2012 14:13:39 +0000
Subject: [RFC][PATCH 1/6] PM / Domains: Introduce simplified power on routine for system resume
Message-Id: <201207291613.39334.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207291612.43138.rjw@sisk.pl>
In-Reply-To: <201207291612.43138.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>


Introduce function pm_genpd_sync_poweron() for restoring domain power
during resume from system suspend and hibernation.  It can be much
simpler than pm_genpd_poweron(), because it doesn't have to care
about locking and it can skip many checks done by the latter.

Modify pm_genpd_resume_noirq() and pm_genpd_restore_noirq() to use
the new function.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -777,6 +777,32 @@ static void pm_genpd_sync_poweroff(struc
 }
 
 /**
+ * pm_genpd_sync_poweron - Synchronously power on a PM domain and its masters.
+ * @genpd: PM domain to power on.
+ *
+ * This function is only called in "noirq" stage of system power transitions, so
+ * it need not acquire locks (all of the "noirq" callbacks are executed
+ * sequentially, so it is guaranteed that it will never run twice in parallel).
+ */
+static void pm_genpd_sync_poweron(struct generic_pm_domain *genpd)
+{
+	struct gpd_link *link;
+
+	if (genpd->status != GPD_STATE_POWER_OFF)
+		return;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		pm_genpd_sync_poweron(link->master);
+		genpd_sd_counter_inc(link->master);
+	}
+
+	if (genpd->power_on)
+		genpd->power_on(genpd);
+
+	genpd->status = GPD_STATE_ACTIVE;
+}
+
+/**
  * resume_needed - Check whether to resume a device before system suspend.
  * @dev: Device to check.
  * @genpd: PM domain the device belongs to.
@@ -979,7 +1005,7 @@ static int pm_genpd_resume_noirq(struct
 	 * guaranteed that this function will never run twice in parallel for
 	 * the same PM domain, so it is not necessary to use locking here.
 	 */
-	pm_genpd_poweron(genpd);
+	pm_genpd_sync_poweron(genpd);
 	genpd->suspended_count--;
 
 	return genpd_start_dev(genpd, dev);
@@ -1186,8 +1212,8 @@ static int pm_genpd_restore_noirq(struct
 	if (genpd->suspended_count++ = 0) {
 		/*
 		 * The boot kernel might put the domain into arbitrary state,
-		 * so make it appear as powered off to pm_genpd_poweron(), so
-		 * that it tries to power it on in case it was really off.
+		 * so make it appear as powered off to pm_genpd_sync_poweron(),
+		 * so that it tries to power it on in case it was really off.
 		 */
 		genpd->status = GPD_STATE_POWER_OFF;
 		if (genpd->suspend_power_off) {
@@ -1205,7 +1231,7 @@ static int pm_genpd_restore_noirq(struct
 	if (genpd->suspend_power_off)
 		return 0;
 
-	pm_genpd_poweron(genpd);
+	pm_genpd_sync_poweron(genpd);
 
 	return dev_gpd_data(dev)->always_on ? 0 : genpd_start_dev(genpd, dev);
 }

