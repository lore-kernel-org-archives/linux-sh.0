From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Sep 2014 03:39:42 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: Cleanup PM Kconfig usage
Message-Id: <20140904033942.22881.84361.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Simplify the r8a7740 PM code by using CONFIG_PM_RMOBILE instead
of having a complex #if expression embedded in the C code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of renesas-devel-20140904-v3.17-rc3

 arch/arm/mach-shmobile/pm-r8a7740.c |    6 ++++--
 arch/arm/mach-shmobile/r8a7740.h    |    7 +------
 2 files changed, 5 insertions(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/pm-r8a7740.c
+++ work/arch/arm/mach-shmobile/pm-r8a7740.c	2014-09-04 12:29:12.000000000 +0900
@@ -13,7 +13,7 @@
 #include "common.h"
 #include "pm-rmobile.h"
 
-#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
+#ifdef CONFIG_PM_RMOBILE
 static int r8a7740_pd_a4s_suspend(void)
 {
 	/*
@@ -58,7 +58,9 @@ void __init r8a7740_init_pm_domains(void
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
 }
-#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
+#else
+void r8a7740_init_pm_domains(void) {}
+#endif
 
 #ifdef CONFIG_SUSPEND
 static int r8a7740_enter_suspend(suspend_state_t suspend_state)
--- 0001/arch/arm/mach-shmobile/r8a7740.h
+++ work/arch/arm/mach-shmobile/r8a7740.h	2014-09-04 12:29:12.000000000 +0900
@@ -52,11 +52,6 @@ extern void r8a7740_add_standard_devices
 extern void r8a7740_clock_init(u8 md_ck);
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
-
-#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
-extern void __init r8a7740_init_pm_domains(void);
-#else
-static inline void r8a7740_init_pm_domains(void) {}
-#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
+extern void r8a7740_init_pm_domains(void);
 
 #endif /* __ASM_R8A7740_H__ */
