From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Aug 2011 05:44:33 +0000
Subject: [PATCH 04/07] ARM: mach-shmobile: Kota2 GPIO LEDs support
Message-Id: <20110818054433.23410.47694.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch ties in GPIO LEDs support on the Kota2
board. For now all LEDs are driven by the GPIO LED
driver, but in the not so distant future the LEDs
hooked up to TPU pin functions will be moved over
to the recently posted LED TPU driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- 0007/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-08-17 22:37:10.000000000 +0900
@@ -32,6 +32,7 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 #include <linux/gpio_keys.h>
+#include <linux/leds.h>
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -145,10 +146,36 @@ static struct platform_device gpio_keys_
 	},
 };
 
+#define GPIO_LED(n, g) { .name = n, .gpio = g }
+
+static struct gpio_led gpio_leds[] = {
+	GPIO_LED("V2513", GPIO_PORT153), /* PORT153 [TPU1T02] -> V2513 */
+	GPIO_LED("V2514", GPIO_PORT199), /* PORT199 [TPU4TO1] -> V2514 */
+	GPIO_LED("V2515", GPIO_PORT197), /* PORT197 [TPU2TO1] -> V2515 */
+	GPIO_LED("KEYLED", GPIO_PORT163), /* PORT163 [TPU3TO0] -> KEYLED */
+	GPIO_LED("G", GPIO_PORT20), /* PORT20 [GPO0] -> LED7 -> "G" */
+	GPIO_LED("H", GPIO_PORT21), /* PORT21 [GPO1] -> LED8 -> "H" */
+	GPIO_LED("J", GPIO_PORT22), /* PORT22 [GPO2] -> LED9 -> "J" */
+};
+
+static struct gpio_led_platform_data gpio_leds_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device gpio_leds_device = {
+	.name   = "leds-gpio",
+	.id     = -1,
+	.dev    = {
+		.platform_data  = &gpio_leds_info,
+	},
+};
+
 static struct platform_device *kota2_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
 	&gpio_keys_device,
+	&gpio_leds_device,
 };
 
 static struct map_desc kota2_io_desc[] __initdata = {
