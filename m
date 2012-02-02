From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 02 Feb 2012 22:12:35 +0000
Subject: [PATCH] PM: provide a dummy dev_gpd_data() when generic domains are not used
Message-Id: <Pine.LNX.4.64.1202022258581.13860@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

dev_gpd_data() is a generic macro, also useful for drivers. Hence it should
be available also when CONFIG_PM_GENERIC_DOMAINS is not selected. OTOH,
to_gpd_data() is so far unused outside of the generic PM domain code and
does not seem to be very useful without CONFIG_PM_GENERIC_DOMAINS.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/linux/pm_domain.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index a03a0ad..f1a5f8b 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -99,12 +99,12 @@ struct generic_pm_domain_data {
 	bool need_restore;
 };
 
+#ifdef CONFIG_PM_GENERIC_DOMAINS
 static inline struct generic_pm_domain_data *to_gpd_data(struct pm_domain_data *pdd)
 {
 	return container_of(pdd, struct generic_pm_domain_data, base);
 }
 
-#ifdef CONFIG_PM_GENERIC_DOMAINS
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 {
 	return to_gpd_data(dev->power.subsys_data->domain_data);
@@ -195,6 +195,10 @@ static inline bool default_stop_ok(struct device *dev)
 	return false;
 }
 #define pm_domain_always_on_gov NULL
+static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
+{
+	return NULL;
+}
 #endif
 
 static inline int pm_genpd_remove_callbacks(struct device *dev)
-- 
1.7.2.5

