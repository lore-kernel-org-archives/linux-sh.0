From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 09 Jan 2013 00:52:46 +0000
Subject: [PATCH v2 26/29] ARM: shmobile: armadillo800eva: Register pinctrl mappings for LCDC0
Message-Id: <1357692769-1432-27-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based LCDC0 pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   41 +++++++-----------------
 1 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5353adf..b6e50cd 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
@@ -906,6 +907,15 @@ static struct platform_device *eva_devices[] __initdata = {
 	&i2c_gpio_device,
 };
 
+static const struct pinctrl_map eva_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_data24_0", "lcd0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_lclk_1", "lcd0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+				  "lcd0_sync", "lcd0"),
+};
+
 static void __init eva_clock_init(void)
 {
 	struct clk *system	= clk_get(NULL, "system_clk");
@@ -953,6 +963,8 @@ static void __init eva_init(void)
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 
+	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
+
 	r8a7740_pinmux_init();
 	r8a7740_meram_workaround();
 
@@ -962,35 +974,6 @@ static void __init eva_init(void)
 
 	/* LCDC0 */
 	gpio_request(GPIO_FN_LCDC0_SELECT,	NULL);
-	gpio_request(GPIO_FN_LCD0_D0,		NULL);
-	gpio_request(GPIO_FN_LCD0_D1,		NULL);
-	gpio_request(GPIO_FN_LCD0_D2,		NULL);
-	gpio_request(GPIO_FN_LCD0_D3,		NULL);
-	gpio_request(GPIO_FN_LCD0_D4,		NULL);
-	gpio_request(GPIO_FN_LCD0_D5,		NULL);
-	gpio_request(GPIO_FN_LCD0_D6,		NULL);
-	gpio_request(GPIO_FN_LCD0_D7,		NULL);
-	gpio_request(GPIO_FN_LCD0_D8,		NULL);
-	gpio_request(GPIO_FN_LCD0_D9,		NULL);
-	gpio_request(GPIO_FN_LCD0_D10,		NULL);
-	gpio_request(GPIO_FN_LCD0_D11,		NULL);
-	gpio_request(GPIO_FN_LCD0_D12,		NULL);
-	gpio_request(GPIO_FN_LCD0_D13,		NULL);
-	gpio_request(GPIO_FN_LCD0_D14,		NULL);
-	gpio_request(GPIO_FN_LCD0_D15,		NULL);
-	gpio_request(GPIO_FN_LCD0_D16,		NULL);
-	gpio_request(GPIO_FN_LCD0_D17,		NULL);
-	gpio_request(GPIO_FN_LCD0_D18_PORT40,	NULL);
-	gpio_request(GPIO_FN_LCD0_D19_PORT4,	NULL);
-	gpio_request(GPIO_FN_LCD0_D20_PORT3,	NULL);
-	gpio_request(GPIO_FN_LCD0_D21_PORT2,	NULL);
-	gpio_request(GPIO_FN_LCD0_D22_PORT0,	NULL);
-	gpio_request(GPIO_FN_LCD0_D23_PORT1,	NULL);
-	gpio_request(GPIO_FN_LCD0_DCK,		NULL);
-	gpio_request(GPIO_FN_LCD0_VSYN,		NULL);
-	gpio_request(GPIO_FN_LCD0_HSYN,		NULL);
-	gpio_request(GPIO_FN_LCD0_DISP,		NULL);
-	gpio_request(GPIO_FN_LCD0_LCLK_PORT165,	NULL);
 
 	gpio_request(GPIO_PORT61, NULL); /* LCDDON */
 	gpio_direction_output(GPIO_PORT61, 1);
-- 
1.7.8.6

