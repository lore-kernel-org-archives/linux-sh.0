From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 31 Jul 2011 17:51:37 +0000
Subject: [PATCH 7/9] PM / Domains: Rename GPD_STATE_WAIT_PARENT to GPD_STATE_WAIT_MASTER
Message-Id: <201107311951.37713.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201107311946.06654.rjw@sisk.pl>
In-Reply-To: <201107311946.06654.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since it is now possible for a PM domain to have multiple masters
instead of one parent, rename the "wait for parent" status to reflect
the new situation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   34 +++++++++++++++++-----------------
 include/linux/pm_domain.h   |    2 +-
 2 files changed, 18 insertions(+), 18 deletions(-)

Index: linux-2.6/drivers/base/power/domain.c
=================================--- linux-2.6.orig/drivers/base/power/domain.c
+++ linux-2.6/drivers/base/power/domain.c
@@ -98,7 +98,7 @@ int __pm_genpd_poweron(struct generic_pm
 	for (;;) {
 		prepare_to_wait(&genpd->status_wait_queue, &wait,
 				TASK_UNINTERRUPTIBLE);
-		if (genpd->status != GPD_STATE_WAIT_PARENT)
+		if (genpd->status != GPD_STATE_WAIT_MASTER)
 			break;
 		mutex_unlock(&genpd->lock);
 
@@ -124,7 +124,7 @@ int __pm_genpd_poweron(struct generic_pm
 	 */
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_inc(link->master);
-		genpd->status = GPD_STATE_WAIT_PARENT;
+		genpd->status = GPD_STATE_WAIT_MASTER;
 
 		mutex_unlock(&genpd->lock);
 
@@ -258,7 +258,7 @@ static void __pm_genpd_restore_device(st
  */
 static bool genpd_abort_poweroff(struct generic_pm_domain *genpd)
 {
-	return genpd->status = GPD_STATE_WAIT_PARENT
+	return genpd->status = GPD_STATE_WAIT_MASTER
 		|| genpd->status = GPD_STATE_ACTIVE || genpd->resume_count > 0;
 }
 
@@ -300,7 +300,7 @@ static int pm_genpd_poweroff(struct gene
 	 * (4) System suspend is in progress.
 	 */
 	if (genpd->status = GPD_STATE_POWER_OFF
-	    || genpd->status = GPD_STATE_WAIT_PARENT
+	    || genpd->status = GPD_STATE_WAIT_MASTER
 	    || genpd->resume_count > 0 || genpd->prepared_count > 0)
 		return 0;
 
Index: linux-2.6/include/linux/pm_domain.h
=================================--- linux-2.6.orig/include/linux/pm_domain.h
+++ linux-2.6/include/linux/pm_domain.h
@@ -13,7 +13,7 @@
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-	GPD_STATE_WAIT_PARENT,	/* PM domain's parent is being waited for */
+	GPD_STATE_WAIT_MASTER,	/* PM domain's master is being waited for */
 	GPD_STATE_BUSY,		/* Something is happening to the PM domain */
 	GPD_STATE_REPEAT,	/* Power off in progress, to be repeated */
 	GPD_STATE_POWER_OFF,	/* PM domain is off */

