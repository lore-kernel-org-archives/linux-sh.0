From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 09 Jan 2013 01:03:11 +0000
Subject: [PATCH v2 4/8] ARM: shmobile: armadillo: Populate platform devices from device tree
Message-Id: <1357693395-1653-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/board-armadillo800eva.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index b6e50cd..1deb417 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/irq.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
@@ -908,11 +909,11 @@ static struct platform_device *eva_devices[] __initdata = {
 };
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
 				  "lcd0_data24_0", "lcd0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
 				  "lcd0_lclk_1", "lcd0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "e6050000.pfc",
 				  "lcd0_sync", "lcd0"),
 };
 
@@ -965,7 +966,8 @@ static void __init eva_init(void)
 
 	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
 
-	r8a7740_pinmux_init();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+
 	r8a7740_meram_workaround();
 
 	/* SCIFA1 */
-- 
1.7.8.6

