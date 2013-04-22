From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:23 +0000
Subject: [PATCH 20/35] ARM: shmobile: mackerel: Register pinctrl mapping for ST1232
Message-Id: <1366671758-8954-21-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based ST1232 pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f515c57..51a5eb5 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1378,6 +1378,9 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 				  "bsc_cs5a", "bsc"),
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-sh7372",
 				  "intc_irq6_0", "intc"),
+	/* ST1232 */
+	PIN_MAP_MUX_GROUP_DEFAULT("0-0055", "pfc-sh7372",
+				  "intc_irq7_0", "intc"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1459,8 +1462,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ9_42,	NULL);
 	irq_set_irq_type(IRQ9, IRQ_TYPE_LEVEL_HIGH);
 
-	/* enable Touchscreen */
-	gpio_request(GPIO_FN_IRQ7_40,	NULL);
+	/* Touchscreen */
 	irq_set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
 
 	/* Accelerometer */
-- 
1.8.1.5

