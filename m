From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 May 2014 14:51:21 +0000
Subject: [PATCH v3 3/4] ARM: shmobile: armadillo800eva legacy: Add LED support
Message-Id: <1400079082-6340-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Cfr. r8a7740-armadillo800eva-reference.dts

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Changes names from "led[1-3]" to "LED[3-6]"
v2:
  - No changes
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   35 ++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 48a1453b3378..92d24a4f3fff 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -586,6 +586,40 @@ static struct platform_device hdmi_lcdc_device = {
 	},
 };
 
+/* LEDS */
+static struct gpio_led gpio_leds[] = {
+	{
+		.name		= "LED3",
+		.gpio		= 102,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED4",
+		.gpio		= 111,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED5",
+		.gpio		= 110,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}, {
+		.name		= "LED6",
+		.gpio		= 177,
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
 /* GPIO KEY */
 #define GPIO_KEY(c, g, d, ...) \
 	{ .code = c, .gpio = g, .desc = d, .active_low = 1, __VA_ARGS__ }
@@ -1077,6 +1111,7 @@ static struct platform_device *eva_devices[] __initdata = {
 	&lcdc0_device,
 	&pwm_device,
 	&pwm_backlight_device,
+	&leds_gpio_device,
 	&gpio_keys_device,
 	&sh_eth_device,
 	&vcc_sdhi0,
-- 
1.7.9.5

