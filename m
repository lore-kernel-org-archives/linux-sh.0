From: Bastian Hecht <hechtb@gmail.com>
Date: Wed, 17 Apr 2013 10:34:02 +0000
Subject: [PATCH v2 2/6] ARM: shmobile: Armadillo800EVA: Convert SCIFA1 to pinctrl
Message-Id: <1366194847-9879-2-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We use the new pinctrl framework now.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
v2: same

 arch/arm/mach-shmobile/board-armadillo800eva.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 81db74a..bf4c3d2 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1048,6 +1048,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 				  "mmc0_data8_1", "mmc0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a7740",
 				  "mmc0_ctrl_1", "mmc0"),
+	/* SCIFA1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.1", "pfc-r8a7740",
+				  "scifa1_data", "scifa1"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7740",
 				  "sdhi0_data4", "sdhi0"),
@@ -1109,10 +1112,6 @@ static void __init eva_init(void)
 	r8a7740_pinmux_init();
 	r8a7740_meram_workaround();
 
-	/* SCIFA1 */
-	gpio_request(GPIO_FN_SCIFA1_RXD, NULL);
-	gpio_request(GPIO_FN_SCIFA1_TXD, NULL);
-
 	/* LCDC0 */
 	gpio_request(GPIO_FN_LCDC0_SELECT,	NULL);
 
-- 
1.7.9.5

