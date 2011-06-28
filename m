From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jun 2011 00:35:50 +0000
Subject: [PATCH 04/05] ARM: mach-shmobile: sh7372 A3RI support
Message-Id: <20110628003550.11399.71275.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for the sh7372 A3RI power domain. This domain contains
the ISP hardware block, but there is no driver available.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 +
 arch/arm/mach-shmobile/pm-sh7372.c           |    4 ++++
 arch/arm/mach-shmobile/setup-sh7372.c        |    1 +
 3 files changed, 6 insertions(+)

--- 0005/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-06-27 13:38:20.000000000 +0900
@@ -486,6 +486,7 @@ static inline struct sh7372_pm_domain *t
 #ifdef CONFIG_PM
 extern struct sh7372_pm_domain sh7372_a4lc;
 extern struct sh7372_pm_domain sh7372_a3rv;
+extern struct sh7372_pm_domain sh7372_a3ri;
 
 extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
 extern void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
--- 0005/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-06-27 13:37:57.000000000 +0900
@@ -123,6 +123,10 @@ struct sh7372_pm_domain sh7372_a3rv = {
 	.bit_shift = 6,
 };
 
+struct sh7372_pm_domain sh7372_a3ri = {
+	.bit_shift = 8,
+};
+
 #endif /* CONFIG_PM */
 
 static void sh7372_enter_core_standby(void)
--- 0005/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-06-27 13:38:09.000000000 +0900
@@ -843,6 +843,7 @@ void __init sh7372_add_standard_devices(
 {
 	sh7372_init_pm_domain(&sh7372_a4lc);
 	sh7372_init_pm_domain(&sh7372_a3rv);
+	sh7372_init_pm_domain(&sh7372_a3ri);
 
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
