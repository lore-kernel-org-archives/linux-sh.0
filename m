From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 06:43:43 +0000
Subject: [PATCH 03/03] ARM: mach-shmobile: sh7372 A4R support
Message-Id: <20110826064343.373.49811.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds sh7372 A4R power domain support.

The sh7372 A3SP hardware power domain contains the
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

 arch/arm/mach-shmobile/board-ap4evb.c        |    1 
 arch/arm/mach-shmobile/board-mackerel.c      |    1 
 arch/arm/mach-shmobile/include/mach/sh7372.h |    4 +
 arch/arm/mach-shmobile/intc-sh7372.c         |   52 ++++++++++++++++++++++
 arch/arm/mach-shmobile/pm-sh7372.c           |   59 +++++++++++++++++++++++---
 arch/arm/mach-shmobile/setup-sh7372.c        |    7 +++
 6 files changed, 118 insertions(+), 6 deletions(-)

--- 0012/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2011-08-26 12:45:47.000000000 +0900
@@ -1411,6 +1411,7 @@ static void __init ap4evb_init(void)
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sh_mmcif_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi0_device);
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &ceu_device);
 
 	hdmi_init_pm_clock();
 	fsi_init_pm_clock();
--- 0012/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-08-26 12:45:47.000000000 +0900
@@ -1596,6 +1596,7 @@ static void __init mackerel_init(void)
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi1_device);
 #endif
 	sh7372_add_device_to_domain(&sh7372_a3sp, &sdhi2_device);
+	sh7372_add_device_to_domain(&sh7372_a4r, &ceu_device);
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
--- 0012/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2011-08-26 12:46:51.000000000 +0900
@@ -491,6 +491,7 @@ static inline struct sh7372_pm_domain *t
 extern struct sh7372_pm_domain sh7372_a4lc;
 extern struct sh7372_pm_domain sh7372_a4mp;
 extern struct sh7372_pm_domain sh7372_d4;
+extern struct sh7372_pm_domain sh7372_a4r;
 extern struct sh7372_pm_domain sh7372_a3rv;
 extern struct sh7372_pm_domain sh7372_a3ri;
 extern struct sh7372_pm_domain sh7372_a3sp;
@@ -504,4 +505,7 @@ extern void sh7372_add_device_to_domain(
 #define sh7372_add_device_to_domain(pd, pdev) do { } while(0)
 #endif /* CONFIG_PM */
 
+extern void sh7372_intcs_suspend(void);
+extern void sh7372_intcs_resume(void);
+
 #endif /* __ASM_SH7372_H__ */
--- 0001/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2011-08-26 12:45:47.000000000 +0900
@@ -607,9 +607,16 @@ static void intcs_demux(unsigned int irq
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
@@ -618,3 +625,46 @@ void __init sh7372_init_irq(void)
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
--- 0012/arch/arm/mach-shmobile/pm-sh7372.c
+++ work/arch/arm/mach-shmobile/pm-sh7372.c	2011-08-26 12:47:24.000000000 +0900
@@ -44,6 +44,7 @@
 #define SPDCR 0xe6180008
 #define SWUCR 0xe6180014
 #define SBAR 0xe6180020
+#define WUPRMSK 0xe6180028
 #define WUPSMSK 0xe618002c
 #define WUPSMSK2 0xe6180048
 #define PSTR 0xe6180080
@@ -152,8 +153,21 @@ static int pd_power_down_a3rv(struct gen
 	return ret;
 }
 
+static int pd_power_up_a4lc(struct generic_pm_domain *genpd)
+{
+	int ret = pd_power_up(genpd);
+
+	/* force A4R to activate INTCS that may be needed by LCDCs */
+	pm_genpd_poweron(&sh7372_a4r.genpd);
+
+	return ret;
+}
+
 static int pd_power_down_a4lc(struct generic_pm_domain *genpd)
 {
+	/* try to power down A4R since LCDCs now are off */
+	genpd_queue_power_off_work(&sh7372_a4r.genpd);
+
 	/* only power down A4LC if A3RV is off */
 	if (!(__raw_readl(PSTR) & (1 << sh7372_a3rv.bit_shift)))
 		return pd_power_down(genpd);
@@ -161,6 +175,28 @@ static int pd_power_down_a4lc(struct gen
 	return -EBUSY;
 }
 
+static int pd_power_up_a4r(struct generic_pm_domain *genpd)
+{
+	int ret = pd_power_up(genpd);
+
+	sh7372_intcs_resume();
+
+	return ret;
+}
+
+static int pd_power_down_a4r(struct generic_pm_domain *genpd)
+{
+	unsigned long lcdc_bits = (1 << 0) | (1 << 17);
+
+	/* refuse A4R power down if LCDCs are operating - they need INTCS */
+	if ((__raw_readl(MSTPSR1) & lcdc_bits) != lcdc_bits)
+		return -EBUSY;
+
+	sh7372_intcs_suspend();
+	__raw_writel(0x300fffff, WUPRMSK); /* avoid wakeup */
+
+	return pd_power_down(genpd);
+}
 static bool pd_active_wakeup(struct device *dev)
 {
 	return true;
@@ -175,17 +211,26 @@ void sh7372_init_pm_domain(struct sh7372
 	genpd->start_device = pm_clk_resume;
 	genpd->active_wakeup = pd_active_wakeup;
 
+	/* default power up/down functions */
+	genpd->power_off = pd_power_down;
+	genpd->power_on = pd_power_up;
+
+	/* execute default power on */
+	genpd->power_on(&sh7372_pd->genpd);
+
 	if (sh7372_pd = &sh7372_a4lc) {
 		genpd->power_off = pd_power_down_a4lc;
-		genpd->power_on = pd_power_up;
+		genpd->power_on = pd_power_up_a4lc;
+	} else if (sh7372_pd = &sh7372_a4r) {
+		genpd->power_off = pd_power_down_a4r;
+		genpd->power_on = pd_power_up_a4r;
 	} else if (sh7372_pd = &sh7372_a3rv) {
 		genpd->power_off = pd_power_down_a3rv;
 		genpd->power_on = pd_power_up_a3rv;
-	} else {
-		genpd->power_off = pd_power_down;
-		genpd->power_on = pd_power_up;
 	}
-	genpd->power_on(&sh7372_pd->genpd);
+
+	if ((sh7372_pd = &sh7372_a3rv) || (sh7372_pd = &sh7372_a3ri))
+		pm_genpd_add_subdomain(&sh7372_a4r.genpd, &sh7372_pd->genpd);
 }
 
 void sh7372_add_device_to_domain(struct sh7372_pm_domain *sh7372_pd,
@@ -212,6 +257,10 @@ struct sh7372_pm_domain sh7372_d4 = {
 	.bit_shift = 3,
 };
 
+struct sh7372_pm_domain sh7372_a4r = {
+	.bit_shift = 5,
+};
+
 struct sh7372_pm_domain sh7372_a3rv = {
 	.bit_shift = 6,
 };
--- 0012/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-08-26 12:45:47.000000000 +0900
@@ -990,6 +990,7 @@ void __init sh7372_add_standard_devices(
 	sh7372_init_pm_domain(&sh7372_a4lc);
 	sh7372_init_pm_domain(&sh7372_a4mp);
 	sh7372_init_pm_domain(&sh7372_d4);
+	sh7372_init_pm_domain(&sh7372_a4r);
 	sh7372_init_pm_domain(&sh7372_a3rv);
 	sh7372_init_pm_domain(&sh7372_a3ri);
 	sh7372_init_pm_domain(&sh7372_a3sg);
@@ -1017,6 +1018,12 @@ void __init sh7372_add_standard_devices(
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
