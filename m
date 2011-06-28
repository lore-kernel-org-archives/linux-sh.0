From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jun 2011 00:35:42 +0000
Subject: [PATCH 03/05] ARM: mach-shmobile: sh7372 A3RV support
Message-Id: <20110628003542.11399.42166.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for the sh7372 A3RV power domain and hook
up the VPU device.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 +
 arch/arm/mach-shmobile/pm-sh7372.c           |    4 ++++
 arch/arm/mach-shmobile/setup-sh7372.c        |    3 +++
 3 files changed, 8 insertions(+)

--- 0002/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-06-27 13:28:08.000000000 +0900
@@ -485,6 +485,7 @@ static inline struct sh7372_pm_domain *t
 
 #ifdef CONFIG_PM
 extern struct sh7372_pm_domain sh7372_a4lc;
+extern struct sh7372_pm_domain sh7372_a3rv;
 
 extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
 extern void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
--- 0002/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-06-27 13:28:43.000000000 +0900
@@ -119,6 +119,10 @@ struct sh7372_pm_domain sh7372_a4lc = {
 	.bit_shift = 1,
 };
 
+struct sh7372_pm_domain sh7372_a3rv = {
+	.bit_shift = 6,
+};
+
 #endif /* CONFIG_PM */
 
 static void sh7372_enter_core_standby(void)
--- 0004/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-06-27 13:30:51.000000000 +0900
@@ -842,12 +842,15 @@ static struct platform_device *sh7372_la
 void __init sh7372_add_standard_devices(void)
 {
 	sh7372_init_pm_domain(&sh7372_a4lc);
+	sh7372_init_pm_domain(&sh7372_a3rv);
 
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
 	platform_add_devices(sh7372_late_devices,
 			    ARRAY_SIZE(sh7372_late_devices));
+
+	sh7372_add_device_to_domain(&sh7372_a3rv, &vpu_device);
 }
 
 void __init sh7372_add_early_devices(void)
