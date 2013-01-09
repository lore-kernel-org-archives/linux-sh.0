From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 09 Jan 2013 00:52:43 +0000
Subject: [PATCH v2 23/29] ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
Message-Id: <1357692769-1432-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based LCD pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   37 +++++++++------------------------
 1 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index eadf309..b34a59b 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -599,6 +600,13 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&fsi_ak4648_device,
 };
 
+static const struct pinctrl_map kzm_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
+				  "lcd_data24", "lcd"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
+				  "lcd_sync", "lcd"),
+};
+
 /*
  * FIXME
  *
@@ -660,6 +668,8 @@ static void __init kzm_init(void)
 				     ARRAY_SIZE(fixed2v8_power_consumers), 2800000);
 	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
+
 	sh73a0_pinmux_init();
 
 	/* enable SCIFA4 */
@@ -676,33 +686,6 @@ static void __init kzm_init(void)
 	gpio_direction_input(GPIO_PORT224);
 
 	/* LCDC */
-	gpio_request(GPIO_FN_LCDD23,	NULL);
-	gpio_request(GPIO_FN_LCDD22,	NULL);
-	gpio_request(GPIO_FN_LCDD21,	NULL);
-	gpio_request(GPIO_FN_LCDD20,	NULL);
-	gpio_request(GPIO_FN_LCDD19,	NULL);
-	gpio_request(GPIO_FN_LCDD18,	NULL);
-	gpio_request(GPIO_FN_LCDD17,	NULL);
-	gpio_request(GPIO_FN_LCDD16,	NULL);
-	gpio_request(GPIO_FN_LCDD15,	NULL);
-	gpio_request(GPIO_FN_LCDD14,	NULL);
-	gpio_request(GPIO_FN_LCDD13,	NULL);
-	gpio_request(GPIO_FN_LCDD12,	NULL);
-	gpio_request(GPIO_FN_LCDD11,	NULL);
-	gpio_request(GPIO_FN_LCDD10,	NULL);
-	gpio_request(GPIO_FN_LCDD9,	NULL);
-	gpio_request(GPIO_FN_LCDD8,	NULL);
-	gpio_request(GPIO_FN_LCDD7,	NULL);
-	gpio_request(GPIO_FN_LCDD6,	NULL);
-	gpio_request(GPIO_FN_LCDD5,	NULL);
-	gpio_request(GPIO_FN_LCDD4,	NULL);
-	gpio_request(GPIO_FN_LCDD3,	NULL);
-	gpio_request(GPIO_FN_LCDD2,	NULL);
-	gpio_request(GPIO_FN_LCDD1,	NULL);
-	gpio_request(GPIO_FN_LCDD0,	NULL);
-	gpio_request(GPIO_FN_LCDDISP,	NULL);
-	gpio_request(GPIO_FN_LCDDCK,	NULL);
-
 	gpio_request(GPIO_PORT222,	NULL); /* LCDCDON */
 	gpio_request(GPIO_PORT226,	NULL); /* SC */
 	gpio_direction_output(GPIO_PORT222, 1);
-- 
1.7.8.6

