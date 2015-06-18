From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 18 Jun 2015 10:22:34 +0000
Subject: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Message-Id: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
up with an infinite loop in genpd_dev_pm_{at,de}tach().

This may happen due to a genpd.prepared_count imbalance.  This is a bug
elsewhere, but it will result in a system lock up, possibly during
reboot of an otherwise functioning system.

To avoid this, put a limit on the maximum number of loop iterations,
including a simple back-off mechanism.  If the limit is reached, the
operation will just fail.  An error message is already printed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/domain.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cdd547bd67df8218..aa06f60b98b8af35 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -6,6 +6,7 @@
  * This file is released under the GPLv2.
  */
 
+#include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -19,6 +20,9 @@
 #include <linux/suspend.h>
 #include <linux/export.h>
 
+#define GENPD_RETRIES	20
+#define GENPD_DELAY_US	10
+
 #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
 ({								\
 	type (*__routine)(struct device *__d); 			\
@@ -2131,6 +2135,7 @@ EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 {
 	struct generic_pm_domain *pd;
+	unsigned int i;
 	int ret = 0;
 
 	pd = pm_genpd_lookup_dev(dev);
@@ -2139,10 +2144,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
 
 	dev_dbg(dev, "removing from PM domain %s\n", pd->name);
 
-	while (1) {
+	for (i = 0; i < GENPD_RETRIES; i++) {
 		ret = pm_genpd_remove_device(pd, dev);
 		if (ret != -EAGAIN)
 			break;
+
+		if (i > GENPD_RETRIES / 2)
+			udelay(GENPD_DELAY_US);
 		cond_resched();
 	}
 
@@ -2218,10 +2226,13 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	dev_dbg(dev, "adding to PM domain %s\n", pd->name);
 
-	while (1) {
+	for (i = 0; i < GENPD_RETRIES; i++) {
 		ret = pm_genpd_add_device(pd, dev);
 		if (ret != -EAGAIN)
 			break;
+
+		if (i > GENPD_RETRIES / 2)
+			udelay(GENPD_DELAY_US);
 		cond_resched();
 	}
 
-- 
1.9.1

