From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:28 +0000
Subject: [PATCH 25/35] ARM: shmobile: ap4evb: Register pinctrl mapping for HDMI
Message-Id: <1366671758-8954-26-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based HDMI pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 2f03685..2dfa235 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1099,6 +1099,9 @@ static const struct pinctrl_map ap4evb_pinctrl_map[] = {
 	/* FSIB (HDMI) */
 	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.1", "pfc-sh7372",
 				  "fsib_mclk_in", "fsib"),
+	/* HDMI */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-sh7372",
+				  "hdmi", "hdmi"),
 	/* MMCIF */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
 				  "mmc0_data8_0", "mmc0"),
@@ -1305,10 +1308,6 @@ static void __init ap4evb_init(void)
 
 	sh7372_add_standard_devices();
 
-	/* HDMI */
-	gpio_request(GPIO_FN_HDMI_HPD, NULL);
-	gpio_request(GPIO_FN_HDMI_CEC, NULL);
-
 	/* Reset HDMI, must be held at least one EXTALR (32768Hz) period */
 #define SRCR4 IOMEM(0xe61580bc)
 	srcr4 = __raw_readl(SRCR4);
-- 
1.8.1.5

