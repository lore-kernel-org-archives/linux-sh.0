From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:50 +0000
Subject: [PATCH 09/37] ARM: shmobile: armadillo800eva: Register pinctrl mapping for INTC
Message-Id: <1366671618-8796-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based INTC pinmux configuration by a pinctrl mapping.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index bf4c3d2..8f103c4 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1058,6 +1058,12 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 				  "sdhi0_ctrl", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7740",
 				  "sdhi0_wp", "sdhi0"),
+	/* ST1232 */
+	PIN_MAP_MUX_GROUP_DEFAULT("0-0055", "pfc-r8a7740",
+				  "intc_irq10", "intc"),
+	/* USBHS */
+	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7740",
+				  "intc_irq7_1", "intc"),
 };
 
 static void __init eva_clock_init(void)
@@ -1119,7 +1125,6 @@ static void __init eva_init(void)
 	gpio_request_one(202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
 
 	/* Touchscreen */
-	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
 	gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
 
 	/* GETHER */
@@ -1153,13 +1158,11 @@ static void __init eva_init(void)
 	} else {
 		/* USB Func */
 		/*
-		 * A1 chip has 2 IRQ7 pin and it was controled by MSEL register.
-		 * OTOH, usbhs interrupt needs its value (HI/LOW) to decide
-		 * USB connection/disconnection (usbhsf_get_vbus()).
-		 * This means we needs to select GPIO_FN_IRQ7_PORT209 first,
-		 * and select GPIO 209 here
+		 * The USBHS interrupt handlers needs to read the IRQ pin value
+		 * (HI/LOW) to diffentiate USB connection and disconnection
+		 * events (usbhsf_get_vbus()). We thus need to select both the
+		 * intc_irq7_1 pin group and GPIO 209 here.
 		 */
-		gpio_request(GPIO_FN_IRQ7_PORT209, NULL);
 		gpio_request_one(209, GPIOF_IN, NULL);
 
 		platform_device_register(&usbhsf_device);
-- 
1.8.1.5

