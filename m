From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 Jul 2011 08:24:59 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 A3SP prototype support V2
Message-Id: <20110712082459.18930.51005.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Prototype code to add support for A3SP on sh7372 V2.

Lightly tested on Mackerel, adding AP4EVB support is
still on the TODO.

Also, please note that using the serial console for
output from the power domain control callbacks is
not supported due to the usage of Runtime PM in the
SCIF serial console driver code.

Not suitable for merge until we have QoS support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 A simple up-port of the old prototype, now fits on top of
 suspend-2.6 git pm-domains branch:

775b8ae ARM: mach-shmobile: sh7372 A3RV requires A4LC
18b4f3f PM / Domains: Export pm_genpd_poweron() in header
b9416f0 ARM: mach-shmobile: sh7372 late pm domain off
999a4d2 ARM: mach-shmobile: Runtime PM late init callback
d24771d ARM: mach-shmobile: sh7372 D4 support
c1ba5bb ARM: mach-shmobile: sh7372 A4MP support
a41b646 ARM: mach-shmobile: sh7372: make sure that fsi is peripheral of spu2
c47586b ARM: mach-shmobile: sh7372 A3SG support
082517a ARM: mach-shmobile: sh7372 A3RI support
33afebf ARM: mach-shmobile: sh7372 A3RV support
96f7934 ARM: mach-shmobile: sh7372 A4LC support for AP4EVB
e3e0109 ARM / shmobile: Support for I/O power domains for SH7372 (v9)

 Combine with "[PATCH 01/03] serial: sh-sci: console Runtime PM prototype"
 and also "[PATCH 03/03] ARM: mach-shmobile: sh7372 power domain LED hack"

 arch/arm/mach-shmobile/board-mackerel.c      |    8 ++++++++
 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 +
 arch/arm/mach-shmobile/pm-sh7372.c           |   22 +++++++++++++++++-----
 arch/arm/mach-shmobile/setup-sh7372.c        |   12 ++++++++++++
 4 files changed, 38 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-07-12 16:56:35.000000000 +0900
@@ -1585,6 +1585,14 @@ static void __init mackerel_init(void)
 	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
 	sh7372_add_device_to_domain(&sh7372_a4lc, &hdmi_lcdc_device);
 	sh7372_add_device_to_domain(&sh7372_a4mp, &fsi_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &usbhs0_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &usbhs1_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
+#endif
+	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi2_device);
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
--- 0001/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-07-12 16:55:45.000000000 +0900
@@ -489,6 +489,7 @@ extern struct sh7372_pm_domain sh7372_a4
 extern struct sh7372_pm_domain sh7372_d4;
 extern struct sh7372_pm_domain sh7372_a3rv;
 extern struct sh7372_pm_domain sh7372_a3ri;
+extern struct sh7372_pm_domain sh7372_a3sp;
 extern struct sh7372_pm_domain sh7372_a3sg;
 
 extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
--- 0002/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-07-12 17:07:35.000000000 +0900
@@ -28,10 +28,10 @@
 #define SYSTBCR 0xe6150024
 #define SBAR 0xe6180020
 #define APARMBAREA 0xe6f10020
-
 #define SPDCR 0xe6180008
 #define SWUCR 0xe6180014
 #define PSTR 0xe6180080
+#define PDNSEL 0xe6180254
 
 #define PSTR_RETRIES 100
 #define PSTR_DELAY_US 10
@@ -55,8 +55,10 @@ static int pd_power_down(struct generic_
 		}
 	}
 
-	pr_debug("sh7372 power domain down 0x%08x -> PSTR = 0x%08x\n",
-		 mask, __raw_readl(PSTR));
+	/* we cannot output debug message for A3SP */
+	if (genpd != &sh7372_a3sp.genpd)
+		pr_debug("sh7372 power domain down 0x%08x -> PSTR = 0x%08x\n",
+			 mask, __raw_readl(PSTR));
 
 	return 0;
 }
@@ -85,8 +87,10 @@ static int pd_power_up(struct generic_pm
 		ret = -EIO;
 
  out:
-	pr_debug("sh7372 power domain up 0x%08x -> PSTR = 0x%08x\n",
-		 mask, __raw_readl(PSTR));
+	/* we cannot output debug message for A3SP */
+	if (genpd != &sh7372_a3sp.genpd)
+		pr_debug("sh7372 power domain up 0x%08x -> PSTR = 0x%08x\n",
+			 mask, __raw_readl(PSTR));
 
 	return ret;
 }
@@ -134,6 +138,7 @@ static void sh7372_late_pm_domain_off(vo
 	queue_work(pm_wq, &sh7372_d4.genpd.power_off_work);
 	queue_work(pm_wq, &sh7372_a3rv.genpd.power_off_work);
 	queue_work(pm_wq, &sh7372_a3ri.genpd.power_off_work);
+	queue_work(pm_wq, &sh7372_a3sp.genpd.power_off_work);
 	queue_work(pm_wq, &sh7372_a3sg.genpd.power_off_work);
 }
 
@@ -193,6 +198,10 @@ struct sh7372_pm_domain sh7372_a3ri = {
 	.bit_shift = 8,
 };
 
+struct sh7372_pm_domain sh7372_a3sp = {
+	.bit_shift = 11,
+};
+
 struct sh7372_pm_domain sh7372_a3sg = {
 	.bit_shift = 13,
 };
@@ -277,6 +286,9 @@ void __init sh7372_pm_init(void)
 	__raw_writel(0x0000a501, DBGREG9);
 	__raw_writel(0x00000000, DBGREG1);
 
+	/* do not convert A3SM, A3SP, A3SG, A4R power down into A4S */
+	__raw_writel(0, PDNSEL);
+
 	sh7372_suspend_init();
 	sh7372_cpuidle_init();
 }
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-07-12 16:57:29.000000000 +0900
@@ -847,6 +847,7 @@ void __init sh7372_add_standard_devices(
 	sh7372_init_pm_domain(&sh7372_a3rv);
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
+	sh7372_init_pm_domain(&sh7372_a3sp);
 
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
@@ -857,6 +858,17 @@ void __init sh7372_add_standard_devices(
 	sh7372_add_device_to_domain(&sh7372_a3rv, &vpu_device);
 	sh7372_add_device_to_domain(&sh7372_a4mp, &spu0_device);
 	sh7372_add_device_to_domain(&sh7372_a4mp, &spu1_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &scif0_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &scif1_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &scif2_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &scif3_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &scif4_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &scif5_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &scif6_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &iic1_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &dma0_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &dma1_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &dma2_device);
 }
 
 void __init sh7372_add_early_devices(void)
