From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 10 Jan 2013 19:47:54 +0000
Subject: [PATCH 3/8] ARM: shmobile: armadillo800eva: Use gpio_request_one()
Message-Id: <1357847279-7765-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace occurences of gpio_request() and gpio_direction_*() by calls to
gpio_request_one().

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   48 ++++++++---------------
 1 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index b6e50cd..01201c9 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -975,16 +975,12 @@ static void __init eva_init(void)
 	/* LCDC0 */
 	gpio_request(GPIO_FN_LCDC0_SELECT,	NULL);
 
-	gpio_request(GPIO_PORT61, NULL); /* LCDDON */
-	gpio_direction_output(GPIO_PORT61, 1);
-
-	gpio_request(GPIO_PORT202, NULL); /* LCD0_LED_CONT */
-	gpio_direction_output(GPIO_PORT202, 0);
+	gpio_request_one(GPIO_PORT61, GPIOF_OUT_INIT_HIGH, NULL); /* LCDDON */
+	gpio_request_one(GPIO_PORT202, GPIOF_OUT_INIT_LOW, NULL); /* LCD0_LED_CONT */
 
 	/* Touchscreen */
 	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
-	gpio_request(GPIO_PORT166,	NULL); /* TP_RST_B */
-	gpio_direction_output(GPIO_PORT166, 1);
+	gpio_request_one(GPIO_PORT166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
 
 	/* GETHER */
 	gpio_request(GPIO_FN_ET_CRS,		NULL);
@@ -1007,12 +1003,10 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_ET_RX_DV,		NULL);
 	gpio_request(GPIO_FN_ET_RX_CLK,		NULL);
 
-	gpio_request(GPIO_PORT18, NULL); /* PHY_RST */
-	gpio_direction_output(GPIO_PORT18, 1);
+	gpio_request_one(GPIO_PORT18, GPIOF_OUT_INIT_HIGH, NULL); /* PHY_RST */
 
 	/* USB */
-	gpio_request(GPIO_PORT159, NULL); /* USB_DEVICE_MODE */
-	gpio_direction_input(GPIO_PORT159);
+	gpio_request_one(GPIO_PORT159, GPIOF_IN, NULL); /* USB_DEVICE_MODE */
 
 	if (gpio_get_value(GPIO_PORT159)) {
 		/* USB Host */
@@ -1026,8 +1020,7 @@ static void __init eva_init(void)
 		 * and select GPIO_PORT209 here
 		 */
 		gpio_request(GPIO_FN_IRQ7_PORT209, NULL);
-		gpio_request(GPIO_PORT209, NULL);
-		gpio_direction_input(GPIO_PORT209);
+		gpio_request_one(GPIO_PORT209, GPIOF_IN, NULL);
 
 		platform_device_register(&usbhsf_device);
 		usb = &usbhsf_device;
@@ -1042,12 +1035,9 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_SDHI0_D3, NULL);
 	gpio_request(GPIO_FN_SDHI0_WP, NULL);
 
-	gpio_request(GPIO_PORT17, NULL);	/* SDHI0_18/33_B */
-	gpio_request(GPIO_PORT74, NULL);	/* SDHI0_PON */
-	gpio_request(GPIO_PORT75, NULL);	/* SDSLOT1_PON */
-	gpio_direction_output(GPIO_PORT17, 0);
-	gpio_direction_output(GPIO_PORT74, 1);
-	gpio_direction_output(GPIO_PORT75, 1);
+	gpio_request_one(GPIO_PORT17, GPIOF_OUT_INIT_LOW, NULL);  /* SDHI0_18/33_B */
+	gpio_request_one(GPIO_PORT74, GPIOF_OUT_INIT_HIGH, NULL); /* SDHI0_PON */
+	gpio_request_one(GPIO_PORT75, GPIOF_OUT_INIT_HIGH, NULL); /* SDSLOT1_PON */
 
 	/* we can use GPIO_FN_IRQ31_PORT167 here for SDHI0 CD irq */
 
@@ -1084,12 +1074,10 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_VIO_CKO,		NULL);
 
 	/* CON1/CON15 Camera */
-	gpio_request(GPIO_PORT173, NULL); /* STANDBY */
-	gpio_request(GPIO_PORT172, NULL); /* RST */
-	gpio_request(GPIO_PORT158, NULL); /* CAM_PON */
-	gpio_direction_output(GPIO_PORT173, 0);
-	gpio_direction_output(GPIO_PORT172, 1);
-	gpio_direction_output(GPIO_PORT158, 0); /* see mt9t111_power() */
+	gpio_request_one(GPIO_PORT173, GPIOF_OUT_INIT_LOW, NULL);  /* STANDBY */
+	gpio_request_one(GPIO_PORT172, GPIOF_OUT_INIT_HIGH, NULL); /* RST */
+	/* see mt9t111_power() */
+	gpio_request_one(GPIO_PORT158, GPIOF_OUT_INIT_LOW, NULL);  /* CAM_PON */
 
 	/* FSI-WM8978 */
 	gpio_request(GPIO_FN_FSIAIBT,		NULL);
@@ -1116,15 +1104,13 @@ static void __init eva_init(void)
 	 * DBGMD/LCDC0/FSIA MUX
 	 * DBGMD_SELECT_B should be set after setting PFC Function.
 	 */
-	gpio_request(GPIO_PORT176, NULL);
-	gpio_direction_output(GPIO_PORT176, 1);
+	gpio_request_one(GPIO_PORT176, GPIOF_OUT_INIT_HIGH, NULL);
 
 	/*
 	 * We can switch CON8/CON14 by SW1.5,
 	 * but it needs after DBGMD_SELECT_B
 	 */
-	gpio_request(GPIO_PORT6, NULL);
-	gpio_direction_input(GPIO_PORT6);
+	gpio_request_one(GPIO_PORT6, GPIOF_IN, NULL);
 	if (gpio_get_value(GPIO_PORT6)) {
 		/* CON14 enable */
 	} else {
@@ -1138,8 +1124,8 @@ static void __init eva_init(void)
 		gpio_request(GPIO_FN_SDHI1_CD,	NULL);
 		gpio_request(GPIO_FN_SDHI1_WP,	NULL);
 
-		gpio_request(GPIO_PORT16, NULL); /* SDSLOT2_PON */
-		gpio_direction_output(GPIO_PORT16, 1);
+		/* SDSLOT2_PON */
+		gpio_request_one(GPIO_PORT16, GPIOF_OUT_INIT_HIGH, NULL);
 
 		platform_device_register(&sdhi1_device);
 	}
-- 
1.7.8.6

