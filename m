From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 10 Jan 2013 20:51:41 +0000
Subject: [PATCH 08/16] ARM: shmobile: kzm9g: Register pinctrl mappings for SCIF
Message-Id: <1357851109-22103-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based SCIF pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index b34a59b..914c7e6 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -601,6 +601,10 @@ static struct platform_device *kzm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+				  "scifa4_data", "scifa4"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
+				  "scifa4_ctrl", "scifa4"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
 				  "lcd_data24", "lcd"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
@@ -672,12 +676,6 @@ static void __init kzm_init(void)
 
 	sh73a0_pinmux_init();
 
-	/* enable SCIFA4 */
-	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
-	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
-
 	/* CS4 for SMSC/USB */
 	gpio_request(GPIO_FN_CS4_, NULL); /* CS4 */
 
-- 
1.7.8.6

