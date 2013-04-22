From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:52 +0000
Subject: [PATCH 11/37] ARM: shmobile: armadillo800eva: Register pinctrl mapping for CEU0
Message-Id: <1366671618-8796-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based CEU0 pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index a23988b..1d57cc4 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1036,6 +1036,15 @@ static struct platform_device *eva_devices[] __initdata = {
 };
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
+	/* CEU0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
+				  "ceu0_data_0_7", "ceu0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
+				  "ceu0_clk_0", "ceu0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
+				  "ceu0_sync", "ceu0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-r8a7740",
+				  "ceu0_field", "ceu0"),
 	/* GETHER */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
 				  "gether_mii", "gether"),
@@ -1154,21 +1163,6 @@ static void __init eva_init(void)
 		usb = &usbhsf_device;
 	}
 
-	/* CEU0 */
-	gpio_request(GPIO_FN_VIO0_D7,		NULL);
-	gpio_request(GPIO_FN_VIO0_D6,		NULL);
-	gpio_request(GPIO_FN_VIO0_D5,		NULL);
-	gpio_request(GPIO_FN_VIO0_D4,		NULL);
-	gpio_request(GPIO_FN_VIO0_D3,		NULL);
-	gpio_request(GPIO_FN_VIO0_D2,		NULL);
-	gpio_request(GPIO_FN_VIO0_D1,		NULL);
-	gpio_request(GPIO_FN_VIO0_D0,		NULL);
-	gpio_request(GPIO_FN_VIO0_CLK,		NULL);
-	gpio_request(GPIO_FN_VIO0_HD,		NULL);
-	gpio_request(GPIO_FN_VIO0_VD,		NULL);
-	gpio_request(GPIO_FN_VIO0_FIELD,	NULL);
-	gpio_request(GPIO_FN_VIO_CKO,		NULL);
-
 	/* CON1/CON15 Camera */
 	gpio_request_one(173, GPIOF_OUT_INIT_LOW, NULL);  /* STANDBY */
 	gpio_request_one(172, GPIOF_OUT_INIT_HIGH, NULL); /* RST */
-- 
1.8.1.5

