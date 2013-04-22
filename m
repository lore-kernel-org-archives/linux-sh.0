From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:14 +0000
Subject: [PATCH 11/35] ARM: shmobile: mackerel: Register pinctrl mapping for the ADXL34X
Message-Id: <1366671758-8954-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based ADXL34X pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 5b452e1..d252c6e 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1303,6 +1303,9 @@ static struct i2c_board_info i2c1_devices[] = {
 };
 
 static const struct pinctrl_map mackerel_pinctrl_map[] = {
+	/* ADXL34X */
+	PIN_MAP_MUX_GROUP_DEFAULT("1-0053", "pfc-sh7372",
+				  "intc_irq21", "intc"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1454,8 +1457,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ7_40,	NULL);
 	irq_set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
 
-	/* enable Accelerometer */
-	gpio_request(GPIO_FN_IRQ21,	NULL);
+	/* Accelerometer */
 	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
 
 	/* SDHI0 PORT172 card-detect IRQ26 */
-- 
1.8.1.5

