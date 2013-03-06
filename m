From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 13:47:00 +0000
Subject: [PATCH v2 21/39] ARM: shmobile: kzm9g: Register pinctrl mappings for FSI
Message-Id: <1362577638-15493-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based FSI pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index d54cc35..68f67c2 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -601,6 +601,14 @@ static struct platform_device *kzm_devices[] __initdata = {
 };
 
 static const struct pinctrl_map kzm_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_mclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_sclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
+				  "fsia_data_out", "fsia"),
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_1", "i2c3"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
@@ -724,13 +732,6 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SDHICLK2,		NULL);
 	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
-	/* enable FSI2 port A (ak4648) */
-	gpio_request(GPIO_FN_FSIACK,	NULL);
-	gpio_request(GPIO_FN_FSIAILR,	NULL);
-	gpio_request(GPIO_FN_FSIAIBT,	NULL);
-	gpio_request(GPIO_FN_FSIAISLD,	NULL);
-	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
-
 	/* enable USB */
 	gpio_request(GPIO_FN_VBUS_0,	NULL);
 
-- 
1.8.1.5

