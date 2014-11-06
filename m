From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Nov 2014 12:50:55 +0000
Subject: [PATCH] ARM: shmobile: kzm9g legacy: Add LED support
Message-Id: <1415278255-2047-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for the 4 GPIO-controlled LEDs on the kzm9g development
board.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 7c9b63bdde9fa458..e9d7dd65fd76ae18 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -528,6 +528,44 @@ static struct platform_device sdhi2_device = {
 	},
 };
 
+/* LEDS */
+static struct gpio_led gpio_leds[] = {
+	{
+		.name		= "LED1",
+		.gpio		= 20,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED2",
+		.gpio		= 21,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED3",
+		.gpio		= 22,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED4",
+		.gpio		= 23,
+		.active_low	= 1,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+};
+
+static struct gpio_led_platform_data leds_gpio_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio_device = {
+	.name   = "leds-gpio",
+	.id     = -1,
+	.dev    = {
+		.platform_data  = &leds_gpio_info,
+	},
+};
+
 /* KEY */
 #define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
 
@@ -793,6 +831,7 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&vcc_sdhi2,
 	&sdhi0_device,
 	&sdhi2_device,
+	&leds_gpio_device,
 	&gpio_keys_device,
 	&fsi_device,
 	&fsi_ak4648_device,
-- 
1.9.1

