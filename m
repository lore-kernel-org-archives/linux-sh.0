From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:59:29 +0000
Subject: [PATCH v4 24/88] ARM: shmobile: ag5evm: Register pinctrl mappings for FSI
Message-Id: <1363215633-4264-25-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based FSI pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index e19dade..178bfd1 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -552,6 +552,15 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map ag5evm_pinctrl_map[] = {
+	/* FSIA */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_mclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_sclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_out", "fsia"),
 	/* I2C2 & I2C3 */
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.2", "pfc-sh73a0",
 				  "i2c2_0", "i2c2"),
@@ -613,13 +622,6 @@ static void __init ag5evm_init(void)
 	gpio_request_one(144, GPIOF_IN, NULL); /* PINTA2 */
 	gpio_request_one(145, GPIOF_OUT_INIT_HIGH, NULL); /* RESET */
 
-	/* FSI A */
-	gpio_request(GPIO_FN_FSIACK, NULL);
-	gpio_request(GPIO_FN_FSIAILR, NULL);
-	gpio_request(GPIO_FN_FSIAIBT, NULL);
-	gpio_request(GPIO_FN_FSIAISLD, NULL);
-	gpio_request(GPIO_FN_FSIAOSLD, NULL);
-
 	/* IrDA */
 	gpio_request(GPIO_FN_PORT241_IRDA_OUT, NULL);
 	gpio_request(GPIO_FN_PORT242_IRDA_IN,  NULL);
-- 
1.8.1.5

