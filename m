From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 11 May 2014 23:16:52 +0000
Subject: [PATCH/RFC] ARM: shmobile: r8a7740 without PM domains prototype
Message-Id: <20140511231652.19926.53110.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This is a prototype patch to allow building r8a7740 for 
multiplatform when CONFIG_PM_GENERIC_DOMAINS is unset.

It may perhaps be better to simply select PM_GENERIC_DOMAINS
for r8a7740 in case of multiplatform. Same applies to sh73a0.

Not for merge. Need to figure out how to do this properly first.

Not-yet-signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/pm-rmobile.h |    4 ++--
 arch/arm/mach-shmobile/include/mach/r8a7740.h    |    4 ++--
 arch/arm/mach-shmobile/pm-r8a7740.c              |    4 ++--
 arch/arm/mach-shmobile/pm-rmobile.c              |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
+++ work/arch/arm/mach-shmobile/include/mach/pm-rmobile.h	2014-04-24 19:07:59.000000000 +0900
@@ -36,7 +36,7 @@ struct pm_domain_device {
 	struct platform_device *pdev;
 };
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_PM_GENERIC_DOMAINS)
 extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
 extern void rmobile_add_device_to_domain_td(const char *domain_name,
 					    struct platform_device *pdev,
@@ -58,6 +58,6 @@ extern void rmobile_add_devices_to_domai
 
 static inline void rmobile_add_devices_to_domains(struct pm_domain_device d[],
 						  int size) {}
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && CONFIG_PM_GENERIC_DOMAINS */
 
 #endif /* PM_RMOBILE_H */
--- 0006/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7740.h	2014-04-24 19:08:49.000000000 +0900
@@ -56,10 +56,10 @@ extern void r8a7740_clock_init(u8 md_ck)
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_PM_GENERIC_DOMAINS)
 extern void __init r8a7740_init_pm_domains(void);
 #else
 static inline void r8a7740_init_pm_domains(void) {}
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && CONFIG_PM_GENERIC_DOMAINS */
 
 #endif /* __ASM_R8A7740_H__ */
--- 0001/arch/arm/mach-shmobile/pm-r8a7740.c
+++ work/arch/arm/mach-shmobile/pm-r8a7740.c	2014-04-24 19:13:23.000000000 +0900
@@ -13,7 +13,7 @@
 #include <mach/pm-rmobile.h>
 #include <mach/common.h>
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_PM_GENERIC_DOMAINS)
 static int r8a7740_pd_a4s_suspend(void)
 {
 	/*
@@ -59,7 +59,7 @@ void __init r8a7740_init_pm_domains(void
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
 }
 
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && CONFIG_PM_GENERIC_DOMAINS */
 
 #ifdef CONFIG_SUSPEND
 static int r8a7740_enter_suspend(suspend_state_t suspend_state)
--- 0001/arch/arm/mach-shmobile/pm-rmobile.c
+++ work/arch/arm/mach-shmobile/pm-rmobile.c	2014-04-24 19:09:08.000000000 +0900
@@ -27,7 +27,7 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_PM_GENERIC_DOMAINS)
 static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
@@ -183,4 +183,4 @@ void rmobile_add_devices_to_domains(stru
 		rmobile_add_device_to_domain_td(data[j].domain_name,
 						data[j].pdev, &latencies);
 }
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && CONFIG_PM_GENERIC_DOMAINS */
