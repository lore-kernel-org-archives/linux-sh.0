From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 14:55:55 +0000
Subject: [PATCH 2/2] ARM: shmobile: fix kzm9g-reference compile breakage
Message-Id: <Pine.LNX.4.64.1302121535330.7059@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Recently many pin function names have been removed, as their users have
been switched to use pinctrl. However, kzm9g-reference has been left
unchanged, which broke its compilation. Fix this by switching over to
pinctrl.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   12 ++++++++++++
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   18 +++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 7fad4b9..fe0ee98 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -71,6 +71,18 @@
 	};
 };
 
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
+
+&gpio {
+	i2c3_pins: pfc_i2c3_pins {
+		renesas,pins = "i2c3_1";
+		renesas,function = "i2c3";
+	};
+};
+
 &mmcif {
 	bus-width = <8>;
 	vmmc-supply = <&reg_1p8v>;
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index d86f093..989bdf4 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -26,21 +26,25 @@
 #include <linux/irq.h>
 #include <linux/input.h>
 #include <linux/of_platform.h>
+#include <linux/pinctrl/machine.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+static const struct pinctrl_map kzm_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
+				  "scifa4_data", "scifa4"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "e6050000.pfc",
+				  "scifa4_ctrl", "scifa4"),
+};
+
 static void __init kzm_init(void)
 {
 	sh73a0_add_standard_devices_dt();
 
-	/* enable SCIFA4 */
-	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
-	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
-	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
+	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
 
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0,		NULL);
@@ -75,10 +79,6 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHICLK2,		NULL);
 	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
-	/* I2C 3 */
-	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
-	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
-
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.7.2.5

