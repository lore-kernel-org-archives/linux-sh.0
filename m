From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:59:32 +0000
Subject: [PATCH v4 27/88] ARM: shmobile: ag5evm: Register pinctrl mappings for IrDA
Message-Id: <1363215633-4264-28-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based IrDA pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 22b9655..c754071 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -571,6 +571,9 @@ static const struct pinctrl_map ag5evm_pinctrl_map[] = {
 				  "i2c2_0", "i2c2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_0", "i2c3"),
+	/* IrDA */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_irda.0", "pfc-sh73a0",
+				  "irda_0", "irda"),
 	/* KEYSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_keysc.0", "pfc-sh73a0",
 				  "keysc_in8", "keysc"),
@@ -639,11 +642,6 @@ static void __init ag5evm_init(void)
 	gpio_request_one(144, GPIOF_IN, NULL); /* PINTA2 */
 	gpio_request_one(145, GPIOF_OUT_INIT_HIGH, NULL); /* RESET */
 
-	/* IrDA */
-	gpio_request(GPIO_FN_PORT241_IRDA_OUT, NULL);
-	gpio_request(GPIO_FN_PORT242_IRDA_IN,  NULL);
-	gpio_request(GPIO_FN_PORT243_IRDA_FIRSEL, NULL);
-
 	/* LCD panel */
 	gpio_request_one(217, GPIOF_OUT_INIT_LOW, NULL); /* RESET */
 	mdelay(1);
-- 
1.8.1.5

