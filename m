From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 06 Aug 2012 23:15:02 +0000
Subject: [PATCH 12/12] ARM: shmobile: Make rmobile_init_pm_domain() static
Message-Id: <201208070115.02328.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201208070105.23262.rjw@sisk.pl>
In-Reply-To: <201208070105.23262.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-sh list <linux-sh@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


Since rmobile_init_pm_domain() is not called anywhere outside of
arch/arm/mach-shmobile/pm-rmobile.c any more, it can be made static
and its header may be removed from pm-rmobile.h.  Modify the code
accordingly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/include/mach/pm-rmobile.h |    2 --
 arch/arm/mach-shmobile/pm-rmobile.c              |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: linux/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
=================================--- linux.orig/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
+++ linux/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
@@ -30,12 +30,10 @@ struct rmobile_pm_domain *to_rmobile_pd(
 }
 
 #ifdef CONFIG_PM
-extern void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd);
 extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
 extern void rmobile_add_device_to_domain(const char *domain_name,
 					struct platform_device *pdev);
 #else
-#define rmobile_init_pm_domain(pd) do { } while (0)
 #define rmobile_init_domains(domains, num) do { } while (0)
 #define rmobile_add_device_to_domain(name, pdev) do { } while (0)
 #endif /* CONFIG_PM */
Index: linux/arch/arm/mach-shmobile/pm-rmobile.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-rmobile.c
+++ linux/arch/arm/mach-shmobile/pm-rmobile.c
@@ -134,7 +134,7 @@ static int rmobile_pd_start_dev(struct d
 	return ret;
 }
 
-void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
+static void rmobile_init_pm_domain(struct rmobile_pm_domain *rmobile_pd)
 {
 	struct generic_pm_domain *genpd = &rmobile_pd->genpd;
 	struct dev_power_governor *gov = rmobile_pd->gov;

