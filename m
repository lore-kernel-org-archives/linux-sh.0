From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 13:46:54 +0000
Subject: [PATCH v2 15/39] ARM: shmobile: armadillo800eva: Register pinctrl mappings for SDHI and MMCIF
Message-Id: <1362577638-15493-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 56 +++++++++++---------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 48dfda8..29203a6 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -657,6 +657,17 @@ static struct platform_device sdhi1_device = {
 	.resource	= sdhi1_resources,
 };
 
+static const struct pinctrl_map eva_sdhi1_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a7740",
+				  "sdhi1_data4", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a7740",
+				  "sdhi1_ctrl", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a7740",
+				  "sdhi1_cd", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a7740",
+				  "sdhi1_wp", "sdhi1"),
+};
+
 /* MMCIF */
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
@@ -916,12 +927,22 @@ static struct platform_device *eva_devices[] __initdata = {
 };
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a7740",
+				  "mmc0_data8_1", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a7740",
+				  "mmc0_ctrl_1", "mmc0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
 				  "lcd0_data24_0", "lcd0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
 				  "lcd0_lclk_1", "lcd0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
 				  "lcd0_sync", "lcd0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7740",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7740",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7740",
+				  "sdhi0_wp", "sdhi0"),
 };
 
 static void __init eva_clock_init(void)
@@ -1035,37 +1056,12 @@ static void __init eva_init(void)
 	}
 
 	/* SDHI0 */
-	gpio_request(GPIO_FN_SDHI0_CMD, NULL);
-	gpio_request(GPIO_FN_SDHI0_CLK, NULL);
-	gpio_request(GPIO_FN_SDHI0_D0, NULL);
-	gpio_request(GPIO_FN_SDHI0_D1, NULL);
-	gpio_request(GPIO_FN_SDHI0_D2, NULL);
-	gpio_request(GPIO_FN_SDHI0_D3, NULL);
-	gpio_request(GPIO_FN_SDHI0_WP, NULL);
-
 	gpio_request_one(17, GPIOF_OUT_INIT_LOW, NULL);  /* SDHI0_18/33_B */
 	gpio_request_one(74, GPIOF_OUT_INIT_HIGH, NULL); /* SDHI0_PON */
 	gpio_request_one(75, GPIOF_OUT_INIT_HIGH, NULL); /* SDSLOT1_PON */
 
 	/* we can use GPIO_FN_IRQ31_PORT167 here for SDHI0 CD irq */
 
-	/*
-	 * MMCIF
-	 *
-	 * Here doesn't care SW1.4 status,
-	 * since CON2 is not mounted.
-	 */
-	gpio_request(GPIO_FN_MMC1_CLK_PORT103,	NULL);
-	gpio_request(GPIO_FN_MMC1_CMD_PORT104,	NULL);
-	gpio_request(GPIO_FN_MMC1_D0_PORT149,	NULL);
-	gpio_request(GPIO_FN_MMC1_D1_PORT148,	NULL);
-	gpio_request(GPIO_FN_MMC1_D2_PORT147,	NULL);
-	gpio_request(GPIO_FN_MMC1_D3_PORT146,	NULL);
-	gpio_request(GPIO_FN_MMC1_D4_PORT145,	NULL);
-	gpio_request(GPIO_FN_MMC1_D5_PORT144,	NULL);
-	gpio_request(GPIO_FN_MMC1_D6_PORT143,	NULL);
-	gpio_request(GPIO_FN_MMC1_D7_PORT142,	NULL);
-
 	/* CEU0 */
 	gpio_request(GPIO_FN_VIO0_D7,		NULL);
 	gpio_request(GPIO_FN_VIO0_D6,		NULL);
@@ -1123,14 +1119,8 @@ static void __init eva_init(void)
 		/* CON14 enable */
 	} else {
 		/* CON8 (SDHI1) enable */
-		gpio_request(GPIO_FN_SDHI1_CLK,	NULL);
-		gpio_request(GPIO_FN_SDHI1_CMD,	NULL);
-		gpio_request(GPIO_FN_SDHI1_D0,	NULL);
-		gpio_request(GPIO_FN_SDHI1_D1,	NULL);
-		gpio_request(GPIO_FN_SDHI1_D2,	NULL);
-		gpio_request(GPIO_FN_SDHI1_D3,	NULL);
-		gpio_request(GPIO_FN_SDHI1_CD,	NULL);
-		gpio_request(GPIO_FN_SDHI1_WP,	NULL);
+		pinctrl_register_mappings(eva_sdhi1_pinctrl_map,
+					  ARRAY_SIZE(eva_sdhi1_pinctrl_map));
 
 		/* SDSLOT2_PON */
 		gpio_request_one(16, GPIOF_OUT_INIT_HIGH, NULL);
-- 
1.8.1.5

