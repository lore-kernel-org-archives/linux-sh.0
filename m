From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:45 +0000
Subject: [PATCH v3 25/64] ARM: shmobile: kzm9g: Register pinctrl mappings for LCD
Message-Id: <1362740544-19164-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based LCD pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 37 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 65a5e0b..7ca6002 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -30,6 +30,7 @@
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
@@ -675,33 +685,6 @@ static void __init kzm_init(void)
 	gpio_request_one(224, GPIOF_IN, NULL); /* IRQ3 */
 
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
 	gpio_request_one(222, GPIOF_OUT_INIT_HIGH, NULL); /* LCDCDON */
 	gpio_request_one(226, GPIOF_OUT_INIT_HIGH, NULL); /* SC */
 
-- 
1.8.1.5

