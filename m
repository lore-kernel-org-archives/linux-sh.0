From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Nov 2014 15:19:13 +0000
Subject: [PATCH 2/2] ARM: shmobile: marzen: Remove DU platform device
Message-Id: <1417101553-5233-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417101553-5233-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417101553-5233-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>

Platform data support has been removed from the DU driver, drop DU
support from the legacy Marzen board file. The multiplatform DT-based
Marzen support should be used instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 58 -----------------------------------
 1 file changed, 58 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 994dc7d86ae2..598f704f76ae 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -27,7 +27,6 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
-#include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-phy.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -171,62 +170,6 @@ static struct platform_device hspi_device = {
 	.num_resources	= ARRAY_SIZE(hspi_resources),
 };
 
-/*
- * DU
- *
- * The panel only specifies the [hv]display and [hv]total values. The position
- * and width of the sync pulses don't matter, they're copied from VESA timings.
- */
-static struct rcar_du_encoder_data du_encoders[] = {
-	{
-		.type = RCAR_DU_ENCODER_VGA,
-		.output = RCAR_DU_OUTPUT_DPAD0,
-	}, {
-		.type = RCAR_DU_ENCODER_LVDS,
-		.output = RCAR_DU_OUTPUT_DPAD1,
-		.connector.lvds.panel = {
-			.width_mm = 210,
-			.height_mm = 158,
-			.mode = {
-				.pixelclock = 65000000,
-				.hactive = 1024,
-				.hfront_porch = 20,
-				.hback_porch = 160,
-				.hsync_len = 136,
-				.vactive = 768,
-				.vfront_porch = 3,
-				.vback_porch = 29,
-				.vsync_len = 6,
-			},
-		},
-	},
-};
-
-static const struct rcar_du_platform_data du_pdata __initconst = {
-	.encoders = du_encoders,
-	.num_encoders = ARRAY_SIZE(du_encoders),
-};
-
-static const struct resource du_resources[] __initconst = {
-	DEFINE_RES_MEM(0xfff80000, 0x40000),
-	DEFINE_RES_IRQ(gic_iid(0x3f)),
-};
-
-static void __init marzen_add_du_device(void)
-{
-	struct platform_device_info info = {
-		.name = "rcar-du-r8a7779",
-		.id = -1,
-		.res = du_resources,
-		.num_res = ARRAY_SIZE(du_resources),
-		.data = &du_pdata,
-		.size_data = sizeof(du_pdata),
-		.dma_mask = DMA_BIT_MASK(32),
-	};
-
-	platform_device_register_full(&info);
-}
-
 /* LEDS */
 static struct gpio_led marzen_leds[] = {
 	{
@@ -385,7 +328,6 @@ static void __init marzen_init(void)
 	platform_device_register_full(&vin1_info);
 	platform_device_register_full(&vin3_info);
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
-	marzen_add_du_device();
 }
 
 static const char *marzen_boards_compat_dt[] __initdata = {
-- 
2.0.4

