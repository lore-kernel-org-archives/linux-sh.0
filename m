From: Arnd Hannemann <arnd@arndnet.de>
Date: Mon, 16 Aug 2010 07:24:27 +0000
Subject: [PATCH] ARM: mach-shmobile: AP4EVB: use gpio-leds for leds v2
Message-Id: <1281943467-25582-1-git-send-email-arnd@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This allows control of the leds on the AP4EVB board by kernel events (triggers)
like mmc0/mmc1. In userland, the leds won't be available anymore via
/sys/class/gpio but via /sys/class/leds.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 Changes since v1:
 - remove trailing whitespaces
 - removed unneeded dereference

 arch/arm/mach-shmobile/board-ap4evb.c |   52 ++++++++++++++++++++++++---------
 1 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 23d472f..88fdd40 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -39,6 +39,7 @@
 #include <linux/sh_clk.h>
 #include <linux/gpio.h>
 #include <linux/input.h>
+#include <linux/leds.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
 
@@ -650,7 +651,44 @@ static struct platform_device hdmi_device = {
 	},
 };
 
+static struct gpio_led ap4evb_leds[] = {
+	{
+		.name			= "led4",
+		.gpio			= GPIO_PORT185,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+	{
+		.name			= "led2",
+		.gpio			= GPIO_PORT186,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+	{
+		.name			= "led3",
+		.gpio			= GPIO_PORT187,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+	{
+		.name			= "led1",
+		.gpio			= GPIO_PORT188,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}
+};
+
+static struct gpio_led_platform_data ap4evb_leds_pdata = {
+	.num_leds = ARRAY_SIZE(ap4evb_leds),
+	.leds = ap4evb_leds,
+};
+
+static struct platform_device leds_device = {
+	.name = "leds-gpio",
+	.id = 0,
+	.dev = {
+		.platform_data  = &ap4evb_leds_pdata,
+	},
+};
+
 static struct platform_device *ap4evb_devices[] __initdata = {
+	&leds_device,
 	&nor_flash_device,
 	&smc911x_device,
 	&sdhi0_device,
@@ -840,20 +878,6 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_CS5A,	NULL);
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
 
-	/* enable LED 1 - 4 */
-	gpio_request(GPIO_PORT185, NULL);
-	gpio_request(GPIO_PORT186, NULL);
-	gpio_request(GPIO_PORT187, NULL);
-	gpio_request(GPIO_PORT188, NULL);
-	gpio_direction_output(GPIO_PORT185, 1);
-	gpio_direction_output(GPIO_PORT186, 1);
-	gpio_direction_output(GPIO_PORT187, 1);
-	gpio_direction_output(GPIO_PORT188, 1);
-	gpio_export(GPIO_PORT185, 0);
-	gpio_export(GPIO_PORT186, 0);
-	gpio_export(GPIO_PORT187, 0);
-	gpio_export(GPIO_PORT188, 0);
-
 	/* enable Debug switch (S6) */
 	gpio_request(GPIO_PORT32, NULL);
 	gpio_request(GPIO_PORT33, NULL);
-- 
1.7.0.4

