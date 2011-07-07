From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Jul 2011 13:32:45 +0000
Subject: [PATCH 04/05] PM: export pm_genpd_poweron() in header
Message-Id: <20110707133245.22347.42754.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Allow SoC-specific code to call pm_genpd_poweron().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Perhaps there are better ways to deal with this?

 drivers/base/power/domain.c |    2 +-
 include/linux/pm_domain.h   |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

--- 0001/drivers/base/power/domain.c
+++ work/drivers/base/power/domain.c	2011-07-07 21:37:49.000000000 +0900
@@ -37,7 +37,7 @@ static void genpd_sd_counter_dec(struct
  * Restore power to @genpd and all of its parents so that it is possible to
  * resume a device belonging to it.
  */
-static int pm_genpd_poweron(struct generic_pm_domain *genpd)
+int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
 	int ret = 0;
 
--- 0001/include/linux/pm_domain.h
+++ work/include/linux/pm_domain.h	2011-07-07 21:37:49.000000000 +0900
@@ -63,6 +63,7 @@ extern int pm_genpd_remove_subdomain(str
 				     struct generic_pm_domain *target);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
+extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 #else
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 				      struct device *dev)
@@ -86,6 +87,10 @@ static inline int pm_genpd_remove_subdom
 }
 static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off) {}
+static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
+{
+	return -ENOSYS;
+}
 #endif
 
 #endif /* _LINUX_PM_DOMAIN_H */
