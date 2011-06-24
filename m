From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 24 Jun 2011 05:54:39 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 A3RV power domain prototype
Message-Id: <20110624060236.26758.41446.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This somewhat messy prototype patch adds A3RV power domain
control support for sh7372. The A3RV power domain contains
the VPU video encoder/decoder which is exported through UIO.

The prototype serves as an example of a simple power domain
that needs to be turned off during boot. The default setting
after hardware reset is to keep A3RV powered on. The UIO driver
uio_pdrv_genirq.c does not access the VPU hardware at ->probe()
time but instead relies 100% on user space. So the VPU device
and A3RV will always be unused during boot.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to suspend-2.6.git pm-domains as of a few days ago:

 commit 6232eb8f755b0eb1a47f6fd6277da879248aba5e
 Author: Rafael J. Wysocki <rjw@sisk.pl>
 Date:   Wed Jun 22 02:20:43 2011 +0200

    ARM / shmobile: Support for I/O power domains for SH7372 (v7)

 arch/arm/mach-shmobile/board-mackerel.c      |    1 -
 arch/arm/mach-shmobile/include/mach/sh7372.h |    3 +++
 arch/arm/mach-shmobile/pm-sh7372.c           |    4 ++++
 arch/arm/mach-shmobile/setup-sh7372.c        |    5 +++++
 4 files changed, 12 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-06-22 21:19:13.000000000 +0900
@@ -1582,7 +1582,6 @@ static void __init mackerel_init(void)
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
 
-	sh7372_init_pm_domain(&sh7372_a4lc_domain);
 	sh7372_add_device_to_domain(SH7372_A4LC, &lcdc_device);
 	sh7372_add_device_to_domain(SH7372_A4LC, &hdmi_lcdc_device);
 
--- 0001/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-06-22 21:18:26.000000000 +0900
@@ -485,13 +485,16 @@ static inline struct sh7372_pm_domain *t
 
 #ifdef CONFIG_PM
 extern struct sh7372_pm_domain sh7372_a4lc_domain;
+extern struct sh7372_pm_domain sh7372_a3rv_domain;
 #define SH7372_A4LC	(&sh7372_a4lc_domain)
+#define SH7372_A3RV	(&sh7372_a3rv_domain)
 
 extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
 extern void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
 					struct platform_device *pdev);
 #else
 #define SH7372_A4LC	NULL
+#define SH7372_A3RV	NULL
 
 static inline void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd) {}
 static inline void sh7372_add_device_to_domain(struct sh7372_pm_domain *pd,
--- 0001/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-06-22 21:30:44.000000000 +0900
@@ -117,6 +117,10 @@ struct sh7372_pm_domain sh7372_a4lc_doma
 	.bit_shift = 1,
 };
 
+struct sh7372_pm_domain sh7372_a3rv_domain = {
+	.bit_shift = 6,
+};
+
 static void sh7372_enter_core_standby(void)
 {
 	void __iomem *smfram = (void __iomem *)SMFRAM;
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-06-22 21:24:03.000000000 +0900
@@ -841,11 +841,16 @@ static struct platform_device *sh7372_la
 
 void __init sh7372_add_standard_devices(void)
 {
+	sh7372_init_pm_domain(SH7372_A4LC);
+	sh7372_init_pm_domain(SH7372_A3RV);
+
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
 	platform_add_devices(sh7372_late_devices,
 			    ARRAY_SIZE(sh7372_late_devices));
+
+	sh7372_add_device_to_domain(SH7372_A3RV, &vpu_device);
 }
 
 void __init sh7372_add_early_devices(void)
