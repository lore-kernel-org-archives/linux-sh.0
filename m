From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:16 +0000
Subject: [PATCH 13/35] ARM: shmobile: mackerel: Register pinctrl mapping for FLCTL
Message-Id: <1366671758-8954-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based FLCTL pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index ed442d2..e162abd 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1315,6 +1315,13 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 				  "ceu_sync", "ceu"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
 				  "ceu_field", "ceu"),
+	/* FLCTL */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_flctl.0", "pfc-sh7372",
+				  "flctl_data", "flctl"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_flctl.0", "pfc-sh7372",
+				  "flctl_ce0", "flctl"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_flctl.0", "pfc-sh7372",
+				  "flctl_ctrl", "flctl"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1472,30 +1479,6 @@ static void __init mackerel_init(void)
 	/* SDHI0 PORT172 card-detect IRQ26 */
 	gpio_request(GPIO_FN_IRQ26_172, NULL);
 
-	/* FLCTL */
-	gpio_request(GPIO_FN_D0_NAF0, NULL);
-	gpio_request(GPIO_FN_D1_NAF1, NULL);
-	gpio_request(GPIO_FN_D2_NAF2, NULL);
-	gpio_request(GPIO_FN_D3_NAF3, NULL);
-	gpio_request(GPIO_FN_D4_NAF4, NULL);
-	gpio_request(GPIO_FN_D5_NAF5, NULL);
-	gpio_request(GPIO_FN_D6_NAF6, NULL);
-	gpio_request(GPIO_FN_D7_NAF7, NULL);
-	gpio_request(GPIO_FN_D8_NAF8, NULL);
-	gpio_request(GPIO_FN_D9_NAF9, NULL);
-	gpio_request(GPIO_FN_D10_NAF10, NULL);
-	gpio_request(GPIO_FN_D11_NAF11, NULL);
-	gpio_request(GPIO_FN_D12_NAF12, NULL);
-	gpio_request(GPIO_FN_D13_NAF13, NULL);
-	gpio_request(GPIO_FN_D14_NAF14, NULL);
-	gpio_request(GPIO_FN_D15_NAF15, NULL);
-	gpio_request(GPIO_FN_FCE0, NULL);
-	gpio_request(GPIO_FN_WE0_FWE, NULL);
-	gpio_request(GPIO_FN_FRB, NULL);
-	gpio_request(GPIO_FN_A4_FOE, NULL);
-	gpio_request(GPIO_FN_A5_FCDE, NULL);
-	gpio_request(GPIO_FN_RD_FSC, NULL);
-
 	/* enable GPS module (GT-720F) */
 	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
 	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
-- 
1.8.1.5

