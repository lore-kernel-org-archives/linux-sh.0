From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 04 Jan 2013 00:40:56 +0000
Subject: [PATCH 5/9] ARM: shmobile: armadillo: Move pinctrl mappings to device tree
Message-Id: <1357260060-32164-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts  |   10 ++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c |    9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index a8e7bd9..f324405 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -20,3 +20,13 @@
 		reg = <0x40000000 0x20000000>;
 	};
 };
+
+&gpio {
+	pinctrl-0 = <&lcd0_pins>;
+	pinctrl-names = "default";
+
+	lcd0_pins: pfc_lcd0_pins {
+		renesas,pins = "lcd0_data24_0", "lcd0_lclk_0", "lcd0_sync";
+		renesas,function = "lcd0";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index c5c42c9..200559e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -29,7 +29,6 @@
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
-#include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_eth.h>
@@ -908,12 +907,6 @@ static struct platform_device *eva_devices[] __initdata = {
 	&i2c_gpio_device,
 };
 
-static const struct pinctrl_map eva_pinctrl_map[] = {
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pfc-r8a7740", "lcd0_data24_0", "lcd0"),
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pfc-r8a7740", "lcd0_lclk_0", "lcd0"),
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pfc-r8a7740", "lcd0_sync", "lcd0"),
-};
-
 static void __init eva_clock_init(void)
 {
 	struct clk *system	= clk_get(NULL, "system_clk");
@@ -961,8 +954,6 @@ static void __init eva_init(void)
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 
-	pinctrl_register_mappings(eva_pinctrl_map, ARRAY_SIZE(eva_pinctrl_map));
-
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	r8a7740_meram_workaround();
-- 
1.7.8.6

