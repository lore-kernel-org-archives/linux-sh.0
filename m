From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 06:43:34 +0000
Subject: [PATCH 02/03] ARM: mach-shmobile: sh7372 A3SP support
Message-Id: <20110826064334.373.95447.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094710.10442.59532.sendpatchset@t400s>
In-Reply-To: <20110630094710.10442.59532.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds sh7372 A3SP power domain support.

The sh7372 A3SP hardware power domain contains a
wide range of I/O devices. The list of I/O devices
include SCIF serial ports, DMA Engine hardware,
SD and MMC controller hardware, USB controllers
and I2C master controllers.

This patch adds the A3SP low level code which 
powers the hardware power domain on and off. It
also ties in platform devices to the pm domain
support code.

It is worth noting that the serial console is
hooked up to SCIFA0 on most sh7372 boards, and
the SCIFA0 port is included in the A3SP hardware
power domain. For this reason we cannot output
debug messages from the low level power control
code in the case of A3SP.

This patch seems to work quite fine except for
Suspend-to-RAM that is broken with this patch
applied. QoS support is needed in drivers before
we can enable the A3SP power control on the fly.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on USB-DMAC patches by Morimoto-san.

 arch/arm/mach-shmobile/board-ap4evb.c        |    4 ++++
 arch/arm/mach-shmobile/board-mackerel.c      |    8 ++++++++
 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 +
 arch/arm/mach-shmobile/pm-sh7372.c           |   19 +++++++++++++++----
 arch/arm/mach-shmobile/setup-sh7372.c        |   14 ++++++++++++++
 5 files changed, 42 insertions(+), 4 deletions(-)

--- 0006/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2011-08-26 12:44:29.000000000 +0900
@@ -1408,6 +1408,10 @@ static void __init ap4evb_init(void)
 	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
 	sh7372_add_device_to_domain(&sh7372_a4mp, &fsi_device);
 
+	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
+
 	hdmi_init_pm_clock();
 	fsi_init_pm_clock();
 	sh7372_pm_init();
--- 0006/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-08-26 12:44:29.000000000 +0900
@@ -1588,6 +1588,14 @@ static void __init mackerel_init(void)
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
--- 0004/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-08-26 12:44:29.000000000 +0900
@@ -493,6 +493,7 @@ extern struct sh7372_pm_domain sh7372_a4
 extern struct sh7372_pm_domain sh7372_d4;
 extern struct sh7372_pm_domain sh7372_a3rv;
 extern struct sh7372_pm_domain sh7372_a3ri;
+extern struct sh7372_pm_domain sh7372_a3sp;
 extern struct sh7372_pm_domain sh7372_a3sg;
 
 extern void sh7372_init_pm_domain(struct sh7372_pm_domain *sh7372_pd);
--- 0011/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-08-26 12:44:29.000000000 +0900
@@ -92,8 +92,10 @@ static int pd_power_down(struct generic_
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
@@ -122,8 +124,10 @@ static int pd_power_up(struct generic_pm
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
@@ -216,6 +220,10 @@ struct sh7372_pm_domain sh7372_a3ri = {
 	.bit_shift = 8,
 };
 
+struct sh7372_pm_domain sh7372_a3sp = {
+	.bit_shift = 11,
+};
+
 struct sh7372_pm_domain sh7372_a3sg = {
 	.bit_shift = 13,
 };
@@ -450,6 +458,9 @@ void __init sh7372_pm_init(void)
 	__raw_writel(0x0000a501, DBGREG9);
 	__raw_writel(0x00000000, DBGREG1);
 
+	/* do not convert A3SM, A3SP, A3SG, A4R power down into A4S */
+	__raw_writel(0, PDNSEL);
+
 	sh7372_suspend_init();
 	sh7372_cpuidle_init();
 }
--- 0004/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-08-26 12:44:29.000000000 +0900
@@ -993,6 +993,7 @@ void __init sh7372_add_standard_devices(
 	sh7372_init_pm_domain(&sh7372_a3rv);
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
+	sh7372_init_pm_domain(&sh7372_a3sp);
 
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
@@ -1003,6 +1004,19 @@ void __init sh7372_add_standard_devices(
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
+	sh7372_add_device_to_domain(&sh7372_a3sp, &usb_dma0_device);
+	sh7372_add_device_to_domain(&sh7372_a3sp, &usb_dma1_device);
 }
 
 void __init sh7372_add_early_devices(void)
