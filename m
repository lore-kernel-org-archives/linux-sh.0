From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 04 Jul 2012 03:55:37 +0000
Subject: [PATCH 3/7] ARM: shmobile: r8a7740: add A3SP pm domain support
Message-Id: <87lij0tc21.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds basic A3SP pm domain support.
Now, below devices can be controled by PM

DMAC1/2/3, IPMMU, DDM, FLCTL, SYS-HPB, BBIF1, MSIOF1/2,
SCIFA,SCIFB, IIC1, IrDA, USBH, USBDMAC, SDHI0/1/2, TPU,
DREQPAK (Sys),  MMCIF, RSPI, SIM, USBF

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    1 +
 arch/arm/mach-shmobile/pm-r8a7740.c           |   16 ++++++++++++++++
 arch/arm/mach-shmobile/setup-r8a7740.c        |   16 ++++++++++++++++
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 6937352..0bc8266 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -625,6 +625,7 @@ struct r8a7740_pm_domain *to_r8a7740_pd(struct generic_pm_domain *d)
 
 #ifdef CONFIG_PM
 extern struct r8a7740_pm_domain r8a7740_a4s;
+extern struct r8a7740_pm_domain r8a7740_a3sp;
 
 extern void r8a7740_init_pm_domain(struct r8a7740_pm_domain *r8a7740_pd);
 extern void r8a7740_add_device_to_domain(struct r8a7740_pm_domain *r8a7740_pd,
diff --git a/arch/arm/mach-shmobile/pm-r8a7740.c b/arch/arm/mach-shmobile/pm-r8a7740.c
index 5b0fc91..faa0254 100644
--- a/arch/arm/mach-shmobile/pm-r8a7740.c
+++ b/arch/arm/mach-shmobile/pm-r8a7740.c
@@ -181,4 +181,20 @@ struct r8a7740_pm_domain r8a7740_a4s = {
 	.suspend	= r8a7740_a4s_suspend,
 };
 
+static int r8a7740_a3sp_suspend(void)
+{
+	/*
+	 * Serial consoles make use of SCIF hardware located in A3SP,
+	 * keep such power domain on if "no_console_suspend" is set.
+	 */
+	return console_suspend_enabled ? 0 : -EBUSY;
+}
+
+struct r8a7740_pm_domain r8a7740_a3sp = {
+	.genpd.name	= "A3SP",
+	.bit_shift	= 11,
+	.gov		= &pm_domain_always_on_gov,
+	.no_debug	= true,
+	.suspend	= r8a7740_a3sp_suspend,
+};
 #endif /* CONFIG_PM */
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index c185ae4..1c95067 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -674,12 +674,28 @@ void __init r8a7740_add_standard_devices(void)
 
 	/* PM domain */
 	r8a7740_init_pm_domain(&r8a7740_a4s);
+	r8a7740_init_pm_domain(&r8a7740_a3sp);
+
+	r8a7740_pm_add_subdomain(&r8a7740_a4s, &r8a7740_a3sp);
 
 	/* add devices */
 	platform_add_devices(r8a7740_early_devices,
 			    ARRAY_SIZE(r8a7740_early_devices));
 	platform_add_devices(r8a7740_late_devices,
 			     ARRAY_SIZE(r8a7740_late_devices));
+
+	/* add devices to PM domain  */
+
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif0_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif1_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif2_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif3_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif4_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif5_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif6_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scif7_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&scifb_device);
+	r8a7740_add_device_to_domain(&r8a7740_a3sp,	&i2c1_device);
 }
 
 static void __init r8a7740_earlytimer_init(void)
-- 
1.7.5.4

