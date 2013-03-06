From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 13:46:51 +0000
Subject: [PATCH v2 12/39] ARM: shmobile: ag5evm: Register pinctrl mappings for FSI
Message-Id: <1362577638-15493-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based FSI pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index af7b427..914136b 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -552,6 +552,14 @@ static struct platform_device *ag5evm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map ag5evm_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_mclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_sclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_out", "fsia"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.2", "pfc-sh73a0",
 				  "i2c2_0", "i2c2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
@@ -611,13 +619,6 @@ static void __init ag5evm_init(void)
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

