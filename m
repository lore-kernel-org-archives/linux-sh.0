From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 26 Oct 2012 13:38:49 +0000
Subject: [PATCH v3 3/5] ARM: mach-shmobile: armadillo800eva: Add backlight support
Message-Id: <1351258731-14111-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The flat panel backlight on the Armadillo 800 EVA board is driven by the
TPU PWM output.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   51 ++++++++++++++++++++++--
 1 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 3cc8b1c..7ac7c41 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/pwm_backlight.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
@@ -37,6 +38,7 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
+#include <linux/platform_data/pwm-rmob.h>
 #include <linux/i2c-gpio.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -370,7 +372,49 @@ static struct platform_device sh_eth_device = {
 	.num_resources = ARRAY_SIZE(sh_eth_resources),
 };
 
-/* LCDC */
+/* PWM */
+static struct resource pwm_resources[] = {
+	[0] = {
+		.start = 0xe6600000,
+		.end = 0xe66000ff,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct rmob_tpu_pwm_platform_data pwm_device_data = {
+	.channels[2] = {
+		.polarity = 0,
+		.pin_gpio = GPIO_PORT202,
+		.pin_gpio_fn = GPIO_FN_TPU0TO2_PORT202,
+	}
+};
+
+static struct platform_device pwm_device = {
+	.name = "rmob_tpu_pwm",
+	.id = 0,
+	.dev = {
+		.platform_data = &pwm_device_data,
+	},
+	.num_resources = ARRAY_SIZE(pwm_resources),
+	.resource = pwm_resources,
+};
+
+/* LCDC and backlight */
+static struct platform_pwm_backlight_data pwm_backlight_data = {
+	.pwm_id = RMOB_TPU_PWM_ID(0, 2),
+	.lth_brightness = 50,
+	.max_brightness = 255,
+	.dft_brightness = 255,
+	.pwm_period_ns = 33333, /* 30kHz */
+};
+
+static struct platform_device pwm_backlight_device = {
+	.name = "pwm-backlight",
+	.dev = {
+		.platform_data = &pwm_backlight_data,
+	},
+};
+
 static struct fb_videomode lcdc0_mode = {
 	.name		= "AMPIER/AM-800480",
 	.xres		= 800,
@@ -918,6 +962,8 @@ static struct i2c_board_info i2c2_devices[] = {
  */
 static struct platform_device *eva_devices[] __initdata = {
 	&lcdc0_device,
+	&pwm_device,
+	&pwm_backlight_device,
 	&gpio_keys_device,
 	&sh_eth_device,
 	&sdhi0_device,
@@ -1027,9 +1073,6 @@ static void __init eva_init(void)
 	gpio_request(GPIO_PORT61, NULL); /* LCDDON */
 	gpio_direction_output(GPIO_PORT61, 1);
 
-	gpio_request(GPIO_PORT202, NULL); /* LCD0_LED_CONT */
-	gpio_direction_output(GPIO_PORT202, 0);
-
 	/* Touchscreen */
 	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
 	gpio_request(GPIO_PORT166,	NULL); /* TP_RST_B */
-- 
1.7.8.6

