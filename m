From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 06 Aug 2012 23:11:14 +0000
Subject: [PATCH 7/12] PM / Domains: Add power-on function using names to identify domains
Message-Id: <201208070111.15171.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201208070105.23262.rjw@sisk.pl>
In-Reply-To: <201208070105.23262.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


It sometimes is necessary to turn on a given PM domain when only
the name of it is known and the domain pointer is not readily
available.  For this reason, add a new helper function,
pm_genpd_name_poweron(), allowing the caller to turn on a PM domain
using its name for identification.  To avoid code duplication,
move the domain lookup code to a separate function.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   46 +++++++++++++++++++++++++++++---------------
 include/linux/pm_domain.h   |    5 ++++
 2 files changed, 36 insertions(+), 15 deletions(-)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -53,6 +53,24 @@
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
+static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
+{
+	struct generic_pm_domain *genpd = NULL, *gpd;
+
+	if (IS_ERR_OR_NULL(domain_name))
+		return NULL;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+		if (!strcmp(gpd->name, domain_name)) {
+			genpd = gpd;
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+	return genpd;
+}
+
 #ifdef CONFIG_PM
 
 struct generic_pm_domain *dev_to_genpd(struct device *dev)
@@ -262,6 +280,18 @@ int pm_genpd_poweron(struct generic_pm_d
 	return ret;
 }
 
+/**
+ * pm_genpd_name_poweron - Restore power to a given PM domain and its masters.
+ * @domain_name: Name of the PM domain to power up.
+ */
+int pm_genpd_name_poweron(const char *domain_name)
+{
+	struct generic_pm_domain *genpd;
+
+	genpd = pm_genpd_lookup_name(domain_name);
+	return genpd ? pm_genpd_poweron(genpd) : -EINVAL;
+}
+
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_RUNTIME
@@ -1475,21 +1505,7 @@ int __pm_genpd_of_add_device(struct devi
 int __pm_genpd_name_add_device(const char *domain_name, struct device *dev,
 			       struct gpd_timing_data *td)
 {
-	struct generic_pm_domain *genpd = NULL, *gpd;
-
-	if (IS_ERR_OR_NULL(domain_name) || IS_ERR_OR_NULL(dev))
-		return -EINVAL;
-
-	mutex_lock(&gpd_list_lock);
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
-		if (!strcmp(gpd->name, domain_name)) {
-			genpd = gpd;
-			break;
-		}
-	}
-	mutex_unlock(&gpd_list_lock);
-
-	return __pm_genpd_add_device(genpd, dev, td);
+	return __pm_genpd_add_device(pm_genpd_lookup_name(domain_name), dev, td);
 }
 
 /**
Index: linux/include/linux/pm_domain.h
=================================--- linux.orig/include/linux/pm_domain.h
+++ linux/include/linux/pm_domain.h
@@ -161,6 +161,7 @@ extern void pm_genpd_init(struct generic
 			  struct dev_power_governor *gov, bool is_off);
 
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
+extern int pm_genpd_name_poweron(const char *domain_name);
 
 extern bool default_stop_ok(struct device *dev);
 
@@ -239,6 +240,10 @@ static inline int pm_genpd_poweron(struc
 {
 	return -ENOSYS;
 }
+static inline int pm_genpd_name_poweron(const char *domain_name)
+{
+	return -ENOSYS;
+}
 static inline bool default_stop_ok(struct device *dev)
 {
 	return false;

