From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 04 Jan 2013 00:40:59 +0000
Subject: [PATCH 8/9] ARM: shmobile: kzm9g: Move pinctrl mappings to device tree
Message-Id: <1357260060-32164-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the pinctrl mappings in board code by device tree mappings.
Reference the mapping as the default pin controller state to apply it at
boot time.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts   |   10 ++++++++++
 arch/arm/mach-shmobile/board-kzm9g.c |    8 --------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 7b37901..e24996c 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -20,3 +20,13 @@
 		reg = <0x41000000 0x1e800000>;
 	};
 };
+
+&gpio {
+	pinctrl-0 = <&lcd_pins>;
+	pinctrl-names = "default";
+
+	lcd_pins: pfc_lcd_pins {
+		renesas,pins = "lcd_data24", "lcd_sync";
+		renesas,function = "lcd";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 7a81505..ec6c08e 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -30,7 +30,6 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/of_platform.h>
-#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -601,11 +600,6 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&fsi_ak4648_device,
 };
 
-static const struct pinctrl_map kzm_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pfc-sh73a0", "lcd_data24", "lcd"),
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pfc-sh73a0", "lcd_sync", "lcd"),
-};
-
 /*
  * FIXME
  *
@@ -667,8 +661,6 @@ static void __init kzm_init(void)
 				     ARRAY_SIZE(fixed2v8_power_consumers), 2800000);
 	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
-	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	/* enable SCIFA4 */
-- 
1.7.8.6

