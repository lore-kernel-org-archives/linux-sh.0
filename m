From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:15 +0000
Subject: [PATCH 12/35] ARM: shmobile: mackerel: Register pinctrl mapping for CEU
Message-Id: <1366671758-8954-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based CEU pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index d252c6e..ed442d2 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1306,6 +1306,15 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* ADXL34X */
 	PIN_MAP_MUX_GROUP_DEFAULT("1-0053", "pfc-sh7372",
 				  "intc_irq21", "intc"),
+	/* CEU */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_data_0_7", "ceu"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_clk_0", "ceu"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_sync", "ceu"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_field", "ceu"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1491,21 +1500,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
 	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
 
-	/* CEU */
-	gpio_request(GPIO_FN_VIO_CLK, NULL);
-	gpio_request(GPIO_FN_VIO_VD, NULL);
-	gpio_request(GPIO_FN_VIO_HD, NULL);
-	gpio_request(GPIO_FN_VIO_FIELD, NULL);
-	gpio_request(GPIO_FN_VIO_CKO, NULL);
-	gpio_request(GPIO_FN_VIO_D7, NULL);
-	gpio_request(GPIO_FN_VIO_D6, NULL);
-	gpio_request(GPIO_FN_VIO_D5, NULL);
-	gpio_request(GPIO_FN_VIO_D4, NULL);
-	gpio_request(GPIO_FN_VIO_D3, NULL);
-	gpio_request(GPIO_FN_VIO_D2, NULL);
-	gpio_request(GPIO_FN_VIO_D1, NULL);
-	gpio_request(GPIO_FN_VIO_D0, NULL);
-
 	/* HDMI */
 	gpio_request(GPIO_FN_HDMI_HPD, NULL);
 	gpio_request(GPIO_FN_HDMI_CEC, NULL);
-- 
1.8.1.5

