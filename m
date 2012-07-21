From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 21 Jul 2012 21:54:14 +0000
Subject: [RFC][PATCH 2/5] PM / shmobile: Allow device latencies to be specified directly
Message-Id: <201207212354.14958.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201207212349.18294.rjw@sisk.pl>
In-Reply-To: <201207212349.18294.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-sh list <linux-sh@vger.kernel.org>, Olof Johansson <olof@lixom.net>


Make it possible to specify device start/stop and save/restore
state latencies directy when adding devices to PM domains.  For
this purpose, introduce rmobile_add_device_to_domain_td() whose
third argument is a pointer to a struct gpd_timing_data object
containing device latency data.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/include/mach/pm-rmobile.h |   14 ++++++++++++--
 arch/arm/mach-shmobile/pm-rmobile.c              |    7 ++++---
 2 files changed, 16 insertions(+), 5 deletions(-)

Index: linux/arch/arm/mach-shmobile/pm-rmobile.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-rmobile.c
+++ linux/arch/arm/mach-shmobile/pm-rmobile.c
@@ -152,14 +152,15 @@ static void rmobile_init_pm_domain(struc
 	__rmobile_pd_power_up(rmobile_pd, false);
 }
 
-void rmobile_add_device_to_domain(const char *domain_name,
-				 struct platform_device *pdev)
+void rmobile_add_device_to_domain_td(const char *domain_name,
+				     struct platform_device *pdev,
+				     struct gpd_timing_data *td)
 {
 	struct device *dev = &pdev->dev;
 	int ret;
 
 	do
-		ret = pm_genpd_name_add_device(domain_name, dev);
+		ret = __pm_genpd_name_add_device(domain_name, dev, td);
 	while (ret = -EAGAIN);
 	if (pm_clk_no_clocks(dev))
 		pm_clk_add(dev, NULL);
Index: linux/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
=================================--- linux.orig/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
+++ linux/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
@@ -31,10 +31,20 @@ struct rmobile_pm_domain *to_rmobile_pd(
 
 #ifdef CONFIG_PM
 extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
-extern void rmobile_add_device_to_domain(const char *domain_name,
-					struct platform_device *pdev);
+extern void rmobile_add_device_to_domain_td(const char *domain_name,
+					    struct platform_device *pdev,
+					    struct gpd_timing_data *td);
+
+static inline void rmobile_add_device_to_domain(const char *domain_name,
+						struct platform_device *pdev)
+{
+	rmobile_add_device_to_domain_td(domain_name, pdev, NULL);
+}
+
 #else
+
 #define rmobile_init_domains(domains, num) do { } while (0)
+#define rmobile_add_device_to_domain_td(name, pdev, td) do { } while (0)
 #define rmobile_add_device_to_domain(name, pdev) do { } while (0)
 #endif /* CONFIG_PM */
 

