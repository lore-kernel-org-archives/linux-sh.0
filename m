From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 10 Jan 2013 20:51:38 +0000
Subject: [PATCH 05/16] ARM: shmobile: ag5evm: Register pinctrl mappings for I2C
Message-Id: <1357851109-22103-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based I2C pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 4a2b418..ad14e24 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -553,6 +553,10 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map ag5evm_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.2", "pfc-sh73a0",
+				  "i2c2_0", "i2c2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
+				  "i2c3_0", "i2c3"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
 				  "scifa2_data_0", "scifa2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-sh73a0",
@@ -591,12 +595,6 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_KEYOUT8, NULL);
 	gpio_request(GPIO_FN_PORT149_KEYOUT9, NULL);
 
-	/* enable I2C channel 2 and 3 */
-	gpio_request(GPIO_FN_PORT236_I2C_SDA2, NULL);
-	gpio_request(GPIO_FN_PORT237_I2C_SCL2, NULL);
-	gpio_request(GPIO_FN_PORT248_I2C_SCL3, NULL);
-	gpio_request(GPIO_FN_PORT249_I2C_SDA3, NULL);
-
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0, NULL);
 	gpio_request(GPIO_FN_MMCCMD0_PU, NULL);
-- 
1.7.8.6

