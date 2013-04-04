From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 04 Apr 2013 13:45:40 +0000
Subject: [PATCH 2/6] ARM: shmobile: Armadillo800EVA: Convert SCIFA1 to pinctrl
Message-Id: <1365083144-16085-2-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We use the new pinctrl framework now.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 81db74a..2914b6e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1036,6 +1036,9 @@ static struct platform_device *eva_devices[] __initdata = {
 };
 
 static const struct pinctrl_map eva_pinctrl_map[] = {
+	/* SCIFA1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.1", "pfc-r8a7740",
+				  "scifa1_data", "scifa1"),
 	/* LCD0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_lcdc_fb.0", "pfc-r8a7740",
 				  "lcd0_data24_0", "lcd0"),
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

