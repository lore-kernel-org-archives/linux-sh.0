From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:24 +0000
Subject: [PATCH 21/35] ARM: shmobile: mackerel: Register pinctrl mapping for TCA6416
Message-Id: <1366671758-8954-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based TCA6416 pinmux configuration by a pinctrl
mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 51a5eb5..552284d 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1381,6 +1381,9 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* ST1232 */
 	PIN_MAP_MUX_GROUP_DEFAULT("0-0055", "pfc-sh7372",
 				  "intc_irq7_0", "intc"),
+	/* TCA6416 */
+	PIN_MAP_MUX_GROUP_DEFAULT("0-0020", "pfc-sh7372",
+				  "intc_irq9_0", "intc"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1458,8 +1461,7 @@ static void __init mackerel_init(void)
 		clk_put(clk);
 	}
 
-	/* enable Keypad */
-	gpio_request(GPIO_FN_IRQ9_42,	NULL);
+	/* Keypad */
 	irq_set_irq_type(IRQ9, IRQ_TYPE_LEVEL_HIGH);
 
 	/* Touchscreen */
-- 
1.8.1.5

