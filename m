From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 09 Jan 2013 01:03:14 +0000
Subject: [PATCH v2 7/8] ARM: shmobile: kzm9g: Populate platform devices from device tree
Message-Id: <1357693395-1653-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Call of_platform_populate() at machine initialization time to populate
platform devices. Remove the explicit pinmux initialization as the PFC
device will be instantiated from the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index b34a59b..94698b1 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -29,6 +29,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
+#include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
@@ -601,9 +602,9 @@ static struct platform_device *kzm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
 				  "lcd_data24", "lcd"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
 				  "lcd_sync", "lcd"),
 };
 
@@ -670,7 +671,7 @@ static void __init kzm_init(void)
 
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
 
-	sh73a0_pinmux_init();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	/* enable SCIFA4 */
 	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
-- 
1.7.8.6

