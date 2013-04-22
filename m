From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:54 +0000
Subject: [PATCH 13/37] ARM: shmobile: armadillo800eva: Register pinctrl mapping for HDMI
Message-Id: <1366671618-8796-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based HDMI pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index d8ce94a..a74e750 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1062,6 +1062,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 				  "gether_mii", "gether"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
 				  "gether_int", "gether"),
+	/* HDMI */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-r8a7740",
+				  "hdmi", "hdmi"),
 	/* LCD0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
 				  "lcd0_data24_0", "lcd0"),
@@ -1187,10 +1190,6 @@ static void __init eva_init(void)
 	gpio_direction_none(GPIO_PORT7CR); /* FSIAOBT needs no direction */
 	gpio_direction_none(GPIO_PORT8CR); /* FSIAOLR needs no direction */
 
-	/* HDMI */
-	gpio_request(GPIO_FN_HDMI_HPD,		NULL);
-	gpio_request(GPIO_FN_HDMI_CEC,		NULL);
-
 	/*
 	 * CAUTION
 	 *
-- 
1.8.1.5

