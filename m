From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 06 Aug 2012 23:10:22 +0000
Subject: [PATCH 6/12] ARM: shmobile: Add routine for automatic PM domains initialization
Message-Id: <201208070110.22312.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201208070105.23262.rjw@sisk.pl>
In-Reply-To: <201208070105.23262.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


Add a new routine, rmobile_init_domains(), allowing the caller
to initialize all generic PM objects stored in a table in one
operation.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/include/mach/pm-rmobile.h |    2 ++
 arch/arm/mach-shmobile/pm-rmobile.c              |    8 ++++++++
 2 files changed, 10 insertions(+)

Index: linux/arch/arm/mach-shmobile/pm-rmobile.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-rmobile.c
+++ linux/arch/arm/mach-shmobile/pm-rmobile.c
@@ -149,6 +149,14 @@ void rmobile_init_pm_domain(struct rmobi
 	__rmobile_pd_power_up(rmobile_pd, false);
 }
 
+void rmobile_init_domains(struct rmobile_pm_domain domains[], int num)
+{
+	int j;
+
+	for (j = 0; j < num; j++)
+		rmobile_init_pm_domain(&domains[j]);
+}
+
 void rmobile_add_device_to_domain(const char *domain_name,
 				 struct platform_device *pdev)
 {
Index: linux/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
=================================--- linux.orig/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
+++ linux/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
@@ -31,10 +31,12 @@ struct rmobile_pm_domain *to_rmobile_pd(
 
 #ifdef CONFIG_PM
 extern void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd);
+extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
 extern void rmobile_add_device_to_domain(const char *domain_name,
 					struct platform_device *pdev);
 #else
 #define rmobile_init_pm_domain(pd) do { } while (0)
+#define rmobile_init_domains(domains, num) do { } while (0)
 #define rmobile_add_device_to_domain(name, pdev) do { } while (0)
 #endif /* CONFIG_PM */
 

