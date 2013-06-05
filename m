From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 05 Jun 2013 08:26:17 +0000
Subject: [PATCH 086/130] ARM: shmobile: armadillo800eva: Convert SCIFA1 to pinctrl
Message-Id: <1370420821-28420-87-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

We use the new pinctrl framework now.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index aafa99b..44a6215 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1087,6 +1087,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 				  "mmc0_data8_1", "mmc0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a7740",
 				  "mmc0_ctrl_1", "mmc0"),
+	/* SCIFA1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.1", "pfc-r8a7740",
+				  "scifa1_data", "scifa1"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7740",
 				  "sdhi0_data4", "sdhi0"),
@@ -1154,10 +1157,6 @@ static void __init eva_init(void)
 	r8a7740_pinmux_init();
 	r8a7740_meram_workaround();
 
-	/* SCIFA1 */
-	gpio_request(GPIO_FN_SCIFA1_RXD, NULL);
-	gpio_request(GPIO_FN_SCIFA1_TXD, NULL);
-
 	/* LCDC0 */
 	gpio_request_one(61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 	gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
-- 
1.8.2.1

