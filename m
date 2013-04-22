From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:18 +0000
Subject: [PATCH 15/35] ARM: shmobile: mackerel: Register pinctrl mapping for HDMI
Message-Id: <1366671758-8954-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based HDMI pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b28561d..c6e796d 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1332,6 +1332,9 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* FSIB (HDMI) */
 	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.1", "pfc-sh7372",
 				  "fsib_mclk_in", "fsib"),
+	/* HDMI */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-sh7372",
+				  "hdmi", "hdmi"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1488,10 +1491,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
 	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
 
-	/* HDMI */
-	gpio_request(GPIO_FN_HDMI_HPD, NULL);
-	gpio_request(GPIO_FN_HDMI_CEC, NULL);
-
 	/* Reset HDMI, must be held at least one EXTALR (32768Hz) period */
 	srcr4 = __raw_readl(SRCR4);
 	__raw_writel(srcr4 | (1 << 13), SRCR4);
-- 
1.8.1.5

