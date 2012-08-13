From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 22:20:52 +0000
Subject: [PATCH 1/3] PM / Domains: Document cpuidle-related functions and change their names
Message-Id: <201208140020.52270.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201208140019.19288.rjw@sisk.pl>
In-Reply-To: <201208140019.19288.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


The names of the cpuidle-related functions in
drivers/base/power/domain.c are inconsistent with the names of the
other exported functions in that file (the "pm_" prefix is missing
from them) and they are missing kerneldoc comments.

Fix that by adding the missing "pm_" prefix to the names of those
functions and add kerneldoc comments documenting them.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/domain.c |   20 ++++++++++++++++++--
 include/linux/pm_domain.h   |    8 ++++----
 2 files changed, 22 insertions(+), 6 deletions(-)

Index: linux/drivers/base/power/domain.c
=================================--- linux.orig/drivers/base/power/domain.c
+++ linux/drivers/base/power/domain.c
@@ -1829,7 +1829,16 @@ int __pm_genpd_remove_callbacks(struct d
 }
 EXPORT_SYMBOL_GPL(__pm_genpd_remove_callbacks);
 
-int genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
+/**
+ * pm_genpd_attach_cpuidle - Connect the given PM domain with cpuidle.
+ * @genpd: PM domain to be connected with cpuidle.
+ * @state: cpuidle state this domain can disable/enable.
+ *
+ * Make a PM domain behave as though it contained a CPU core, that is, instead
+ * of calling its power down routine it will enable the given cpuidle state so
+ * that the cpuidle subsystem can power it down (if possible and desirable).
+ */
+int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 {
 	struct cpuidle_driver *cpuidle_drv;
 	struct gpd_cpu_data *cpu_data;
@@ -1878,7 +1887,14 @@ int genpd_attach_cpuidle(struct generic_
 	goto out;
 }
 
-int genpd_detach_cpuidle(struct generic_pm_domain *genpd)
+/**
+ * pm_genpd_detach_cpuidle - Remove the cpuidle connection from a PM domain.
+ * @genpd: PM domain to remove the cpuidle connection from.
+ *
+ * Remove the cpuidle connection set up by pm_genpd_attach_cpuidle() from the
+ * given PM domain.
+ */
+int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 {
 	struct gpd_cpu_data *cpu_data;
 	struct cpuidle_state *idle_state;
Index: linux/include/linux/pm_domain.h
=================================--- linux.orig/include/linux/pm_domain.h
+++ linux/include/linux/pm_domain.h
@@ -155,8 +155,8 @@ extern int pm_genpd_add_callbacks(struct
 				  struct gpd_dev_ops *ops,
 				  struct gpd_timing_data *td);
 extern int __pm_genpd_remove_callbacks(struct device *dev, bool clear_td);
-extern int genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state);
-extern int genpd_detach_cpuidle(struct generic_pm_domain *genpd);
+extern int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state);
+extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
 
@@ -225,11 +225,11 @@ static inline int __pm_genpd_remove_call
 {
 	return -ENOSYS;
 }
-static inline int genpd_attach_cpuidle(struct generic_pm_domain *genpd, int st)
+static inline int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int st)
 {
 	return -ENOSYS;
 }
-static inline int genpd_detach_cpuidle(struct generic_pm_domain *genpd)
+static inline int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 {
 	return -ENOSYS;
 }

