From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 04 Jul 2013 19:13:27 +0000
Subject: [PATCH v2 4/7] ARM: mach-shmobile: mackerel: Use gpio-backlight
Message-Id: <1372965210-10024-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the backlight callback with a gpio-backlight platform device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c | 34 ++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index fa3407d..023cf05 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -41,6 +41,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/sh_flctl.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/gpio_backlight.h>
 #include <linux/pm_clock.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -49,7 +50,6 @@
 #include <linux/tca6416_keypad.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <linux/dma-mapping.h>
-
 #include <video/sh_mobile_hdmi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
@@ -346,7 +346,7 @@ static struct platform_device meram_device = {
 	},
 };
 
-/* LCDC */
+/* LCDC and backlight */
 static struct fb_videomode mackerel_lcdc_modes[] = {
 	{
 		.name		= "WVGA Panel",
@@ -362,13 +362,6 @@ static struct fb_videomode mackerel_lcdc_modes[] = {
 	},
 };
 
-static int mackerel_set_brightness(int brightness)
-{
-	gpio_set_value(31, brightness);
-
-	return 0;
-}
-
 static const struct sh_mobile_meram_cfg lcd_meram_cfg = {
 	.icb[0] = {
 		.meram_size     = 0x40,
@@ -393,11 +386,6 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 			.width		= 152,
 			.height		= 91,
 		},
-		.bl_info = {
-			.name = "sh_mobile_lcdc_bl",
-			.max_brightness = 1,
-			.set_brightness = mackerel_set_brightness,
-		},
 		.meram_cfg = &lcd_meram_cfg,
 	}
 };
@@ -425,6 +413,20 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+static struct gpio_backlight_platform_data gpio_backlight_data = {
+	.fbdev = &lcdc_device.dev,
+	.gpio = 31,
+	.def_value = 1,
+	.name = "backlight",
+};
+
+static struct platform_device gpio_backlight_device = {
+	.name = "gpio-backlight",
+	.dev = {
+		.platform_data = &gpio_backlight_data,
+	},
+};
+
 /* HDMI */
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.flags		= HDMI_SND_SRC_SPDIF,
@@ -1231,6 +1233,7 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
+	&gpio_backlight_device,
 	&usbhs0_device,
 	&usbhs1_device,
 	&leds_device,
@@ -1413,9 +1416,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_LCDDISP,  NULL);
 	gpio_request(GPIO_FN_LCDDCK,   NULL);
 
-	/* backlight, off by default */
-	gpio_request_one(31, GPIOF_OUT_INIT_LOW, NULL);
-
 	gpio_request_one(151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
 	/* USBHS0 */
-- 
1.8.1.5

