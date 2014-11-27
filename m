From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 27 Nov 2014 15:19:12 +0000
Subject: [PATCH 1/2] ARM: shmobile: lager: Remove DU platform device
Message-Id: <1417101553-5233-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417101553-5233-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417101553-5233-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>

Platform data support has been removed from the DU driver, drop DU
support from the legacy Lager board file. The multiplatform DT-based
Lager support should be used instead.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager.c | 58 ------------------------------------
 1 file changed, 58 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index b47262afb240..f8197eb6e566 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -32,7 +32,6 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
-#include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-gen2-phy.h>
 #include <linux/platform_device.h>
 #include <linux/phy.h>
@@ -83,61 +82,6 @@
  *
  */
 
-/* DU */
-static struct rcar_du_encoder_data lager_du_encoders[] = {
-	{
-		.type = RCAR_DU_ENCODER_VGA,
-		.output = RCAR_DU_OUTPUT_DPAD0,
-	}, {
-		.type = RCAR_DU_ENCODER_NONE,
-		.output = RCAR_DU_OUTPUT_LVDS1,
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
-static const struct rcar_du_platform_data lager_du_pdata __initconst = {
-	.encoders = lager_du_encoders,
-	.num_encoders = ARRAY_SIZE(lager_du_encoders),
-};
-
-static const struct resource du_resources[] __initconst = {
-	DEFINE_RES_MEM(0xfeb00000, 0x70000),
-	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
-	DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
-	DEFINE_RES_IRQ(gic_spi(256)),
-	DEFINE_RES_IRQ(gic_spi(268)),
-	DEFINE_RES_IRQ(gic_spi(269)),
-};
-
-static void __init lager_add_du_device(void)
-{
-	struct platform_device_info info = {
-		.name = "rcar-du-r8a7790",
-		.id = -1,
-		.res = du_resources,
-		.num_res = ARRAY_SIZE(du_resources),
-		.data = &lager_du_pdata,
-		.size_data = sizeof(lager_du_pdata),
-		.dma_mask = DMA_BIT_MASK(32),
-	};
-
-	platform_device_register_full(&info);
-}
-
 /* LEDS */
 static struct gpio_led lager_leds[] = {
 	{
@@ -800,8 +744,6 @@ static void __init lager_add_standard_devices(void)
 
 	platform_device_register_full(&ether_info);
 
-	lager_add_du_device();
-
 	platform_device_register_resndata(NULL, "qspi", 0,
 					  qspi_resources,
 					  ARRAY_SIZE(qspi_resources),
-- 
2.0.4

