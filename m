From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 27 Sep 2011 08:54:08 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 A4R support V2
Message-Id: <20110927085408.27727.59395.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch is V2 of sh7372 A4R power domain support.

The sh7372 A4R hardware power domain contains the
SH CPU Core and a set of I/O devices including
multimedia accelerators and I2C controllers.

One special case about A4R is the INTCS interrupt
controller that needs to be saved and restored to
keep working as expected. Also the LCDC hardware
blocks are in a different hardware power domain
but have their IRQs routed only through INTCS. So
as long as LCDCs are active we cannot power down
INTCS because that would risk losing interrupts.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - rebased to fit on pm-test branch of linux-pm github repo
 - use simple power_down_ok() governor
 - let A4LC depend on A4R to support INTCS

 arch/arm/mach-shmobile/board-ap4evb.c        |    1 
 arch/arm/mach-shmobile/board-mackerel.c      |    1 
 arch/arm/mach-shmobile/include/mach/sh7372.h |    4 ++
 arch/arm/mach-shmobile/intc-sh7372.c         |   52 +++++++++++++++++++++++++-
 arch/arm/mach-shmobile/pm-sh7372.c           |   35 ++++++++++++++++-
 arch/arm/mach-shmobile/setup-sh7372.c        |    8 ++++
 6 files changed, 98 insertions(+), 3 deletions(-)

--- 0002/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2011-09-27 16:37:56.000000000 +0900
@@ -1412,6 +1412,7 @@ static void __init ap4evb_init(void)
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &ceu_device);
 
 	hdmi_init_pm_clock();
 	fsi_init_pm_clock();
--- 0002/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-09-27 16:37:56.000000000 +0900
@@ -1596,6 +1596,7 @@ static void __init mackerel_init(void)
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
 #endif
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi2_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &ceu_device);
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
--- 0002/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-09-27 16:37:56.000000000 +0900
@@ -491,6 +491,7 @@ static inline struct sh7372_pm_domain *t
 extern struct sh7372_pm_domain sh7372_a4lc;
 extern struct sh7372_pm_domain sh7372_a4mp;
 extern struct sh7372_pm_domain sh7372_d4;
+extern struct sh7372_pm_domain sh7372_a4r;
 extern struct sh7372_pm_domain sh7372_a3rv;
 extern struct sh7372_pm_domain sh7372_a3ri;
 extern struct sh7372_pm_domain sh7372_a3sp;
@@ -507,4 +508,7 @@ extern void sh7372_pm_add_subdomain(stru
 #define sh7372_pm_add_subdomain(pd, sd) do { } while(0)
 #endif /* CONFIG_PM */
 
+extern void sh7372_intcs_suspend(void);
+extern void sh7372_intcs_resume(void);
+
 #endif /* __ASM_SH7372_H__ */
--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2011-09-27 16:37:56.000000000 +0900
@@ -606,9 +606,16 @@ static void intcs_demux(unsigned int irq
 	generic_handle_irq(intcs_evt2irq(evtcodeas));
 }
 
+static void __iomem *intcs_ffd2;
+static void __iomem *intcs_ffd5;
+
 void __init sh7372_init_irq(void)
 {
-	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
+	void __iomem *intevtsa;
+
+	intcs_ffd2 = ioremap_nocache(0xffd20000, PAGE_SIZE);
+	intevtsa = intcs_ffd2 + 0x100;
+	intcs_ffd5 = ioremap_nocache(0xffd50000, PAGE_SIZE);
 
 	register_intc_controller(&intca_desc);
 	register_intc_controller(&intcs_desc);
@@ -617,3 +624,46 @@ void __init sh7372_init_irq(void)
 	irq_set_handler_data(evt2irq(0xf80), (void *)intevtsa);
 	irq_set_chained_handler(evt2irq(0xf80), intcs_demux);
 }
+
+static unsigned short ffd2[0x200];
+static unsigned short ffd5[0x100];
+
+void sh7372_intcs_suspend(void)
+{
+	int k;
+
+	for (k = 0x00; k <= 0x30; k += 4)
+		ffd2[k] = __raw_readw(intcs_ffd2 + k);
+
+	for (k = 0x80; k <= 0xb0; k += 4)
+		ffd2[k] = __raw_readb(intcs_ffd2 + k);
+
+	for (k = 0x180; k <= 0x188; k += 4)
+		ffd2[k] = __raw_readb(intcs_ffd2 + k);
+
+	for (k = 0x00; k <= 0x3c; k += 4)
+		ffd5[k] = __raw_readw(intcs_ffd5 + k);
+
+	for (k = 0x80; k <= 0x9c; k += 4)
+		ffd5[k] = __raw_readb(intcs_ffd5 + k);
+}
+
+void sh7372_intcs_resume(void)
+{
+	int k;
+
+	for (k = 0x00; k <= 0x30; k += 4)
+		__raw_writew(ffd2[k], intcs_ffd2 + k);
+
+	for (k = 0x80; k <= 0xb0; k += 4)
+		__raw_writeb(ffd2[k], intcs_ffd2 + k);
+
+	for (k = 0x180; k <= 0x188; k += 4)
+		__raw_writeb(ffd2[k], intcs_ffd2 + k);
+
+	for (k = 0x00; k <= 0x3c; k += 4)
+		__raw_writew(ffd5[k], intcs_ffd5 + k);
+
+	for (k = 0x80; k <= 0x9c; k += 4)
+		__raw_writeb(ffd5[k], intcs_ffd5 + k);
+}
--- 0002/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-09-27 16:59:26.000000000 +0900
@@ -44,6 +44,7 @@
 #define SPDCR 0xe6180008
 #define SWUCR 0xe6180014
 #define SBAR 0xe6180020
+#define WUPRMSK 0xe6180028
 #define WUPSMSK 0xe618002c
 #define WUPSMSK2 0xe6180048
 #define PSTR 0xe6180080
@@ -132,6 +133,24 @@ static int pd_power_up(struct generic_pm
 	return ret;
 }
 
+static int pd_power_up_a4r(struct generic_pm_domain *genpd)
+{
+	int ret = pd_power_up(genpd);
+
+	if (ret = 0)
+		sh7372_intcs_resume();
+
+	return ret;
+}
+
+static int pd_power_down_a4r(struct generic_pm_domain *genpd)
+{
+	sh7372_intcs_suspend();
+	__raw_writel(0x300fffff, WUPRMSK); /* avoid wakeup */
+
+	return pd_power_down(genpd);
+}
+
 static bool pd_active_wakeup(struct device *dev)
 {
 	return true;
@@ -150,6 +169,9 @@ static bool sh7372_power_down_ok(struct
 	if (genpd = &sh7372_a3sp.genpd)
 		return false;
 
+	if (genpd = &sh7372_a4r.genpd)
+		return false;
+
 	return true;
 }
 
@@ -166,8 +188,13 @@ void sh7372_init_pm_domain(struct sh7372
 	genpd->start_device = pm_clk_resume;
 	genpd->dev_irq_safe = true;
 	genpd->active_wakeup = pd_active_wakeup;
-	genpd->power_off = pd_power_down;
-	genpd->power_on = pd_power_up;
+	if (genpd = &sh7372_a4r.genpd) {
+		genpd->power_off = pd_power_down_a4r;
+		genpd->power_on = pd_power_up_a4r;
+	} else {
+		genpd->power_off = pd_power_down;
+		genpd->power_on = pd_power_up;
+	}
 	genpd->power_on(&sh7372_pd->genpd);
 }
 
@@ -199,6 +226,10 @@ struct sh7372_pm_domain sh7372_d4 = {
 	.bit_shift = 3,
 };
 
+struct sh7372_pm_domain sh7372_a4r = {
+	.bit_shift = 5,
+};
+
 struct sh7372_pm_domain sh7372_a3rv = {
 	.bit_shift = 6,
 };
--- 0002/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-09-27 16:45:56.000000000 +0900
@@ -991,12 +991,14 @@ void __init sh7372_add_standard_devices(
 	sh7372_init_pm_domain(&sh7372_a4lc);
 	sh7372_init_pm_domain(&sh7372_a4mp);
 	sh7372_init_pm_domain(&sh7372_d4);
+	sh7372_init_pm_domain(&sh7372_a4r);
 	sh7372_init_pm_domain(&sh7372_a3rv);
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
 	sh7372_init_pm_domain(&sh7372_a3sp);
 
 	sh7372_pm_add_subdomain(&sh7372_a4lc, &sh7372_a3rv);
+	sh7372_pm_add_subdomain(&sh7372_a4r, &sh7372_a4lc);
 
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
@@ -1020,6 +1022,12 @@ void __init sh7372_add_standard_devices(
 	sh7372_add_device_to_domain(&sh7372_a3sp, &dma2_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &usb_dma0_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &usb_dma1_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &iic0_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &veu0_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &veu1_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &veu2_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &veu3_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &jpu_device);
 }
 
 void __init sh7372_add_early_devices(void)
