From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Mar 2013 18:05:50 +0000
Subject: [PATCH 2/2] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <1364407550-30652-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Support the DU0 VGA and DU1 LVDS outputs. DU1 is connected to a
Mitsubishi AA104XD12 panel (10.4" XGA).

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/configs/marzen_defconfig            |  2 ++
 arch/arm/mach-shmobile/board-marzen.c        | 51 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h |  1 -
 arch/arm/mach-shmobile/setup-r8a7779.c       | 30 ----------------
 4 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 8e7329b..60c4b31 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -83,6 +83,8 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_SSB=y
+CONFIG_DRM=y
+CONFIG_DRM_RCAR_DU=y
 CONFIG_USB=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 9105285..fcd1a56 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -40,6 +40,7 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_data/rcar-du.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
@@ -149,6 +150,42 @@ static struct platform_device hspi_device = {
 	.num_resources	= ARRAY_SIZE(hspi_resources),
 };
 
+/* DU
+ *
+ * The panel only specifies the [hv]display and [hv]total values. The position
+ * and width of the sync pulses don't matter, they're copied from VESA timings.
+ */
+static struct rcar_du_encoder_data rcar_du_encoders[] = {
+	{
+		.encoder = RCAR_DU_ENCODER_VGA,
+		.output = 0,
+	}, {
+		.encoder = RCAR_DU_ENCODER_LVDS,
+		.output = 1,
+		.u.lvds.panel = {
+			.width_mm = 210,
+			.height_mm = 158,
+			.mode = {
+				.clock = 65000,
+				.hdisplay = 1024,
+				.hsync_start = 1048,
+				.hsync_end = 1184,
+				.htotal = 1344,
+				.vdisplay = 768,
+				.vsync_start = 771,
+				.vsync_end = 777,
+				.vtotal = 806,
+				.flags = 0,
+			},
+		},
+	},
+};
+
+static struct rcar_du_platform_data rcar_du_pdata = {
+	.encoders = rcar_du_encoders,
+	.num_encoders = ARRAY_SIZE(rcar_du_encoders),
+};
+
 /* USB PHY */
 static struct resource usb_phy_resources[] = {
 	[0] = {
@@ -360,6 +397,19 @@ void __init marzen_init_late(void)
 }
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
+	/* DU0 (CN10: ARGB0, CN13: LVDS) */
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du.0", "pfc-r8a7779",
+				  "du0_rgb888", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du.0", "pfc-r8a7779",
+				  "du0_sync_1", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du.0", "pfc-r8a7779",
+				  "du0_clk_out_0", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du.0", "pfc-r8a7779",
+				  "du1_rgb666", "du1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du.0", "pfc-r8a7779",
+				  "du1_sync_1", "du1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du.0", "pfc-r8a7779",
+				  "du1_clk_out", "du1"),
 	/* HSPI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7779",
 				  "hspi0", "hspi0"),
@@ -407,6 +457,7 @@ static void __init marzen_init(void)
 
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
+	r8a7779_add_du_device(&rcar_du_pdata);
 }
 
 MACHINE_START(MARZEN, "marzen")
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 4531872..03f73de 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -68,7 +68,6 @@ extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
-extern void r8a7779_add_du_device(void *pdata);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 2f817d8..a460ba3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -393,29 +393,6 @@ static struct platform_device sata_device = {
 	},
 };
 
-static struct resource du_resources[] = {
-	[0] = {
-		.name	= "Display Unit",
-		.start	= 0xfff80000,
-		.end	= 0xfffb1007,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= gic_iid(0x3f),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device du_device = {
-	.name		= "rcar-du",
-	.num_resources	= ARRAY_SIZE(du_resources),
-	.resource	= du_resources,
-	.id		= 0,
-	.dev	= {
-		.coherent_dma_mask = ~0,
-	},
-};
-
 static struct platform_device *r8a7779_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -451,13 +428,6 @@ void __init r8a7779_add_standard_devices(void)
 			    ARRAY_SIZE(r8a7779_late_devices));
 }
 
-void __init r8a7779_add_du_device(void *pdata)
-{
-	du_device.dev.platform_data = pdata;
-
-	platform_device_register(&du_device);
-}
-
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak r8a7779_register_twd(void) { }
 
-- 
1.8.1.5

