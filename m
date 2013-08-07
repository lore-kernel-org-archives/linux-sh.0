From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 07 Aug 2013 22:56:31 +0000
Subject: [PATCH v2 8/9] ARM: shmobile: lager: Add Display Unit support
Message-Id: <1375916192-22647-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Only the VGA output is currently supported.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 76363f9..cb2457e 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -28,6 +28,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
+#include <linux/platform_data/rcar-du.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -38,6 +39,38 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* DU */
+static struct rcar_du_encoder_data lager_du_encoders[] = {
+	{
+		.type = RCAR_DU_ENCODER_VGA,
+		.output = RCAR_DU_OUTPUT_DPAD0,
+	}, {
+		.type = RCAR_DU_ENCODER_NONE,
+		.output = RCAR_DU_OUTPUT_LVDS1,
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
+static const struct rcar_du_platform_data lager_du_pdata __initdata = {
+	.encoders = lager_du_encoders,
+	.num_encoders = ARRAY_SIZE(lager_du_encoders),
+};
+
 /* LEDS */
 static struct gpio_led lager_leds[] = {
 	{
@@ -107,6 +140,13 @@ static const struct resource ether_resources[] __initdata = {
 };
 
 static const struct pinctrl_map lager_pinctrl_map[] = {
+	/* DU (CN10: ARGB0, CN13: LVDS) */
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
+				  "du_rgb666", "du"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
+				  "du_sync_1", "du"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
+				  "du_clk_out_0", "du"),
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
 				  "scif0_data", "scif0"),
@@ -138,6 +178,8 @@ static void __init lager_add_standard_devices(void)
 	r8a7790_pinmux_init();
 
 	r8a7790_add_standard_devices();
+	r8a7790_add_du_device(&lager_du_pdata);
+
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
 				      &lager_leds_pdata,
 				      sizeof(lager_leds_pdata));
-- 
1.8.1.5

