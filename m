From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:26 +0000
Subject: [PATCH 23/35] ARM: shmobile: ap4evb: Register pinctrl mapping for CEU
Message-Id: <1366671758-8954-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based CEU pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 45f78ca..f42e731 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -1086,6 +1086,9 @@ static struct i2c_board_info i2c1_devices[] = {
 
 
 static const struct pinctrl_map ap4evb_pinctrl_map[] = {
+	/* CEU */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_ceu.0", "pfc-sh7372",
+				  "ceu_clk_0", "ceu"),
 	/* MMCIF */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
 				  "mmc0_data8_0", "mmc0"),
@@ -1288,8 +1291,6 @@ static void __init ap4evb_init(void)
 	 */
 
 	/* MIPI-CSI stuff */
-	gpio_request(GPIO_FN_VIO_CKO, NULL);
-
 	clk = clk_get(NULL, "vck1_clk");
 	if (!IS_ERR(clk)) {
 		clk_set_rate(clk, clk_round_rate(clk, 13000000));
-- 
1.8.1.5

