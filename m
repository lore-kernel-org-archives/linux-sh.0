From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 08 Aug 2013 12:03:30 +0000
Subject: [PATCH v3 4/8] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <1375963414-31096-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Support the DU0 VGA and DU1 LVDS outputs. DU1 is connected to a
Mitsubishi AA104XD12 panel (10.4" XGA).

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 72 +++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 3551b54..6499f1a 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -29,6 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
+#include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-phy.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -167,6 +168,63 @@ static struct platform_device hspi_device = {
 	.num_resources	= ARRAY_SIZE(hspi_resources),
 };
 
+/*
+ * DU
+ *
+ * The panel only specifies the [hv]display and [hv]total values. The position
+ * and width of the sync pulses don't matter, they're copied from VESA timings.
+ */
+static struct rcar_du_encoder_data du_encoders[] = {
+	{
+		.type = RCAR_DU_ENCODER_VGA,
+		.output = RCAR_DU_OUTPUT_DPAD0,
+	}, {
+		.type = RCAR_DU_ENCODER_LVDS,
+		.output = RCAR_DU_OUTPUT_DPAD1,
+		.connector.lvds.panel = {
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
+static const struct rcar_du_platform_data du_pdata __initconst = {
+	.encoders = du_encoders,
+	.num_encoders = ARRAY_SIZE(du_encoders),
+};
+
+static const struct resource du_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfff80000, 0x40000),
+	DEFINE_RES_IRQ(gic_iid(0x3f)),
+};
+
+static void __init marzen_add_du_device(void)
+{
+	struct platform_device_info info = {
+		.name = "rcar-du-r8a7779",
+		.id = -1,
+		.res = du_resources,
+		.num_res = ARRAY_SIZE(du_resources),
+		.data = &du_pdata,
+		.size_data = sizeof(du_pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 /* LEDS */
 static struct gpio_led marzen_leds[] = {
 	{
@@ -207,6 +265,19 @@ static struct platform_device *marzen_devices[] __initdata = {
 };
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
+	/* DU (CN10: ARGB0, CN13: LVDS) */
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du0_rgb888", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du0_sync_1", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du0_clk_out_0", "du0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du1_rgb666", "du1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du1_sync_1", "du1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7779", "pfc-r8a7779",
+				  "du1_clk_out", "du1"),
 	/* HSPI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7779",
 				  "hspi0", "hspi0"),
@@ -255,6 +326,7 @@ static void __init marzen_init(void)
 
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
+	marzen_add_du_device();
 }
 
 static const char *marzen_boards_compat_dt[] __initdata = {
-- 
1.8.1.5

