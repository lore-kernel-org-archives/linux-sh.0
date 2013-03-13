From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:59:54 +0000
Subject: [PATCH v4 49/88] ARM: shmobile: marzen: Register pinctrl mappings for INTC
Message-Id: <1363215633-4264-50-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based INTC pinmux configuration by pinctrl mappings.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index b16f85f..5852331 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -25,7 +25,6 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/gpio.h>
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
@@ -349,6 +348,8 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
 				  "sdhi0_wp", "sdhi0"),
 	/* SMSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
+				  "intc_irq1_b", "intc"),
+	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
 				  "lbsc_ex_cs0", "lbsc"),
 	/* USB0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("ehci-platform.0", "pfc-r8a7779",
@@ -372,9 +373,6 @@ static void __init marzen_init(void)
 				  ARRAY_SIZE(marzen_pinctrl_map));
 	r8a7779_pinmux_init();
 
-	/* LAN89218 */
-	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
-
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
-- 
1.8.1.5

