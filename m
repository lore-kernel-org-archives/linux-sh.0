From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:19 +0000
Subject: [PATCH 16/35] ARM: shmobile: mackerel: Register pinctrl mapping for LCD
Message-Id: <1366671758-8954-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based LCD pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index c6e796d..7a4048a 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1335,6 +1335,11 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* HDMI */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-sh7372",
 				  "hdmi", "hdmi"),
+	/* LCDC */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh7372",
+				  "lcd_data24", "lcd"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh7372",
+				  "lcd_sync", "lcd"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1411,34 +1416,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_CS5A,	NULL);
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
 
-	/* LCDC */
-	gpio_request(GPIO_FN_LCDD23,   NULL);
-	gpio_request(GPIO_FN_LCDD22,   NULL);
-	gpio_request(GPIO_FN_LCDD21,   NULL);
-	gpio_request(GPIO_FN_LCDD20,   NULL);
-	gpio_request(GPIO_FN_LCDD19,   NULL);
-	gpio_request(GPIO_FN_LCDD18,   NULL);
-	gpio_request(GPIO_FN_LCDD17,   NULL);
-	gpio_request(GPIO_FN_LCDD16,   NULL);
-	gpio_request(GPIO_FN_LCDD15,   NULL);
-	gpio_request(GPIO_FN_LCDD14,   NULL);
-	gpio_request(GPIO_FN_LCDD13,   NULL);
-	gpio_request(GPIO_FN_LCDD12,   NULL);
-	gpio_request(GPIO_FN_LCDD11,   NULL);
-	gpio_request(GPIO_FN_LCDD10,   NULL);
-	gpio_request(GPIO_FN_LCDD9,    NULL);
-	gpio_request(GPIO_FN_LCDD8,    NULL);
-	gpio_request(GPIO_FN_LCDD7,    NULL);
-	gpio_request(GPIO_FN_LCDD6,    NULL);
-	gpio_request(GPIO_FN_LCDD5,    NULL);
-	gpio_request(GPIO_FN_LCDD4,    NULL);
-	gpio_request(GPIO_FN_LCDD3,    NULL);
-	gpio_request(GPIO_FN_LCDD2,    NULL);
-	gpio_request(GPIO_FN_LCDD1,    NULL);
-	gpio_request(GPIO_FN_LCDD0,    NULL);
-	gpio_request(GPIO_FN_LCDDISP,  NULL);
-	gpio_request(GPIO_FN_LCDDCK,   NULL);
-
 	/* backlight, off by default */
 	gpio_request_one(31, GPIOF_OUT_INIT_LOW, NULL);
 
-- 
1.8.1.5

