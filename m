From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 12:33:44 +0000
Subject: [PATCH 1/2] ARM: shmobile: Rework adding devices to PM domains on Mackerel
Message-Id: <201208131433.45102.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On SH7372 and Mackerel devices are added to PM domains through a
series of rmobile_add_device_to_domain_td() calls where the last
argument is always the same.  This is quite inefficient, so add
a common function for adding devices to PM domains that reads the
domain-device pairs information from a table and use it during SH7372
and Mackerel initialization.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/arm/mach-shmobile/board-mackerel.c          |   37 ++++++--------
 arch/arm/mach-shmobile/include/mach/pm-rmobile.h |   12 ++++
 arch/arm/mach-shmobile/pm-rmobile.c              |   16 ++++++
 arch/arm/mach-shmobile/setup-sh7372.c            |   58 ++++++++++-------------
 4 files changed, 72 insertions(+), 51 deletions(-)

Index: linux/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
=================================--- linux.orig/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
+++ linux/arch/arm/mach-shmobile/include/mach/pm-rmobile.h
@@ -12,6 +12,8 @@
 
 #include <linux/pm_domain.h>
 
+#define DEFAULT_DEV_LATENCY_NS	250000
+
 struct platform_device;
 
 struct rmobile_pm_domain {
@@ -29,6 +31,11 @@ struct rmobile_pm_domain *to_rmobile_pd(
 	return container_of(d, struct rmobile_pm_domain, genpd);
 }
 
+struct pm_domain_device {
+	const char *domain_name;
+	struct platform_device *pdev;
+};
+
 #ifdef CONFIG_PM
 extern void rmobile_init_domains(struct rmobile_pm_domain domains[], int num);
 extern void rmobile_add_device_to_domain_td(const char *domain_name,
@@ -41,11 +48,16 @@ static inline void rmobile_add_device_to
 	rmobile_add_device_to_domain_td(domain_name, pdev, NULL);
 }
 
+extern void rmobile_add_devices_to_domains(struct pm_domain_device data[],
+					   int size);
 #else
 
 #define rmobile_init_domains(domains, num) do { } while (0)
 #define rmobile_add_device_to_domain_td(name, pdev, td) do { } while (0)
 #define rmobile_add_device_to_domain(name, pdev) do { } while (0)
+
+static inline void rmobile_add_devices_to_domains(struct pm_domain_device d[],
+						  int size) {}
 #endif /* CONFIG_PM */
 
 #endif /* PM_RMOBILE_H */
Index: linux/arch/arm/mach-shmobile/setup-sh7372.c
=================================--- linux.orig/arch/arm/mach-shmobile/setup-sh7372.c
+++ linux/arch/arm/mach-shmobile/setup-sh7372.c
@@ -999,15 +999,33 @@ static struct platform_device *sh7372_la
 	&spu1_device,
 };
 
-#define DEV_LATENCY_NS	250000
-
 void __init sh7372_add_standard_devices(void)
 {
-	struct gpd_timing_data latencies = {
-		.stop_latency_ns = DEV_LATENCY_NS,
-		.start_latency_ns = DEV_LATENCY_NS,
-		.save_state_latency_ns = DEV_LATENCY_NS,
-		.restore_state_latency_ns = DEV_LATENCY_NS,
+	struct pm_domain_device domain_devices[] = {
+		{ "A3RV", &vpu_device, },
+		{ "A4MP", &spu0_device, },
+		{ "A4MP", &spu1_device, },
+		{ "A3SP", &scif0_device, },
+		{ "A3SP", &scif1_device, },
+		{ "A3SP", &scif2_device, },
+		{ "A3SP", &scif3_device, },
+		{ "A3SP", &scif4_device, },
+		{ "A3SP", &scif5_device, },
+		{ "A3SP", &scif6_device, },
+		{ "A3SP", &iic1_device, },
+		{ "A3SP", &dma0_device, },
+		{ "A3SP", &dma1_device, },
+		{ "A3SP", &dma2_device, },
+		{ "A3SP", &usb_dma0_device, },
+		{ "A3SP", &usb_dma1_device, },
+		{ "A4R", &iic0_device, },
+		{ "A4R", &veu0_device, },
+		{ "A4R", &veu1_device, },
+		{ "A4R", &veu2_device, },
+		{ "A4R", &veu3_device, },
+		{ "A4R", &jpu_device, },
+		{ "A4R", &tmu00_device, },
+		{ "A4R", &tmu01_device, },
 	};
 
 	sh7372_init_pm_domains();
@@ -1018,30 +1036,8 @@ void __init sh7372_add_standard_devices(
 	platform_add_devices(sh7372_late_devices,
 			    ARRAY_SIZE(sh7372_late_devices));
 
-	rmobile_add_device_to_domain_td("A3RV", &vpu_device, &latencies);
-	rmobile_add_device_to_domain_td("A4MP", &spu0_device, &latencies);
-	rmobile_add_device_to_domain_td("A4MP", &spu1_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &scif0_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &scif1_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &scif2_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &scif3_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &scif4_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &scif5_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &scif6_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &iic1_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &dma0_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &dma1_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &dma2_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &usb_dma0_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &usb_dma1_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &iic0_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &veu0_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &veu1_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &veu2_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &veu3_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &jpu_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &tmu00_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &tmu01_device, &latencies);
+	rmobile_add_devices_to_domains(domain_devices,
+				       ARRAY_SIZE(domain_devices));
 }
 
 static void __init sh7372_earlytimer_init(void)
Index: linux/arch/arm/mach-shmobile/pm-rmobile.c
=================================--- linux.orig/arch/arm/mach-shmobile/pm-rmobile.c
+++ linux/arch/arm/mach-shmobile/pm-rmobile.c
@@ -167,4 +167,20 @@ void rmobile_add_device_to_domain_td(con
 	if (pm_clk_no_clocks(dev))
 		pm_clk_add(dev, NULL);
 }
+
+void rmobile_add_devices_to_domains(struct pm_domain_device data[],
+				    int size)
+{
+	struct gpd_timing_data latencies = {
+		.stop_latency_ns = DEFAULT_DEV_LATENCY_NS,
+		.start_latency_ns = DEFAULT_DEV_LATENCY_NS,
+		.save_state_latency_ns = DEFAULT_DEV_LATENCY_NS,
+		.restore_state_latency_ns = DEFAULT_DEV_LATENCY_NS,
+	};
+	int j;
+
+	for (j = 0; j < size; j++)
+		rmobile_add_device_to_domain_td(data[j].domain_name,
+						data[j].pdev, &latencies);
+}
 #endif /* CONFIG_PM */
Index: linux/arch/arm/mach-shmobile/board-mackerel.c
=================================--- linux.orig/arch/arm/mach-shmobile/board-mackerel.c
+++ linux/arch/arm/mach-shmobile/board-mackerel.c
@@ -1407,14 +1407,23 @@ static struct i2c_board_info i2c1_device
 #define GPIO_PORT168CR	0xE60520A8
 #define SRCR4		0xe61580bc
 #define USCCR1		0xE6058144
-#define DEV_LATENCY_NS	250000
 static void __init mackerel_init(void)
 {
-	struct gpd_timing_data latencies = {
-		.stop_latency_ns = DEV_LATENCY_NS,
-		.start_latency_ns = DEV_LATENCY_NS,
-		.save_state_latency_ns = DEV_LATENCY_NS,
-		.restore_state_latency_ns = DEV_LATENCY_NS,
+	struct pm_domain_device domain_devices[] = {
+		{ "A4LC", &lcdc_device, },
+		{ "A4LC", &hdmi_lcdc_device, },
+		{ "A4LC", &meram_device, },
+		{ "A4MP", &fsi_device, },
+		{ "A3SP", &usbhs0_device, },
+		{ "A3SP", &usbhs1_device, },
+		{ "A3SP", &nand_flash_device, },
+		{ "A3SP", &sh_mmcif_device, },
+		{ "A3SP", &sdhi0_device, },
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+		{ "A3SP", &sdhi1_device, },
+#endif
+		{ "A3SP", &sdhi2_device, },
+		{ "A4R", &ceu_device, },
 	};
 	u32 srcr4;
 	struct clk *clk;
@@ -1630,20 +1639,8 @@ static void __init mackerel_init(void)
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
 
-	rmobile_add_device_to_domain_td("A4LC", &lcdc_device, &latencies);
-	rmobile_add_device_to_domain_td("A4LC", &hdmi_lcdc_device, &latencies);
-	rmobile_add_device_to_domain_td("A4LC", &meram_device, &latencies);
-	rmobile_add_device_to_domain_td("A4MP", &fsi_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &usbhs0_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &usbhs1_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &nand_flash_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &sh_mmcif_device, &latencies);
-	rmobile_add_device_to_domain_td("A3SP", &sdhi0_device, &latencies);
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
-	rmobile_add_device_to_domain_td("A3SP", &sdhi1_device, &latencies);
-#endif
-	rmobile_add_device_to_domain_td("A3SP", &sdhi2_device, &latencies);
-	rmobile_add_device_to_domain_td("A4R", &ceu_device, &latencies);
+	rmobile_add_devices_to_domains(domain_devices,
+				       ARRAY_SIZE(domain_devices));
 
 	hdmi_init_pm_clock();
 	sh7372_pm_init();

