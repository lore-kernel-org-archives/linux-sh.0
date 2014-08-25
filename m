From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 25 Aug 2014 03:04:01 +0000
Subject: [PATCH v2 05/05] ARM: shmobile: Cleanup pm-rmobile.o build using Kconfig
Message-Id: <20140825030401.1936.7225.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a CONFIG_PM_RMOBILE entry and enable it for R-Mobile
SoCs in case CONFIG_PM is set. Consolidate Makefile power
management objects and get rid of #ifdefs in the C code.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

 This is multiplatform preparation for R-Mobile SoCs.

 Changes since V1:
 - CONFIG_PM_MOBILE -> CONFIG_PM_RMOBILE typo fix, thanks Geert!

 arch/arm/mach-shmobile/Kconfig      |    4 ++++
 arch/arm/mach-shmobile/Makefile     |   14 ++++++--------
 arch/arm/mach-shmobile/pm-rmobile.c |    2 --
 arch/arm/mach-shmobile/pm-rmobile.h |    4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

--- 0006/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2014-08-19 22:28:58.000000000 +0900
@@ -5,6 +5,9 @@ config ARCH_SHMOBILE
 config PM_RCAR
 	bool
 
+config PM_RMOBILE
+	bool
+
 config ARCH_RCAR_GEN1
 	bool
 	select PM_RCAR if PM || SMP
@@ -19,6 +22,7 @@ config ARCH_RCAR_GEN2
 
 config ARCH_RMOBILE
 	bool
+	select PM_RMOBILE if PM
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
  
--- 0006/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-08-19 22:35:23.000000000 +0900
@@ -6,10 +6,10 @@
 obj-y				:= timer.o console.o
 
 # CPU objects
-obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
-obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o
+obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o pm-sh7372.o
+obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o intc-sh73a0.o pm-sh73a0.o
 obj-$(CONFIG_ARCH_R8A73A4)	+= setup-r8a73a4.o
-obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o
+obj-$(CONFIG_ARCH_R8A7740)	+= setup-r8a7740.o pm-r8a7740.o
 obj-$(CONFIG_ARCH_R8A7778)	+= setup-r8a7778.o
 obj-$(CONFIG_ARCH_R8A7779)	+= setup-r8a7779.o pm-r8a7779.o
 obj-$(CONFIG_ARCH_R8A7790)	+= setup-r8a7790.o pm-r8a7790.o
@@ -49,12 +49,10 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq.o
 obj-$(CONFIG_PM_RCAR)		+= pm-rcar.o
-obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
-obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
-obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
+obj-$(CONFIG_PM_RMOBILE)	+= pm-rmobile.o
 
-# IRQ objects
-obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
+# special sh7372 handling for IRQ objects and low level sleep code
+obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o sleep-sh7372.o
 
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
--- 0001/arch/arm/mach-shmobile/pm-rmobile.c
+++ work/arch/arm/mach-shmobile/pm-rmobile.c	2014-08-19 22:30:37.000000000 +0900
@@ -27,7 +27,6 @@
 #define PSTR_RETRIES	100
 #define PSTR_DELAY_US	10
 
-#ifdef CONFIG_PM
 static int rmobile_pd_power_down(struct generic_pm_domain *genpd)
 {
 	struct rmobile_pm_domain *rmobile_pd = to_rmobile_pd(genpd);
@@ -151,4 +150,3 @@ void rmobile_add_devices_to_domains(stru
 		rmobile_add_device_to_domain_td(data[j].domain_name,
 						data[j].pdev, &latencies);
 }
-#endif /* CONFIG_PM */
--- 0001/arch/arm/mach-shmobile/pm-rmobile.h
+++ work/arch/arm/mach-shmobile/pm-rmobile.h	2014-08-19 22:30:52.000000000 +0900
@@ -36,7 +36,7 @@ struct pm_domain_device {
 	struct platform_device *pdev;
 };
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_RMOBILE
 extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
 extern void rmobile_add_device_to_domain_td(const char *domain_name,
 					    struct platform_device *pdev,
@@ -58,6 +58,6 @@ extern void rmobile_add_devices_to_domai
 
 static inline void rmobile_add_devices_to_domains(struct pm_domain_device d[],
 						  int size) {}
-#endif /* CONFIG_PM */
+#endif /* CONFIG_PM_RMOBILE */
 
 #endif /* PM_RMOBILE_H */
