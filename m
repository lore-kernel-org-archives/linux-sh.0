From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:59:45 +0000
Subject: [PATCH v4 40/88] ARM: shmobile: kzm9g: Register pinctrl mappings for SDHI and MMCIF
Message-Id: <1363215633-4264-41-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c | 54 +++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index a628d1b..335bdbb 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -31,6 +31,7 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf-generic.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -600,6 +601,10 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&fsi_ak4648_device,
 };
 
+static unsigned long pin_pullup_conf[] = {
+	PIN_CONF_PACKED(PIN_CONFIG_BIAS_PULL_UP, 0),
+};
+
 static const struct pinctrl_map kzm_pinctrl_map[] = {
 	/* FSIA (AK4648) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_fsi2.0", "pfc-sh73a0",
@@ -618,11 +623,34 @@ static const struct pinctrl_map kzm_pinctrl_map[] = {
 				  "lcd_data24", "lcd"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-sh73a0",
 				  "lcd_sync", "lcd"),
+	/* MMCIF */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				  "mmc0_data8_0", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				  "mmc0_ctrl_0", "mmc0"),
+	PIN_MAP_CONFIGS_PIN_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				    "PORT279", pin_pullup_conf),
+	PIN_MAP_CONFIGS_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh73a0",
+				      "mmc0_data8_0", pin_pullup_conf),
 	/* SCIFA4 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
 				  "scifa4_data", "scifa4"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-sh73a0",
 				  "scifa4_ctrl", "scifa4"),
+	/* SDHI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_cd", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh73a0",
+				  "sdhi0_wp", "sdhi0"),
+	/* SDHI2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh73a0",
+				  "sdhi2_data4", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh73a0",
+				  "sdhi2_ctrl", "sdhi2"),
 };
 
 /*
@@ -703,37 +731,11 @@ static void __init kzm_init(void)
 	/* Touchscreen */
 	gpio_request_one(223, GPIOF_IN, NULL); /* IRQ8 */
 
-	/* enable MMCIF */
-	gpio_request(GPIO_FN_MMCCLK0,		NULL);
-	gpio_request(GPIO_FN_MMCCMD0_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_0_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_1_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_2_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_3_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_4_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_5_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
-	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);
-
 	/* enable SD */
-	gpio_request(GPIO_FN_SDHIWP0,		NULL);
-	gpio_request(GPIO_FN_SDHICD0,		NULL);
-	gpio_request(GPIO_FN_SDHICMD0,		NULL);
-	gpio_request(GPIO_FN_SDHICLK0,		NULL);
-	gpio_request(GPIO_FN_SDHID0_3,		NULL);
-	gpio_request(GPIO_FN_SDHID0_2,		NULL);
-	gpio_request(GPIO_FN_SDHID0_1,		NULL);
-	gpio_request(GPIO_FN_SDHID0_0,		NULL);
 	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
 	gpio_request_one(15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	/* enable Micro SD */
-	gpio_request(GPIO_FN_SDHID2_0,		NULL);
-	gpio_request(GPIO_FN_SDHID2_1,		NULL);
-	gpio_request(GPIO_FN_SDHID2_2,		NULL);
-	gpio_request(GPIO_FN_SDHID2_3,		NULL);
-	gpio_request(GPIO_FN_SDHICMD2,		NULL);
-	gpio_request(GPIO_FN_SDHICLK2,		NULL);
 	gpio_request_one(14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
 
 	/* enable USB */
-- 
1.8.1.5

