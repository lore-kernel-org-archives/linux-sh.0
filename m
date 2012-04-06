From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 06 Apr 2012 08:30:42 +0000
Subject: [PATCH 5/7 v2] ARM: mach-shmobile: armadillo800eva: add support ST1232
Message-Id: <87lim9jm8h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- same as v1 but based on linus/master

 arch/arm/mach-shmobile/board-armadillo800eva.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 5cc17a8..74213e3 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -149,6 +149,14 @@ static struct platform_device lcdc0_device = {
 	},
 };
 
+/* I2C */
+static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("st1232-ts", 0x55),
+		.irq = evt2irq(0x0340),
+	},
+};
+
 /*
  * board devices
  */
@@ -205,6 +213,11 @@ static void __init eva_init(void)
 	gpio_request(GPIO_PORT202, NULL); /* LCD0_LED_CONT */
 	gpio_direction_output(GPIO_PORT202, 0);
 
+	/* Touchscreen */
+	gpio_request(GPIO_FN_IRQ10,	NULL); /* TP_INT */
+	gpio_request(GPIO_PORT166,	NULL); /* TP_RST_B */
+	gpio_direction_output(GPIO_PORT166, 1);
+
 	/*
 	 * CAUTION
 	 *
@@ -219,6 +232,8 @@ static void __init eva_init(void)
 	l2x0_init(__io(0xf0002000), 0x40440000, 0x82000fff);
 #endif
 
+	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
+
 	r8a7740_add_standard_devices();
 
 	platform_add_devices(eva_devices,
-- 
1.7.5.4

