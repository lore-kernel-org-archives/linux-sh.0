From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 10 Jan 2013 20:51:37 +0000
Subject: [PATCH 04/16] ARM: shmobile: ag5evm: Register pinctrl mappings for SCIF
Message-Id: <1357851109-22103-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based SCIF pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 032d108..4a2b418 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -551,6 +552,13 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 	&sdhi1_device,
 };
 
+static const struct pinctrl_map ag5evm_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
+				  "scifa2_data_0", "scifa2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
+				  "scifa2_ctrl_0", "scifa2"),
+};
+
 static void __init ag5evm_init(void)
 {
 	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
@@ -559,14 +567,10 @@ static void __init ag5evm_init(void)
 				     ARRAY_SIZE(fixed2v8_power_consumers), 3300000);
 	regulator_register_fixed(3, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(ag5evm_pinctrl_map,
+				  ARRAY_SIZE(ag5evm_pinctrl_map));
 	sh73a0_pinmux_init();
 
-	/* enable SCIFA2 */
-	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
-	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
-	gpio_request(GPIO_FN_SCIFA2_RTS1_, NULL);
-	gpio_request(GPIO_FN_SCIFA2_CTS1_, NULL);
-
 	/* enable KEYSC */
 	gpio_request(GPIO_FN_KEYIN0_PU, NULL);
 	gpio_request(GPIO_FN_KEYIN1_PU, NULL);
-- 
1.7.8.6

