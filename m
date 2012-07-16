From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 16 Jul 2012 21:17:11 +0000
Subject: [RFC][PATCH 1/14] PM / Domains: Make it possible to use domain names when adding devices
Message-Id: <201207162317.11591.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207032302.17805.rjw@sisk.pl> <201207052217.48086.rjw@sisk.pl> <201207162315.49073.rjw@sisk.pl>
In-Reply-To: <201207162315.49073.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>, Linux-sh list <linux-sh@vger.kernel.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Add a new helper function __pm_genpd_name_add_device() allowing
a device to be added to a (registered) generic PM domain identified
by name.  Add a wrapper around it, pm_genpd_name_add_device(),
passing NULL as the last argument and reorganize pm_domains.h for the
new functions to be defined consistently with the existing ones.

These functions are useful for adding devices to PM domains whose
representations are stored in tables, when the caller doesn't know
the index of the domain to add the device to, but it knows the
domain's name.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   27 +++++++++++++++++++++++++++
 include/linux/pm_domain.h   |   42 +++++++++++++++++++++++++++++-------------
 2 files changed, 56 insertions(+), 13 deletions(-)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -1399,6 +1399,33 @@ int __pm_genpd_of_add_device(struct devi
 	return __pm_genpd_add_device(genpd, dev, td);
 }
 
+
+/**
+ * __pm_genpd_name_add_device - Find I/O PM domain and add a device to it.
+ * @domain_name: Name of the PM domain to add the device to.
+ * @dev: Device to be added.
+ * @td: Set of PM QoS timing parameters to attach to the device.
+ */
+int __pm_genpd_name_add_device(const char *domain_name, struct device *dev,
+			       struct gpd_timing_data *td)
+{
+	struct generic_pm_domain *genpd = NULL, *gpd;
+
+	if (IS_ERR_OR_NULL(domain_name) || IS_ERR_OR_NULL(dev))
+		return -EINVAL;
+
+	mutex_lock(&gpd_list_lock);
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
+		if (!strcmp(gpd->name, domain_name)) {
+			genpd = gpd;
+			break;
+		}
+	}
+	mutex_unlock(&gpd_list_lock);
+
+	return __pm_genpd_add_device(genpd, dev, td);
+}
+
 /**
  * pm_genpd_remove_device - Remove a device from an I/O PM domain.
  * @genpd: PM domain to remove the device from.
Index: linux/include/linux/pm_domain.h
=================================--- linux.orig/include/linux/pm_domain.h
+++ linux/include/linux/pm_domain.h
@@ -139,17 +139,9 @@ extern int __pm_genpd_of_add_device(stru
 				    struct device *dev,
 				    struct gpd_timing_data *td);
 
-static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-				      struct device *dev)
-{
-	return __pm_genpd_add_device(genpd, dev, NULL);
-}
-
-static inline int pm_genpd_of_add_device(struct device_node *genpd_node,
-					 struct device *dev)
-{
-	return __pm_genpd_of_add_device(genpd_node, dev, NULL);
-}
+extern int __pm_genpd_name_add_device(const char *domain_name,
+				      struct device *dev,
+				      struct gpd_timing_data *td);
 
 extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 				  struct device *dev);
@@ -189,8 +181,14 @@ static inline int __pm_genpd_add_device(
 {
 	return -ENOSYS;
 }
-static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-				      struct device *dev)
+static inline int __pm_genpd_of_add_device(struct device_node *genpd_node,
+					   struct device *dev)
+{
+	return -ENOSYS;
+}
+static inline int __pm_genpd_name_add_device(char *domain_name,
+					     struct device *dev,
+					     struct gpd_timing_data *td)
 {
 	return -ENOSYS;
 }
@@ -245,6 +243,24 @@ static inline bool default_stop_ok(struc
 #define pm_domain_always_on_gov NULL
 #endif
 
+static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
+				      struct device *dev)
+{
+	return __pm_genpd_add_device(genpd, dev, NULL);
+}
+
+static inline int pm_genpd_of_add_device(struct device_node *genpd_node,
+					 struct device *dev)
+{
+	return __pm_genpd_of_add_device(genpd_node, dev, NULL);
+}
+
+static inline int pm_genpd_name_add_device(const char *domain_name,
+					   struct device *dev)
+{
+	return __pm_genpd_name_add_device(domain_name, dev, NULL);
+}
+
 static inline int pm_genpd_remove_callbacks(struct device *dev)
 {
 	return __pm_genpd_remove_callbacks(dev, true);

