From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:52 +0000
Subject: [PATCH v3 32/64] ARM: shmobile: marzen: Register pinctrl mappings for HSPI
Message-Id: <1362740544-19164-33-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based HSPI pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fd313a8..7fa865f 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -329,6 +329,8 @@ void __init marzen_init_late(void)
 }
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-hspi.0", "pfc-r8a7779",
+				  "hspi0", "hspi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.2", "pfc-r8a7779",
 				  "scif2_data_c", "scif2"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.4", "pfc-r8a7779",
@@ -358,12 +360,6 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
 
-	/* HSPI 0 */
-	gpio_request(GPIO_FN_HSPI_CLK0,	NULL);
-	gpio_request(GPIO_FN_HSPI_CS0,	NULL);
-	gpio_request(GPIO_FN_HSPI_TX0,	NULL);
-	gpio_request(GPIO_FN_HSPI_RX0,	NULL);
-
 	/* USB (CN21) */
 	gpio_request(GPIO_FN_USB_OVC0, NULL);
 	gpio_request(GPIO_FN_USB_OVC1, NULL);
-- 
1.8.1.5

