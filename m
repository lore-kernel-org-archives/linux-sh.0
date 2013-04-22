From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:17 +0000
Subject: [PATCH 14/35] ARM: shmobile: mackerel: Register pinctrl mapping for FSI
Message-Id: <1366671758-8954-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based FSI pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index e162abd..b28561d 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1322,6 +1322,16 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 				  "flctl_ce0", "flctl"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_flctl.0", "pfc-sh7372",
 				  "flctl_ctrl", "flctl"),
+	/* FSIA (AK4643) */
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.0", "pfc-sh7372",
+				  "fsia_sclk_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.0", "pfc-sh7372",
+				  "fsia_data_in", "fsia"),
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.0", "pfc-sh7372",
+				  "fsia_data_out", "fsia"),
+	/* FSIB (HDMI) */
+	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.1", "pfc-sh7372",
+				  "fsib_mclk_in", "fsib"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1440,11 +1450,7 @@ static void __init mackerel_init(void)
 	gpio_request_pulldown(GPIO_PORT167CR); /* VBUS0_1 pull down */
 	gpio_request(GPIO_FN_IDIN_1_113, NULL);
 
-	/* enable FSI2 port A (ak4643) */
-	gpio_request(GPIO_FN_FSIAIBT,	NULL);
-	gpio_request(GPIO_FN_FSIAILR,	NULL);
-	gpio_request(GPIO_FN_FSIAISLD,	NULL);
-	gpio_request(GPIO_FN_FSIAOSLD,	NULL);
+	/* FSI2 port A (ak4643) */
 	gpio_request_one(161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
 
 	gpio_request(9,  NULL);
@@ -1454,8 +1460,7 @@ static void __init mackerel_init(void)
 
 	intc_set_priority(IRQ_FSI, 3); /* irq priority FSI(3) > SMSC911X(2) */
 
-	/* setup FSI2 port B (HDMI) */
-	gpio_request(GPIO_FN_FSIBCK, NULL);
+	/* FSI2 port B (HDMI) */
 	__raw_writew(__raw_readw(USCCR1) & ~(1 << 6), USCCR1); /* use SPDIF */
 
 	/* set SPU2 clock to 119.6 MHz */
-- 
1.8.1.5

