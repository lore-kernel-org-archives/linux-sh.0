From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 31 Jul 2014 00:10:06 +0000
Subject: [PATCH] ARM: shmobile: Armadillo Multiplatform Prototype
Message-Id: <20140731001006.9500.72592.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Prototype to move Armadillo DT Reference over to Multiplatform.
Needs to be merged with the r8a7740 CCF DT bits somehow.

Not for upstream merge. Only compile tested.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.16-rc7-20140729

 arch/arm/mach-shmobile/Kconfig                           |   27 ++++++--------
 arch/arm/mach-shmobile/Makefile                          |    2 -
 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    1 
 arch/arm/mach-shmobile/pm-r8a7740.c                      |    5 +-
 arch/arm/mach-shmobile/pm-rmobile.c                      |    2 -
 arch/arm/mach-shmobile/pm-rmobile.h                      |    4 +-
 arch/arm/mach-shmobile/r8a7740.h                         |    4 +-
 arch/arm/mach-shmobile/setup-r8a7740.c                   |    2 +
 8 files changed, 22 insertions(+), 25 deletions(-)

--- 0001/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-07-31 08:55:33.000000000 +0900
@@ -26,6 +26,12 @@ config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 	select SYS_SUPPORTS_SH_MTU2
 
+config ARCH_R8A7740
+	bool "R-Mobile A1 (R8A77400)"
+	select RENESAS_INTC_IRQPIN
+	select SYS_SUPPORTS_SH_CMT
+	select SYS_SUPPORTS_SH_TMU
+
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select RENESAS_INTC_IRQPIN
@@ -43,6 +49,12 @@ config ARCH_R8A7791
 
 comment "Renesas ARM SoCs Board Type"
 
+config MACH_ARMADILLO800EVA
+	bool "Armadillo-800 EVA board"
+	depends on ARCH_R8A7740
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select SMSC_PHY if SH_ETH
+
 config MACH_KOELSCH
 	bool "Koelsch board"
 	depends on ARCH_R8A7791
@@ -184,21 +196,6 @@ config MACH_ARMADILLO800EVA
 	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 	select USE_OF
 
-config MACH_ARMADILLO800EVA_REFERENCE
-	bool "Armadillo-800 EVA board - Reference Device Tree Implementation"
-	depends on ARCH_R8A7740
-	select ARCH_REQUIRE_GPIOLIB
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select SMSC_PHY if SH_ETH
-	select SND_SOC_WM8978 if SND_SIMPLE_CARD
-	select USE_OF
-	---help---
-	   Use reference implementation of Armadillo800 EVA board support
-	   which makes greater use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 config MACH_BOCKW
 	bool "BOCK-W platform"
 	depends on ARCH_R8A7778
--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-07-31 08:51:28.000000000 +0900
@@ -62,6 +62,7 @@ obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
+obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen-reference.o
@@ -74,7 +75,6 @@ obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= bo
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
 obj-$(CONFIG_MACH_LAGER)	+= board-lager.o
 obj-$(CONFIG_MACH_ARMADILLO800EVA)	+= board-armadillo800eva.o
-obj-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE)	+= board-armadillo800eva-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch.o
 obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 obj-$(CONFIG_MACH_KZM9G_REFERENCE)	+= board-kzm9g-reference.o
--- 0001/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ work/arch/arm/mach-shmobile/board-armadillo800eva-reference.c	2014-07-31 09:02:40.000000000 +0900
@@ -160,7 +160,6 @@ clock_error:
  */
 static void __init eva_init(void)
 {
-	r8a7740_clock_init(MD_CK0 | MD_CK2);
 	eva_clock_init();
 
 	r8a7740_meram_workaround();
--- 0001/arch/arm/mach-shmobile/pm-r8a7740.c
+++ work/arch/arm/mach-shmobile/pm-r8a7740.c	2014-07-31 09:01:16.000000000 +0900
@@ -13,7 +13,7 @@
 #include "common.h"
 #include "pm-rmobile.h"
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 static int r8a7740_pd_a4s_suspend(void)
 {
 	/*
@@ -58,8 +58,7 @@ void __init r8a7740_init_pm_domains(void
 	rmobile_init_domains(r8a7740_pm_domains, ARRAY_SIZE(r8a7740_pm_domains));
 	pm_genpd_add_subdomain_names("A4S", "A3SP");
 }
-
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
 
 #ifdef CONFIG_SUSPEND
 static int r8a7740_enter_suspend(suspend_state_t suspend_state)
--- 0001/arch/arm/mach-shmobile/pm-rmobile.c
+++ work/arch/arm/mach-shmobile/pm-rmobile.c	2014-07-31 09:00:12.000000000 +0900
@@ -27,7 +27,7 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
--- 0001/arch/arm/mach-shmobile/pm-rmobile.h
+++ work/arch/arm/mach-shmobile/pm-rmobile.h	2014-07-31 09:00:43.000000000 +0900
@@ -36,7 +36,7 @@ struct pm_domain_device {
 	struct platform_device *pdev;
 };
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
 extern void rmobile_add_device_to_domain_td(const char *domain_name,
 					    struct platform_device *pdev,
@@ -58,6 +58,6 @@ extern void rmobile_add_devices_to_domai
 
 static inline void rmobile_add_devices_to_domains(struct pm_domain_device d[],
 						  int size) {}
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
 
 #endif /* PM_RMOBILE_H */
--- 0001/arch/arm/mach-shmobile/r8a7740.h
+++ work/arch/arm/mach-shmobile/r8a7740.h	2014-07-31 09:01:02.000000000 +0900
@@ -54,10 +54,10 @@ extern void r8a7740_clock_init(u8 md_ck)
 extern void r8a7740_pinmux_init(void);
 extern void r8a7740_pm_init(void);
 
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && !defined(CONFIG_ARCH_MULTIPLATFORM)
 extern void __init r8a7740_init_pm_domains(void);
 #else
 static inline void r8a7740_init_pm_domains(void) {}
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM && !CONFIG_ARCH_MULTIPLATFORM */
 
 #endif /* __ASM_R8A7740_H__ */
--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2014-07-31 09:03:47.000000000 +0900
@@ -827,7 +827,9 @@ void __init r8a7740_init_irq_of(void)
 
 static void __init r8a7740_generic_init(void)
 {
+#if !defined(CONFIG_COMMON_CLK)
 	r8a7740_clock_init(0);
+#endif
 	r8a7740_add_standard_devices_dt();
 }
 
