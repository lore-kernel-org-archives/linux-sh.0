From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:02:25 +0000
Subject: [PATCH 22/35] ARM: shmobile: mackerel: Register pinctrl mapping for USBHS
Message-Id: <1366671758-8954-23-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based USBHS pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-mackerel.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 552284d..26fbfd3 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1384,6 +1384,14 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	/* TCA6416 */
 	PIN_MAP_MUX_GROUP_DEFAULT("0-0020", "pfc-sh7372",
 				  "intc_irq9_0", "intc"),
+	/* USBHS0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.0", "pfc-sh7372",
+				  "usb0_vbus", "usb0"),
+	/* USBHS1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
+				  "usb1_vbus", "usb1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
+				  "usb1_otg_id_0", "usb1"),
 };
 
 #define GPIO_PORT9CR	IOMEM(0xE6051009)
@@ -1433,13 +1441,10 @@ static void __init mackerel_init(void)
 	gpio_request_one(151, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
 
 	/* USBHS0 */
-	gpio_request(GPIO_FN_VBUS0_0, NULL);
 	gpio_request_pulldown(GPIO_PORT168CR); /* VBUS0_0 pull down */
 
 	/* USBHS1 */
-	gpio_request(GPIO_FN_VBUS0_1, NULL);
 	gpio_request_pulldown(GPIO_PORT167CR); /* VBUS0_1 pull down */
-	gpio_request(GPIO_FN_IDIN_1_113, NULL);
 
 	/* FSI2 port A (ak4643) */
 	gpio_request_one(161, GPIOF_OUT_INIT_LOW, NULL); /* slave */
-- 
1.8.1.5

